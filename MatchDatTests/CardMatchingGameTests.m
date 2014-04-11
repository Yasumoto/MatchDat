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

@interface MockDeck : Deck
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation MockDeck
- (instancetype) init {
    self = [super init];
    if (self) {
        self.cards = [[NSMutableArray alloc] initWithCapacity:12];
        for (NSUInteger i = 0; i < 12; i++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.suit = [[PlayingCard validSuits] objectAtIndex:0];
            card.rank = i;
            [self.cards addObject:card];
        }
    }

    return self;
}

- (PlayingCard *) drawRandomCard {
    PlayingCard* card = (PlayingCard *)[self.cards firstObject];
    [self.cards removeObjectAtIndex:0];
    return card;
}

@end

@implementation CardMatchingGameTests

- (Deck *) deck {
    if (!_deck) {
        Deck *deck = [[Deck alloc] init];
        for (int i = 1; i < DECK_SIZE + 1; i++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.suit = [PlayingCard validSuits][0];
            card.rank = i;
            if (i == 1) {
                self.cardOne = card;
            }
            else if (i == 2) {
                self.cardTwo = card;
            }
            [deck addCard:card atTop:true];
        }
        _deck = deck;
    }
    return _deck;
}

- (void) setUp {
    [super setUp];
    self.game = [[CardMatchingGame alloc] initWithCardCount:DECK_SIZE usingDeck:self.deck];
}

- (void)testCardAtIndex
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:12 usingDeck:[[MockDeck alloc] init]];
    for (int i = 0; i < 12; i++) {
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:i];
        XCTAssertTrue(card.rank == i, @"Expected card is not at index");
    }
}

- (void) testChooseTwoCardsSuit {
    self.cardOne.chosen = true;
    NSLog(@"We've chosen cardOne: %@", self.cardOne.contents);
    [self.game chooseCardAtIndex:9];
    XCTAssertEqual(3, self.game.score);
}

- (void) testChooseTwoCardsRank {
    self.cardOne.rank = [(PlayingCard *)[self.game cardAtIndex:5] rank];
    self.cardOne.suit = [PlayingCard validSuits][1];
    self.cardOne.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(15, self.game.score);
}

- (void) testChooseThreeCardsSuit {
    self.game.cardsToMatch = 3;
    self.cardOne.chosen = true;
    self.cardTwo.chosen = true;
    [self.game chooseCardAtIndex:7];
    XCTAssertEqual(23, self.game.score);
}

/*
 Enable if necessary
- (void) testChooseThreeCardsRank {
    self.cardOne.rank = 6;
    self.cardOne.suit = [PlayingCard validSuits][1];
    self.cardTwo.rank = 6;
    self.cardTwo.suit = [PlayingCard validSuits][2];
    self.cardOne.chosen = true;
    self.cardTwo.chosen = true;
    [self.game chooseCardAtIndex:5];
    XCTAssertEqual(31, self.game.score);
}
 */

@end
