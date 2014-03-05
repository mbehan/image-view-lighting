//
//  LightFixture.h
//  LightingTest
//
//  Created by Michael Behan on 19/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MBLightFixture <NSObject>

@required
-(CGPoint)position;
-(NSNumber *)intensity;
-(NSNumber *)range;
-(UIColor *)tintColor;
-(BOOL)constantIntensityOverRange;

@end
