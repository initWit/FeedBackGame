//
//  AppDelegate.h
//  TestApp
//
//  Created by Robert Figueras on 9/10/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSNumber *currentLevel; // used for identifying last unlocked level

@property (strong, nonatomic) NSNumber *playThisLevel; //


@end
