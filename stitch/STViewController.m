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
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"background.png"];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
