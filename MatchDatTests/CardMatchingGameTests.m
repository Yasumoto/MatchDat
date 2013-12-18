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

- (void) testChooseTwoCardsSuit {
    self.cardOne.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(3, self.game.score);
}

- (void) testChooseTwoCardsRank {
    self.cardOne.rank = 5;
    self.cardOne.suit = [PlayingCard validSuits][1];
    self.cardOne.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(15, self.game.score);
}

- (void) testChooseThreeCardsSuit {
    self.cardOne.chosen = true;
    self.cardTwo.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(7, self.game.score);
}

- (void) testChooseThreeCardsRank {
    self.cardOne.rank = 5;
    self.cardOne.suit = [PlayingCard validSuits][1];
    self.cardTwo.rank = 5;
    self.cardTwo.suit = [PlayingCard validSuits][2];
    self.cardOne.chosen = true;
    self.cardTwo.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(31, self.game.score);
}

@end