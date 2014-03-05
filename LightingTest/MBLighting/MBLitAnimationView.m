//
//  MBLitAnimationView.h
//  LightingTest
//
//  Created by Michael Behan on 19/02/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "MBLitAnimationView.h"
#import <QuartzCore/QuartzCore.h>
#import "LightFixture.h"

@interface MBLitAnimationView()
{
    CIImage *currentFrameStartImage;
    NSArray *lastLightArray;
}

@end

@implementation MBLitAnimationView

-(void)setImage:(UIImage *)image
{
    imageView.image = image;
    currentFrameStartImage = [CIImage imageWithCGImage:image.CGImage];
}

- (void) animationShowFrame: (NSInteger) frame
{
	if ((frame >= animationNumFrames) || (frame < 0))
		return;
    
    NSData *imageData = [animationData objectAtIndex:frame];
    currentFrameStartImage = [CIImage imageWithData:imageData];
    [self applyLights:lastLightArray context:_lightingContext];
}

-(void)applyLights:(NSArray *)lights context:(CIContext *)coreImageContext
{
    lastLightArray = lights;
    if(!currentFrameStartImage)
    {
        NSData *data = [animationData objectAtIndex:self.currentFrameNumber];
        currentFrameStartImage = [CIImage imageWithData:data];
    }
    
    NSMutableArray *gradients = [[NSMutableArray alloc] initWithCapacity:[lights count]];
    
    for(NSObject<MBLightFixture> *light in lights)
    {
        
        CIColor *color0 = [CIColor colorWithCGColor:[[light tintColor] colorWithAlphaComponent:[[light intensity] floatValue]].CGColor];
        CIColor *color1 = [CIColor colorWithCGColor:[[light tintColor] colorWithAlphaComponent:0].CGColor];
        
        CGPoint inputPoint0 = [self convertPoint:[light position] fromView:self.superview];
        inputPoint0 = CGPointMake(inputPoint0.x, self.bounds.size.height - inputPoint0.y);
        
        CIFilter *gradientFilter = [CIFilter filterWithName:@"CIRadialGradient"
                                              keysAndValues:
                                    @"inputRadius0", [light constantIntensityOverRange] ? [light range] : @0.0,
                                    @"inputRadius1", [light range],
                                    @"inputCenter", [CIVector vectorWithCGPoint:inputPoint0],
                                    @"inputColor0", color0,
                                    @"inputColor1", color1, nil];
        
        CIImage *gradientImage = [gradientFilter outputImage];
        
        [gradients addObject:gradientImage];
    }
    
    if([gradients count] > 0)
    {
        
        CIFilter *darkenFilter = [CIFilter filterWithName:@"CIColorControls"
                                           keysAndValues:
                                 @"inputImage", currentFrameStartImage,
                                 @"inputSaturation", @1.0,
                                 @"inputContrast", @1.0,
                                 @"inputBrightness", @(0-(1-_ambientLightLevel)), nil];
        
        //first light
        CIFilter *lightFilter = [CIFilter filterWithName:@"CIAdditionCompositing"
                                 keysAndValues:
                       @"inputImage", gradients[0],
                       @"inputBackgroundImage",[darkenFilter outputImage],nil];
        
        //other lights
        for(int i = 1; i < [gradients count]; i++)
        {
            
            lightFilter = [CIFilter filterWithName:@"CIAdditionCompositing"
                                     keysAndValues:
                           @"inputImage", gradients[i],
                           @"inputBackgroundImage",[lightFilter outputImage],nil];
        }
        
        //mask it
        CIFilter *maskFilter = [CIFilter filterWithName:@"CISourceInCompositing"
                                      keysAndValues:
                            @"inputImage", [lightFilter outputImage],
                            @"inputBackgroundImage",currentFrameStartImage,nil];
        
        
        
        CGImageRef cgimg = [coreImageContext createCGImage:[maskFilter outputImage]
                                                  fromRect:[currentFrameStartImage extent]];
        
        UIImage *newImage = [UIImage imageWithCGImage:cgimg];
        imageView.image = newImage;
        
        CGImageRelease(cgimg);
        
    }
    else
    {
        imageView.image = [UIImage imageWithCIImage:currentFrameStartImage];
    }
}

@end
