//
//  ViewController.m
//  LightingTest
//
//  Created by Michael Behan on 12/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "ViewController.h"
#import "MBLitAnimationView.h"
#import "SimpleLightView.h"
#import "MBRope.h"
#import "MBLightingController.h"
#import "MBAnimationView.h"

@interface ViewController ()
{
    UIDynamicAnimator *animator;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lightingController = [[MBLightingController alloc] init];
    
    SimpleLightView *slv = [[SimpleLightView alloc] initWithFrame:CGRectMake(200, 200, 25, 25)];
    [self.view addSubview:slv];
    [_lightingController addLightFixture:slv];
    
    slv.intensity = @0.8;
    slv.tintColor = [UIColor whiteColor];
    slv.range = @250.0;
    
    [_animationView playAnimation: @"spineboy-walk"
                       withRange : NSMakeRange(0, 16)
                  numberPadding  : 0
                          ofType : @"png"
                             fps : 25
                          repeat : kMBAnimationViewOptionRepeatForever
                      completion : nil];
    
    [_lightingController addLitView:_animationView];
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [animator addBehavior:gravity];
    [gravity addItem: slv];
    
    //create rope for light
    
    MBRope *rope = [[MBRope alloc] initWithFrame:CGRectMake(350, 180, 5, 200) numSegments:15];
    [self.view addSubview:rope];
    [rope addRopeToAnimator:animator];
    
    UIAttachmentBehavior *a1 = [[UIAttachmentBehavior alloc] initWithItem:slv offsetFromCenter:UIOffsetMake(0, -slv.bounds.size.height / 2.0) attachedToItem:[rope attachmentView] offsetFromCenter:UIOffsetMake(0, 0)];
    
    [a1 setLength:0];
    [a1 setDamping:INT_MAX];
    [a1 setFrequency:INT_MAX];
    
    [animator addBehavior:a1];
    
    [self.view bringSubviewToFront:slv];
    
    _lightingController.lightsConstantlyUpdating = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
