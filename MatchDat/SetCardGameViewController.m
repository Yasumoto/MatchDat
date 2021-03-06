//
//  SetCardGameViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 1/10/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSString *) titleForCard:(Card *)card {
    NSString *title = @"";
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        for (int i = 0; i < [setCard.number intValue]; i++) {
            title = [title stringByAppendingString:setCard.symbol];
        }
        //NSAttributedString *title = [[NSAttributedString alloc] initWithString:self.title];
    }
    return title;
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:@"cardfront"];
}

@end
