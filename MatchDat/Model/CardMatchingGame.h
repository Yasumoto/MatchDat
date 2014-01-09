//
//  CardMatchingGame.h
//  MatchDat
//
//  Created by Joseph Smith on 12/8/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck: (Deck *) deck;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *lastMove;
@property (nonatomic) NSInteger cardsToMatch; // default is 2
@end
