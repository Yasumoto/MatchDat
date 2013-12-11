//
//  PlayingCardDeckTests.m
//  MatchDat
//
//  Created by Joseph Smith on 12/10/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlayingCard.h"

@interface PlayingCardTests : XCTestCase

@property (nonatomic, strong) PlayingCard *card;

@end


@implementation PlayingCardTests

- (PlayingCard *) createMockCard {
    PlayingCard *card = [[PlayingCard alloc] init];
    card.rank = 10;
    card.suit = [PlayingCard validSuits][0];
    return card;
}

- (PlayingCard *) createMockCardTwo {
    PlayingCard *card = [[PlayingCard alloc] init];
    card.rank = 5;
    card.suit = [PlayingCard validSuits][2];
    return card;
}

- (void)setUp {
    [super setUp];
    self.card = [[PlayingCard alloc] init];
}

- (void) testMatchSuitSingle {
    self.card.rank = 1;
    self.card.suit = [PlayingCard validSuits][0];
    XCTAssertEqual(1, [self.card match:[NSArray arrayWithObject:[self createMockCard]]]);
}

- (void) testMatchRankSingle {
    self.card.rank = 10;
    self.card.suit = [PlayingCard validSuits][1];
    XCTAssertEqual(4, [self.card match:[NSArray arrayWithObject:[self createMockCard]]]);
}

- (void) testMatchSuitMultipleOne {
    self.card.rank = 1;
    self.card.suit = [PlayingCard validSuits][0];
    NSArray *match_cards = [NSArray arrayWithObjects:[self createMockCard], [self createMockCardTwo], nil];
    XCTAssertEqual(1, [self.card match:match_cards], @"Failure to match %@ to %@", self.card, match_cards);
}

- (void) testMatchRankMultipleOne {
    self.card.rank = 10;
    self.card.suit = [PlayingCard validSuits][1];
    NSArray *match_cards = @[[self createMockCard], [self createMockCardTwo]];
    XCTAssertEqual(2, [self.card match:match_cards], "@Rank not matched with %@ to %@", self.card, match_cards);
}

- (void) testMatchSuitMultipleTwo {
    self.card.rank = 10;
    self.card.suit = [PlayingCard validSuits][2];
    NSArray *match_cards = [NSArray arrayWithObjects:[self createMockCard], [self createMockCardTwo], nil];
    XCTAssertEqual(3, [self.card match:match_cards], @"Failure to match %@ to %@", self.card, match_cards);
}

- (void) testMatchRankMultipleTwo {
    self.card.rank = 10;
    self.card.suit = [PlayingCard validSuits][2];
    NSArray *match_cards = @[[self createMockCard], [self createMockCardTwo]];
    XCTAssertEqual(3, [self.card match:match_cards], "@Rank not matched with %@ to %@", self.card, match_cards);
}

- (void) testMatchSuitNone {
    self.card.rank = 1;
    self.card.suit = [PlayingCard validSuits][0];
    XCTAssertEqual(0, [self.card match:@[]], "Couldn't deal with empty array with %@", self.card);
}

- (void) testMatchRankNone {
    self.card.rank = 10;
    self.card.suit = [PlayingCard validSuits][1];
    XCTAssertEqual(0, [self.card match:@[]], "Couldn't deal with empty array with %@", self.card);
}

@end
