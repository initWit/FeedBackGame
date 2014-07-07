//
//  StartViewController.m
//  TestApp
//
//  Created by Robert Figueras on 10/3/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import "StartViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIView animateWithDuration: 2.0
                          delay: 1.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.StartBackgroundUmageView setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration: 0.1
                                               delay: 0.0
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.startButton setAlpha:1.0];
                                          }
                                          completion:nil];
                     }
     ];
}


#pragma mark - helper methods
- (UIImage*) blur:(UIImage*)theImage
{
    // create blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    return [UIImage imageWithCGImage:cgImage];
    
    // if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}


- (IBAction)zoomIn:(id)sender{
    
    [UIView animateWithDuration: 0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                        [self.leftStartView setCenter:CGPointMake(self.leftStartView.center.x-200.0, self.leftStartView.center.y)];
                        [self.rightStartView setCenter:CGPointMake(self.rightStartView.center.x+200.0, self.rightStartView.center.y)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];

    [self performSegueWithIdentifier: @"gotoLevelsMenu" sender: self];
}

@end
