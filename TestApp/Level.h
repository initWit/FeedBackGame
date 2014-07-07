//
//  Level.h
//  TestApp
//
//  Created by Robert Figueras on 9/15/13.
//  Copyright (c) 2013 AppSpaceship. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

@property (nonatomic, copy) NSString *levelTitle;

@property (nonatomic, copy) NSMutableArray *Question1;
@property (nonatomic, copy) NSMutableArray *Question2;
@property (nonatomic, copy) NSMutableArray *Question3;
@property (nonatomic, copy) NSMutableArray *Question4;
@property (nonatomic, copy) NSMutableArray *Question5;
@property (nonatomic, copy) NSMutableArray *Question6;
@property (nonatomic, copy) NSMutableArray *Question7;
@property (nonatomic, copy) NSMutableArray *Question8;
@property (nonatomic, copy) NSMutableArray *Question9;
@property (nonatomic, copy) NSMutableArray *Question10;

@property (nonatomic, copy) NSString *tile1;
@property (nonatomic, copy) NSString *tile2;
@property (nonatomic, copy) NSString *tile3;
@property (nonatomic, copy) NSString *tile4;

@property (nonatomic, copy) NSString *answer;

@end
