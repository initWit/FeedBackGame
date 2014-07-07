//
//  CongratsViewController.h
//  TestApp
//
//  Created by Robert Figueras on 10/8/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CongratsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *CompleteLabel;
@property (weak, nonatomic) IBOutlet UIButton *bragButton;
@property (weak, nonatomic) IBOutlet UIButton *rateUsButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (IBAction)rateMe;

@end
