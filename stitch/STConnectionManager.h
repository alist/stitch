//
//  STConnectionManager.h
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"

@protocol STConnectionManagerDelegate <NSObject>
-(void)updateImageViewWithImage:(UIImage *)image origin:(CGPoint)origin;
@end

@interface STConnectionManager : NSObject<SocketIODelegate> {
    SocketIO *socket;
    
    NSString *lastImageURL;
    UIImage *lastImage;
}
@property(nonatomic, weak) id<STConnectionManagerDelegate> delegate;

+(STConnectionManager *)sharedManager;
-(void)connect;
-(void)sendSwypIn:(BOOL)swypIn view:(UIView *)view point:(CGPoint)point;

@end
