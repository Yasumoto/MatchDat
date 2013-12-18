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
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenUnmatchedCards = [[NSMutableArray alloc] initWithCapacity:2];
    if (!card.isMatched) {
        [chosenUnmatchedCards addObject:card];
        card.chosen = NO;
        // match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                [chosenUnmatchedCards addObject:otherCard];
            }
        }
        for (Card *card in chosenUnmatchedCards) {
            NSMutableArray *otherCards = [chosenUnmatchedCards mutableCopy];
            [otherCards removeObject:card];
            for (Card *otherCard in otherCards) {
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    otherCard.chosen = YES;
                    otherCard.matched = YES;
                    card.matched = YES;
                }
                else {
                    if (!otherCard.isMatched) otherCard.chosen = NO;
                    self.score -= MISMATCH_PENALTY;
                }
            }
            if (chosenUnmatchedCards.count == 2) {
                break;
            }
        }
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
    }
}

@end
