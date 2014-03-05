//
//  SimpleLightView.h
//  LightingTest
//
//  Created by Michael Behan on 19/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightFixture.h"

@interface SimpleLightView : UIView <MBLightFixture>

@property(nonatomic) BOOL constantIntensityOverRange;
@property(nonatomic, strong) NSNumber *intensity;
@property(nonatomic, strong) NSNumber *range;
@property(nonatomic, strong) UIColor *tintColor;

@end
