//
//  STViewController.h
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STConnectionManager.h"

@interface STViewController : UIViewController<UIGestureRecognizerDelegate, STConnectionManagerDelegate> {
    UIImageView *imageView;
}

@end
