//
//  CongratsViewController.m
//  TestApp
//
//  Created by Robert Figueras on 10/8/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import "CongratsViewController.h"
#import "AppDelegate.h"


@interface CongratsViewController ()
{
    UIColor *labelBackgroundColor;
    int currentlyPlayingLevel;
}
@end


@implementation CongratsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    currentlyPlayingLevel = [myAppDelegate.playThisLevel intValue];
    
    // set up completed level label
    NSString *completeLevelText = [NSString stringWithFormat:@"LEVEL %d COMPLETE",currentlyPlayingLevel];
    CGAffineTransform transform = CGAffineTransformScale(self.CompleteLabel.transform,0.1, 0.1);
    self.CompleteLabel.transform = transform;
    labelBackgroundColor = self.CompleteLabel.backgroundColor;
    [self.CompleteLabel setBackgroundColor:self.view.backgroundColor];
    [self.CompleteLabel setTextColor:self.view.backgroundColor];
    
    // set up random message label
    NSMutableArray *messagesArray = [[NSMutableArray alloc]initWithObjects:@"Hmmm, I think you got lucky on that one",
                                     @"You must think you're cool, right?",
                                     @"Okay, I'll give you that one",
                                     @"I better make the levels harder for you",
                                     @"You are smarter than I anticipated",
                                     nil];
    int myRandomMessage = arc4random() % [messagesArray count];
    NSString *myRandomMessageString = [messagesArray objectAtIndex:myRandomMessage];
    if (currentlyPlayingLevel == 16)
    {
        completeLevelText = @"ALL LEVELS COMPLETE";
        myRandomMessageString = @"Thank you for playing. \nMore levels coming soon!";
    }
    
    [self.CompleteLabel setText:completeLevelText];
    [self.messageLabel setText:myRandomMessageString];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [UIView animateWithDuration: 0.4
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGAffineTransform newTransform = CGAffineTransformScale(self.CompleteLabel.transform, 10.0, 10.0);
                         self.CompleteLabel.transform = newTransform;
                         [self.CompleteLabel setBackgroundColor:labelBackgroundColor];
                         [self.CompleteLabel setTextColor:[UIColor whiteColor]];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration: 0.3
                                               delay: 0.0
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.bragButton setAlpha:1.0];
                                              [self.rateUsButton setAlpha:1.0];
                                              
                                              [self.CompleteLabel setCenter:CGPointMake(self.CompleteLabel.center.x, self.CompleteLabel.center.y - 50)];
                                              [self.bragButton setCenter:CGPointMake(self.bragButton.center.x, self.bragButton.center.y + 150)];
                                              [self.rateUsButton setCenter:CGPointMake(self.rateUsButton.center.x, self.rateUsButton.center.y + 150)];
                                          }
                                          completion:nil];
                         
                         [UIView animateWithDuration: 1.0
                                               delay: 0.4
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.messageLabel setAlpha:1.0];
                                          }
                                          completion:nil];
                     }];
}


-(IBAction)sharesheet:(id)sender{
    
    NSString *bragText = [NSString stringWithFormat:@"I just completed LEVEL %d in FeedBack! http://bit.ly/15YI61u",currentlyPlayingLevel];
    
    UIImage *bragImage = [UIImage imageNamed:@"AppIcon29x29.png"];
    
    UIActivityViewController *objVC = [[UIActivityViewController alloc]initWithActivityItems:[NSArray arrayWithObjects:bragText, bragImage, nil] applicationActivities:nil];
    objVC.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact, UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop, UIActivityTypeCopyToPasteboard, nil];
    [self presentViewController:objVC animated:YES completion:nil];
    
    [objVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if (completed)
         {
             UIAlertView *objAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Post successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [objAlert show];
             objAlert = nil;
         }
         else
         {
             UIAlertView *objAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Post NOT completed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [objAlert show];
             objAlert = nil;
         }
     }];
}


- (IBAction)rateMe{
    NSString *appid = @"721865420";
    NSString* url = [NSString stringWithFormat:  @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appid];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

@end
