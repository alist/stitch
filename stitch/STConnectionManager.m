//
//  STConnectionManager.m
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "STConnectionManager.h"

@implementation STConnectionManager

+ (STConnectionManager *)sharedManager {
    static STConnectionManager *sharedManager;
    @synchronized(self) {
        if (!sharedManager)
            sharedManager = [[STConnectionManager alloc] init];

        return sharedManager;
    }
}


-(id)init {
    self = [super init];
    if(self) {
        // connect to socket.io here....
    }
    return self;
}

-(void)sendSwypIn:(BOOL)swypIn view:(UIView *)view point:(CGPoint)point {
    int width = view.bounds.size.width;
    int height = view.bounds.size.height;
    
    // convert from top-left origin to bottom-left origin
    int x = (int)point.x;
    int y = height - (int)point.y;
    
    NSLog(@"sending swype in: %i width %i height %i point %i %i",swypIn,width,height,x,y);
}

@end
