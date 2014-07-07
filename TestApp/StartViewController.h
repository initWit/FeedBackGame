//
//  StartViewController.h
//  TestApp
//
//  Created by Robert Figueras on 10/3/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *StartBackgroundUmageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightStartView;
@property (weak, nonatomic) IBOutlet UIImageView *leftStartView;
- (IBAction)zoomIn:(id)sender;
@end
