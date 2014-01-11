//
//  SetCard.h
//  MatchDat
//
//  Created by Joseph Smith on 1/10/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

+ (NSArray *) validNumbers;
+ (NSArray *) validSymbols;
+ (NSArray *) validShading;
+ (NSArray *) validColors;

extern NSString *SET_SYMBOL_DIAMOND;// = @"▲";
extern NSString *SET_SYMBOL_SQUIGGLE;// = @"●";
extern NSString *SET_SYMBOL_OVAL;// = @"■";

extern NSString *SET_SHADING_SOLID;
extern NSString *SET_SHADING_STRIPED;
extern NSString *SET_SHADING_OPEN;

extern NSString *SET_COLOR_RED;
extern NSString *SET_COLOR_GREEN;
extern NSString *SET_COLOR_PURPLE;

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

@end
