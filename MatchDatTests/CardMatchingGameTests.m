//
//  CardMatchingGameTests.m
//  MatchDat
//
//  Created by Joseph Smith on 12/15/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardMatchingGameTests : XCTestCase

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) PlayingCard *cardOne;
@property (strong, nonatomic) PlayingCard *cardTwo;
@property (strong, nonatomic) PlayingCard *cardThree;
@property (strong, nonatomic) PlayingCard *cardFour;

@end

static const int DECK_SIZE = 10;

@implementation CardMatchingGameTests

- (Deck *) deck {
    if (!_deck) {
        Deck *deck = [[Deck alloc] init];
        for (int i = 0; i < DECK_SIZE; i++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.suit = [PlayingCard validSuits][0];
            card.rank = i;
            if (i == 1) {
                self.cardOne = card;
            }
            else if (i == 2) {
                self.cardTwo = card;
            }
            [deck addCard:card];
        }
        _deck = deck;
    }
    return _deck;
}

- (void) setUp {
    [super setUp];
    self.game = [[CardMatchingGame alloc] initWithCardCount:DECK_SIZE usingDeck:self.deck];
}

- (void) testChooseTwoCards {
    self.CardOne.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(, [self.card match:[NSArray arrayWithObject:[self createMockCard]]]);
}

@end