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
#import "swypWorkspaceBackgroundView.h"

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
    	
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:imageView];
    
	swypWorkspaceBackgroundView * fingerDrawView = [[swypWorkspaceBackgroundView alloc] initWithFrame:self.view.bounds];
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
    
    [[STConnectionManager sharedManager] setDelegate:self];
}


-(void)	swypGestureChanged:(swypGestureRecognizer *)recognizer{
	if (recognizer.state == UIGestureRecognizerStateRecognized){
        [[STConnectionManager sharedManager] sendSwypIn:[recognizer isKindOfClass:[swypInGestureRecognizer class]]
                                                   view:self.view
                                                  point:recognizer.swypGestureInfo.endPoint];
	}
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
	return [gestureRecognizer isKindOfClass:[swypGestureRecognizer class]];
}

-(void)updateImageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    imageView.image = image;
    imageView.frame = frame;
    NSLog(@"updated image view to %@ :: %@ // %@",imageView, image, NSStringFromCGRect(imageView.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
