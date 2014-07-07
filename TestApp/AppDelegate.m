//
//  AppDelegate.m
//  TestApp
//
//  Created by Robert Figueras on 9/10/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import "AppDelegate.h"
#import "Level.h"
#import "QuizViewController.h"
#import "MKStoreManager.h"
#import "Flurry.h"

@implementation AppDelegate {

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"7GWTNGBRRW5YZN6T35K4"];
    
    [MKStoreManager sharedManager];
    
    // save current level in a plist file into directories path
    NSString *nameOfSavedLevelPlist = @"CurrentSavedLevel.plist";
    NSArray *mySavedLevelPlistPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *mySavedLevelPlistFilePath = [[mySavedLevelPlistPathArray objectAtIndex:0] stringByAppendingPathComponent:nameOfSavedLevelPlist];

    BOOL doesCurrentSavedLevelPlistExist = [[NSFileManager defaultManager] fileExistsAtPath:mySavedLevelPlistFilePath];

    if (!doesCurrentSavedLevelPlistExist) {
        
    NSString *myCurrentSavedLevelPath =[[NSBundle mainBundle] pathForResource:@"DefaultCurrentSavedLevel" ofType: @"plist"];
    NSMutableArray *myCurrentSavedLevelArray = [[NSMutableArray alloc] initWithContentsOfFile:myCurrentSavedLevelPath];
    NSNumber *currentSavedLevelObject = [myCurrentSavedLevelArray objectAtIndex:0];
    int currentSavedLevel = [currentSavedLevelObject intValue];
    
    int nextLevel = currentSavedLevel;
    NSString *nextLevelString = [NSString stringWithFormat:@"%d",nextLevel];
    
    NSMutableArray *myNextLevelArrayToBeSaved = [[NSMutableArray alloc]initWithObjects:nextLevelString, nil];
    
    [myNextLevelArrayToBeSaved writeToFile:mySavedLevelPlistFilePath atomically:YES];
        
    }
    return YES;
}


@end
