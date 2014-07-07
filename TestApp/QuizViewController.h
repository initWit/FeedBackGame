//
//  QuizViewController.h
//  TestApp
//
//  Created by Robert Figueras on 10/2/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController

{
    int currentQuestionNumber;
    int currentAnswer;
    int currentScore;
}

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *Tile1_button;
@property (strong, nonatomic) IBOutlet UIButton *Tile2_button;
@property (strong, nonatomic) IBOutlet UIButton *Tile3_button;
@property (strong, nonatomic) IBOutlet UIButton *Tile4_button;

@property (weak, nonatomic) IBOutlet UILabel *QuestionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIProgressView *scoreProgressBar;

@property (weak, nonatomic) IBOutlet UILabel *tapCounterLabel;
@property (weak, nonatomic) IBOutlet UIButton *IAP_button;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

-(IBAction)evaluate:(UIButton*)sender;
-(IBAction)purchaseIAPandShowAnswer:(id)sender;
-(IBAction)goBackToCollectionView:(id)sender;

@end
