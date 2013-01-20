//
//  STViewController.h
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STConnectionManager.h"
#import "STTokView.h"
#import "swypWorkspaceBackgroundView.h"

@interface STViewController : UIViewController<UIGestureRecognizerDelegate, STConnectionManagerDelegate, UIActionSheetDelegate> {
    UIImageView *imageView;
	STTokView * tokView;
	swypWorkspaceBackgroundView * fingerDrawView;
}

@end
