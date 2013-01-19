//
//  STAppDelegate.h
//  stitch
//
//  Created by Alexander List on 1/18/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STViewController;
@interface STAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) STViewController *viewController;

@end
