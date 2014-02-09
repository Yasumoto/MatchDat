//
//  SetCard.m
//  MatchDat
//
//  Created by Joseph Smith on 1/10/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color;
@synthesize symbol = _symbol;
@synthesize shading = _shading;

NSString const *SET_SYMBOL_DIAMOND = @"▲";
NSString const *SET_SYMBOL_SQUIGGLE = @"●";
NSString const *SET_SYMBOL_OVAL = @"■";

NSString const *SET_SHADING_SOLID = @"SOLID";
NSString const *SET_SHADING_STRIPED = @"STRIPED";
NSString const *SET_SHADING_OPEN = @"OPEN";

NSString const *SET_COLOR_RED= @"RED";
NSString const *SET_COLOR_GREEN = @"GREEN";
NSString const *SET_COLOR_PURPLE = @"PURPLE";


- (NSString *)contents {
    return @"";
}

+ (NSArray *) validNumbers {
    return @[@1, @2, @3];
}

+ (NSArray *) validSymbols {
    return @[SET_SYMBOL_DIAMOND, SET_SYMBOL_OVAL, SET_SYMBOL_SQUIGGLE];
}

+ (NSArray *) validShading {
    return @[SET_SHADING_SOLID, SET_SHADING_STRIPED, SET_SHADING_OPEN];
}

+ (NSArray *) validColors {
    return @[SET_COLOR_GREEN, SET_COLOR_PURPLE, SET_COLOR_RED];
}

- (void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void) setShading:(NSString *)shading {
    if ([[SetCard validShading] containsObject:shading]) {
        _shading = shading;
    }
}

- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void) setNumber:(NSNumber *)number {
    if ([[SetCard validNumbers] containsObject:number]) {
        _number = number;
    }
}

- (NSString *) symbol {
    return _symbol ? _symbol : @"?";
}

- (NSString *) color {
    return _color ? _color : @"?";
}

- (NSString *) shading {
    return _shading ? _shading : @"?";
}

- (int) match:(NSArray *)otherCards {
    for (SetCard *otherCard in otherCards) {
        if ([otherCard.symbol isEqualToString:self.symbol] || [otherCard.color isEqualToString:self.color] || [otherCard.shading isEqualToString:self.shading]) {
            return 0;
        }
    }
    return 1;
}

@end
