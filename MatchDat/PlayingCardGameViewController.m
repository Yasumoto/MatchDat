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

- (NSAttributedString *) titleForCard:(Card *)card {
    NSString *title = card.isChosen ? card.contents : @"";
    return [[NSAttributedString alloc] initWithString:title];
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
