//
//  LightingViewController.h
//  LightingTest
//
//  Created by Michael Behan on 25/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightFixture.h"

@class MBLitAnimationView;

@interface MBLightingController : NSObject

@property(nonatomic) BOOL lightsConstantlyUpdating;

-(void)addLightFixture:(id<MBLightFixture>)light;
-(void)addLitView:(MBLitAnimationView *)litView;
-(void)setNeedsLightingUpdate;

@end
