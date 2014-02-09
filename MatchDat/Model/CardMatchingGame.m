//
//  CardMatchingGame.m
//  MatchDat
//
//  Created by Joseph Smith on 12/8/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *lastMove;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSInteger) cardsToMatch {
    if (!_cardsToMatch) _cardsToMatch = 2;
    return _cardsToMatch;
}

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void) setCardsToMatched:(NSArray *)cards {
    for (Card *card in cards) {
        card.chosen = true;
        card.matched = true;
    }
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index {
    int chosenScoreChange = 0 - COST_TO_CHOOSE;
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
    NSMutableArray *chosenUnmatchedCards = [[NSMutableArray alloc] initWithCapacity:3];

    if (!card.isMatched) {
        // find chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                [chosenUnmatchedCards addObject:otherCard];
            }
        }
        if (chosenUnmatchedCards.count != self.cardsToMatch) {
            return;
        }
        card.chosen = NO;
        for (Card *eachCard in chosenUnmatchedCards) {
            NSMutableArray *otherCards = [chosenUnmatchedCards mutableCopy];
            [otherCards removeObject:eachCard];
            int matchScore = [eachCard match:otherCards];
            if (matchScore) {
                chosenScoreChange += matchScore * MATCH_BONUS;
            }
            else {
                eachCard.chosen = NO;
            }
        }
        card.chosen = YES;
    }
    if (chosenScoreChange > 0) {
        [self setCardsToMatched:chosenUnmatchedCards];
    }
    [self updateLastMoveWithCards:chosenUnmatchedCards score:chosenScoreChange];
    self.score += chosenScoreChange;
}

@end
