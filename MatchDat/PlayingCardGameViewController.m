//
//  PlayingCardGameViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 1/7/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSString *) titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
