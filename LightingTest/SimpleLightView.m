//
//  SimpleLightView.m
//  LightingTest
//
//  Created by Michael Behan on 19/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "SimpleLightView.h"

@implementation SimpleLightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    self.backgroundColor = tintColor;
}

-(CGPoint) position
{
    return self.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
