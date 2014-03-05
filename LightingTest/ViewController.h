//
//  ViewController.h
//  LightingTest
//
//  Created by Michael Behan on 12/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

@class MBLitAnimationView;
@class MBLightingController;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MBLitAnimationView *animationView;
@property (strong, nonatomic) MBLightingController *lightingController;

@end
