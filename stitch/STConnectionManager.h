//
//  STConnectionManager.h
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STConnectionManager : NSObject

+(STConnectionManager *)sharedManager;
-(void)sendSwypIn:(BOOL)swypIn view:(UIView *)view point:(CGPoint)point;

@end
