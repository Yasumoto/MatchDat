//
//  SetCardGameViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 1/10/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

@end
