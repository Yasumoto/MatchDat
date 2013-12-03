//
//  Deck.h
//  MatchDat
//
//  Created by Joseph Smith on 12/2/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *) card atTop:(BOOL)atTop;
- (void) addCard:(Card *) card;

- (Card *)drawRandomCard;

@end
