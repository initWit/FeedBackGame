//
//  QuizViewController.m
//  TestApp
//
//  Created by Robert Figueras on 10/2/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate.h"
#import "Level.h"
#import "AudioToolbox/AudioServices.h"
#import <QuartzCore/QuartzCore.h>
#import "MKStoreManager.h"


@interface QuizViewController ()
{
    NSMutableArray *myCurrentLevelPlistArray;
    int currentlyPlayingLevel;
    int tapCounter;
}
@end


@implementation QuizViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.oneButton.layer.cornerRadius = 44;
    self.oneButton.clipsToBounds = YES;
    self.oneButton.layer.borderWidth = 1.0;
    self.oneButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.twoButton.layer.cornerRadius = 44;
    self.twoButton.clipsToBounds = YES;
    self.twoButton.layer.borderWidth = 1.0;
    self.twoButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    currentlyPlayingLevel = [myAppDelegate.playThisLevel intValue];
    
    NSString *stringOfCurrentLevel = [NSString stringWithFormat:@"%d",currentlyPlayingLevel];
    NSString *myPrefix = @"Level";
    NSString *mySuffix = @"Array";
    NSString *nameOfLevelPlist = [[myPrefix stringByAppendingString:stringOfCurrentLevel]stringByAppendingString:mySuffix];
    NSString *myCurrentLevelPlistPath =[[NSBundle mainBundle] pathForResource:nameOfLevelPlist ofType: @"plist"];
    
	myCurrentLevelPlistArray = [[NSMutableArray alloc] initWithContentsOfFile:myCurrentLevelPlistPath];
    
    NSString *currentLevelNameObject = [myCurrentLevelPlistArray objectAtIndex:0];
    self.TitleLabel.text = currentLevelNameObject;
    
    currentQuestionNumber = 1;
    currentScore = 0;
    
    // extract questions from array
    int indexCalcForTile1 = (currentQuestionNumber + ((currentQuestionNumber-1)*4));
    int indexCalcForTile2 = (indexCalcForTile1+1);
    int indexCalcForTile3 = (indexCalcForTile1+2);
    int indexCalcForTile4 = (indexCalcForTile1+3);
    
    NSString *tile1Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile1];
    NSString *tile2Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile2];
    NSString *tile3Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile3];
    NSString *tile4Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile4];
    
    currentAnswer = [[myCurrentLevelPlistArray objectAtIndex:(indexCalcForTile4+1)] intValue];

    [self.Tile1_button setTitle:tile1Text forState:UIControlStateNormal];
    [self.Tile2_button setTitle:tile2Text forState:UIControlStateNormal];
    [self.Tile3_button setTitle:tile3Text forState:UIControlStateNormal];
    [self.Tile4_button setTitle:tile4Text forState:UIControlStateNormal];
    
    self.QuestionNumberLabel.text = [NSString stringWithFormat:@"%d",currentQuestionNumber];
    self.ScoreLabel.text =[NSString stringWithFormat:@"%d",currentScore];
    
    tapCounter = 0;
    self.tapCounterLabel.text =[NSString stringWithFormat:@"%d",tapCounter];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view setBackgroundColor:[UIColor whiteColor]];
                     }
                     completion:nil];
    
    [UIView animateWithDuration: 0.5
                          delay: 0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.TitleLabel setAlpha:0.0];
                     }
                     completion:nil];
}


#pragma mark - evalution methods
-(IBAction)evaluate:(UIButton*)sender
{
    if (sender.tag == currentAnswer)
    {
        currentScore = currentScore + 1;
        
        [UIView beginAnimations:@"fade" context:nil];
        [UIView setAnimationDuration:2];
        [[self view] setBackgroundColor: [UIColor greenColor]];
        [[self view] setBackgroundColor: [UIColor whiteColor]];
        [UIView commitAnimations];
    }
    else
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        currentScore = 0;
        
        [UIView beginAnimations:@"fade" context:nil];
        [UIView setAnimationDuration:2];
        [[self view] setBackgroundColor: [UIColor redColor]];
        [[self view] setBackgroundColor: [UIColor whiteColor]];
        [UIView commitAnimations];
    }
    
    self.ScoreLabel.text =[NSString stringWithFormat:@"%d",currentScore];
    
    if (currentQuestionNumber == 10)
    {
        currentQuestionNumber = 1;
    }
    else
    {
        currentQuestionNumber = currentQuestionNumber + 1;
    }
    
    tapCounter = tapCounter + 1;
    self.tapCounterLabel.text =[NSString stringWithFormat:@"%d",tapCounter];
    
    if (tapCounter == 6) {
        [UIView animateWithDuration: 1.0
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.IAP_button setAlpha:1.0];
                         }
                         completion:nil];
    }
    
    if (tapCounter == 10 && self.IAP_button.alpha == 1.0)
    {
        [UIView animateWithDuration: 1.0
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.IAP_button setTitle:@"Are you stuck? Buy the answer." forState:UIControlStateNormal];
                         }
                         completion:nil];
    }
    
    [self resetTilesAnswerForNextQuestion];
}


#pragma mark - reset methods
- (void) resetTilesAnswerForNextQuestion {
    
    int indexCalcForTile1 = (currentQuestionNumber + ((currentQuestionNumber-1)*4));
    int indexCalcForTile2 = (indexCalcForTile1+1);
    int indexCalcForTile3 = (indexCalcForTile1+2);
    int indexCalcForTile4 = (indexCalcForTile1+3);
    
    NSString *tile1Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile1];
    NSString *tile2Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile2];
    NSString *tile3Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile3];
    NSString *tile4Text = [myCurrentLevelPlistArray objectAtIndex:indexCalcForTile4];
    
    currentAnswer = [[myCurrentLevelPlistArray objectAtIndex:(indexCalcForTile4+1)] intValue];
    
    [self.Tile1_button setTitle:tile1Text forState:UIControlStateNormal];
    [self.Tile2_button setTitle:tile2Text forState:UIControlStateNormal];
    [self.Tile3_button setTitle:tile3Text forState:UIControlStateNormal];
    [self.Tile4_button setTitle:tile4Text forState:UIControlStateNormal];
    
    self.QuestionNumberLabel.text = [NSString stringWithFormat:@"%d",currentQuestionNumber];
    
    CGFloat scoreProgress = currentScore/10.0;
    
    self.scoreProgressBar.progress = scoreProgress;
    
    if (currentScore == 10) {
        
        // get the saved plist from the documents directory
        NSString *nameOfSavedLevelPlist = @"CurrentSavedLevel.plist";
        NSArray *mySavedLevelPlistPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *mySavedLevelPlistFilePath = [[mySavedLevelPlistPathArray objectAtIndex:0] stringByAppendingPathComponent:nameOfSavedLevelPlist];
        
        // get the value form the saved plist
        NSMutableArray *myCurrentSavedLevelArray = [[NSMutableArray alloc] initWithContentsOfFile:mySavedLevelPlistFilePath];
        NSNumber *currentSavedLevelObject = [myCurrentSavedLevelArray objectAtIndex:0];

        int currentSavedLevel = [currentSavedLevelObject intValue];
        
        if (currentlyPlayingLevel == currentSavedLevel) {
            int nextLevel = currentSavedLevel + 1;
            NSString *nextLevelString = [NSString stringWithFormat:@"%d",nextLevel];
            
            NSMutableArray *myNextLevelArrayToBeSaved = [[NSMutableArray alloc]initWithObjects:nextLevelString, nil];
            [myNextLevelArrayToBeSaved writeToFile:mySavedLevelPlistFilePath atomically:YES];
        }
        [self performSegueWithIdentifier: @"CongratsSegue" sender: self];
    }
}


#pragma mark - IAP methods
- (IBAction)purchaseIAPandShowAnswer:(id)sender{
    
    [[MKStoreManager sharedManager] buyFeature:kConsumableAnswer
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         NSString *answerForThisLevel = [myCurrentLevelPlistArray objectAtIndex:51];
         UIAlertView *answerAlert;
         answerAlert = [[UIAlertView alloc] initWithTitle:@"ANSWER"
                                                  message:answerForThisLevel
                                                 delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
         [answerAlert show];
         [self.IAP_button setAlpha:0.0];
     }
     onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
     }];

}


#pragma mark - navigation methods
- (IBAction)goBackToCollectionView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
