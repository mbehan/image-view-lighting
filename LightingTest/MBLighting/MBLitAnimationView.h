//
//  MBLitAnimationView.h
//  LightingTest
//
//  Created by Michael Behan on 19/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "MBAnimationView.h"

@interface MBLitAnimationView : MBAnimationView

@property (nonatomic, weak) CIContext *lightingContext;
@property (nonatomic) float ambientLightLevel;

-(void)applyLights:(NSArray *)lights context:(CIContext *)coreImageContext;

@end
