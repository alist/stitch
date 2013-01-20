//
//  STConnectionManager.m
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "STConnectionManager.h"
#import "SocketIOPacket.h"

@implementation STConnectionManager

+ (STConnectionManager *)sharedManager {
    static STConnectionManager *sharedManager;
    @synchronized(self) {
        if (!sharedManager)
            sharedManager = [[STConnectionManager alloc] init];

        return sharedManager;
    }
}


-(void)connect {
    socket = [[SocketIO alloc] initWithDelegate:self];
    [socket connectToHost:@"stitch-server.herokuapp.com" onPort:80];
}

-(void)sendSwypIn:(BOOL)swypIn view:(UIView *)view point:(CGPoint)point {
    int width = view.bounds.size.width;
    int height = view.bounds.size.height;
    
    // convert from top-left origin to bottom-left origin
    int x = (int)point.x;
    int y = height - (int)point.y;
    
    NSLog(@"OLD X AND Y %i %i",x,y);
    
    // scale coordinates to compensate for touchscreen insensitivity
    double a = 100.0;
    double b = 0.0;
    x = (int)round((2*a*x/width)+x-a);
    y = (int)round((2*b*y/height)+y-b);
    NSLog(@"NEW X AND Y %i %i",x,y);
    
    
    NSLog(@"sending swype in: %i width %i height %i point %i %i",swypIn,width,height,x,y);
    
    [socket sendEvent:@"swypOccurred" withData:@{
     @"screenSize": @{@"width": [NSNumber numberWithInt:width], @"height": [NSNumber numberWithInt:height]},
     @"swypPoint": @{@"x": [NSNumber numberWithInt:x], @"y": [NSNumber numberWithInt:y]},
     @"direction": (swypIn ? @"in" : @"out")
     }];
}

-(void)sendImageContentURL:(NSString *)url {
    [socket sendEvent:@"setContent" withData:@{@"contentURL": url}];
}

-(void)socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet {
    NSLog(@"recieving json!");
}

-(void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    
    NSString *name = [(NSDictionary *)packet.name allKeys][0];
    
    if(![name isEqualToString:@"updateDisplay"])
        return;
    
    NSDictionary *data = ((NSDictionary *)packet.name)[@"updateDisplay"];

    NSString *url = data[@"url"];
    CGSize boundary = CGSizeMake([data[@"boundarySize"][@"width"] doubleValue],
                                 [data[@"boundarySize"][@"height"] doubleValue]);
    CGSize screen = CGSizeMake([data[@"screenSize"][@"width"] doubleValue],
                               [data[@"screenSize"][@"height"] doubleValue]);
    CGPoint origin = CGPointMake([data[@"origin"][@"x"] doubleValue],
                                 [data[@"origin"][@"y"] doubleValue]);

    CGRect frame = CGRectMake(-origin.x,
                              origin.y + screen.height - boundary.height,
                              boundary.width,
                              boundary.height);


    if([url isEqualToString:@"about:blank"]) {
        [self.delegate updateImageViewWithImage:nil frame:frame];
    } else if([url isEqualToString:@"about:tok"]) {
        [self.delegate displayTokViewWithFrame:frame];
    } else { // default to image URLs
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate updateImageViewWithImage:image frame:frame];
            });        
        });
    }
}

@end
