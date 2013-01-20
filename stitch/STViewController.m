//
//  STViewController.m
//  stitch
//
//  Created by Ishaan Gulrajani on 1/19/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "STViewController.h"
#import "swypInGestureRecognizer.h"
#import "swypOutGestureRecognizer.h"
#import "STConnectionManager.h"

@interface STViewController ()

@end

@implementation STViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"background.png"];
    background.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:background];
    
    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:imageView];
    
	fingerDrawView = [[swypWorkspaceBackgroundView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:fingerDrawView];
	
    swypInGestureRecognizer *swypInRecognizer = [[swypInGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(swypGestureChanged:)];
    [swypInRecognizer setDelegate:self];
    [swypInRecognizer setDelaysTouchesBegan:NO];
    [swypInRecognizer setDelaysTouchesEnded:NO];
    [swypInRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:swypInRecognizer];

    swypOutGestureRecognizer *swypOutRecognizer = [[swypOutGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swypGestureChanged:)];
    [swypOutRecognizer setDelegate:self];
    [swypOutRecognizer setDelaysTouchesBegan:NO];
    [swypOutRecognizer setDelaysTouchesEnded:NO];
    [swypOutRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:swypOutRecognizer];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tapGestureTriggered)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setDelaysTouchesBegan:NO];
    [tapRecognizer setDelaysTouchesEnded:NO];
    [tapRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [[STConnectionManager sharedManager] setDelegate:self];
}


-(void)	swypGestureChanged:(swypGestureRecognizer *)recognizer{
	if (recognizer.state == UIGestureRecognizerStateRecognized){
        [[STConnectionManager sharedManager] sendSwypIn:[recognizer isKindOfClass:[swypInGestureRecognizer class]]
                                                   view:self.view
                                                  point:recognizer.swypGestureInfo.endPoint];
	}
}

-(void)tapGestureTriggered {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Load image", @"Show TokBox", nil];
    
    [actionSheet showInView:self.view];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) { // Load image
        [[STConnectionManager sharedManager] sendImageContentURL:@"http://i.imgur.com/LS7csQT.jpg"];
    } else if(buttonIndex == 1) { // Unload content
        [[STConnectionManager sharedManager] sendImageContentURL:@"about:tok"];
    }
}

-(void)updateImageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    imageView.image = image;
    
    [self.view bringSubviewToFront:imageView];
    [self.view bringSubviewToFront:fingerDrawView];
    
    [UIView beginAnimations:@"animations" context:@"context"];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];

    if(frame.size.width == 0 && frame.size.height == 0)
        imageView.frame = self.view.bounds;
    else
        imageView.frame = frame;
    
    [UIView commitAnimations];
    
    NSLog(@"updated image view to %@ :: %@ // %@",imageView, image, NSStringFromCGRect(imageView.frame));
}

-(void)displayTokViewWithFrame:(CGRect)frame{
	if (tokView == nil){
		tokView = [[STTokView alloc] initWithFrame:frame];
		[self.view addSubview:tokView];
	}
	

    [self.view bringSubviewToFront:tokView];
    [self.view bringSubviewToFront:fingerDrawView];

	[UIView beginAnimations:@"animations" context:@"context"];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];

	if(frame.size.width == 0 && frame.size.height == 0)
        tokView.frame = self.view.bounds;
    else
        tokView.frame = frame;
    
	[UIView commitAnimations];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
