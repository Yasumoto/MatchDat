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

- (NSAttributedString *) titleForCard:(Card *)card {
    NSAttributedString *attributedTitle;
    NSString *title = @"";
    UIColor *color;
    NSDictionary *attributes = @{};

    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        for (int i = 0; i < [setCard.number intValue]; i++) {
            title = [title stringByAppendingString:setCard.symbol];
        }
        if (setCard.color == SET_COLOR_GREEN) {
            color = [UIColor greenColor];
        }
        else if (setCard.color == SET_COLOR_RED) {
            color = [UIColor redColor];
        }
        else {
            color = [UIColor purpleColor];
        }
        attributes = @{NSForegroundColorAttributeName: color};
        if (setCard.shading == SET_SHADING_OPEN) {
            attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                           NSStrokeWidthAttributeName: [NSNumber numberWithFloat:-3.0],
                           NSStrokeColorAttributeName:color};
        }
        else if (setCard.shading == SET_SHADING_STRIPED) {
            attributes = @{NSForegroundColorAttributeName: [color colorWithAlphaComponent:0.25]};
        }

        attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];

    }
    return attributedTitle;
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:@"cardfront"];
}

@end
