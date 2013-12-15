//
//  CardGameViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 12/2/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maxMatchedCardsSegmentedControl;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardIndices; // of NSUInteger
@end

@implementation CardGameViewController

- (NSMutableArray *) cardIndices {
    if (!_cardIndices) _cardIndices = [[NSMutableArray alloc] initWithCapacity:2];
    return _cardIndices;
}

- (CardMatchingGame *) game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)redealGame {
    self.game = nil;
    self.cardIndices = nil;
    self.maxMatchedCardsSegmentedControl.enabled = true;
    [self updateUI];
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.maxMatchedCardsSegmentedControl.enabled = false;
    if (self.maxMatchedCardsSegmentedControl.selectedSegmentIndex == 0) {
        int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:chosenButtonIndex];
    }
    else {
        NSNumber *chosenButtonIndex = [NSNumber numberWithInt:[self.cardButtons indexOfObject:sender]];
        [self.cardIndices addObject:chosenButtonIndex];
        if (self.cardIndices.count == 3) {
            // Ready to match
            for (NSNumber *chosenCardIndex in self.cardIndices) {
                [self.game chooseCardAtIndex:chosenCardIndex.intValue];

            }
            self.cardIndices = nil;
            //[[self.game cardAtIndex:chosenButtonIndex.intValue] setChosen:false];
        } else {
            Card *card = [self.game cardAtIndex:chosenButtonIndex.intValue];
            card.chosen = true;
        }
    }
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *) titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
