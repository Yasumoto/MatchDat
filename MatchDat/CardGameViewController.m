//
//  CardGameViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 12/2/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maxMatchedCardsSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *matchDescriptionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardIndices; // of NSUInteger
@property (strong, nonatomic) NSMutableArray *history; // of NSString
- (IBAction)historySliderValueChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic) int oldScore;
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

- (NSMutableArray *) history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"displayHistory"]) {
        HistoryViewController *dvc = segue.destinationViewController;
        dvc.history = self.history;
    }
}

- (IBAction)redealGame {
    self.game = nil;
    self.cardIndices = nil;
    self.maxMatchedCardsSegmentedControl.enabled = true;
    self.oldScore = 0;
    self.history = nil;
    [self updateUI];
}

- (Deck *) createDeck { //abstract method
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.maxMatchedCardsSegmentedControl.enabled = false;
    if (self.maxMatchedCardsSegmentedControl.selectedSegmentIndex == 0) {
        int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:chosenButtonIndex];
        if (self.game.lastMove) [self.history addObject:self.game.lastMove];
    }
    else {
        self.game.cardsToMatch = 3;
        NSNumber *chosenButtonIndex = [NSNumber numberWithInt:[self.cardButtons indexOfObject:sender]];
        [self.cardIndices addObject:chosenButtonIndex];
        if (self.cardIndices.count == 3) {
            for (NSNumber *chosenCardIndex in self.cardIndices) {
                [self.game chooseCardAtIndex:chosenCardIndex.intValue];

            }
            self.cardIndices = nil;
            Card *pickedCard = [self.game cardAtIndex:chosenButtonIndex.intValue];
            if (!pickedCard.isMatched) [self.cardIndices addObject:chosenButtonIndex];
            [self.history addObject:self.game.lastMove];
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
    self.historySlider.maximumValue = self.history.count;
    self.historySlider.value = self.historySlider.maximumValue;
    self.matchDescriptionLabel.text = self.game.lastMove;
}

- (NSString *) titleForCard:(Card *)card {
    return nil;
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return nil;
}

- (IBAction)historySliderValueChanged:(UISlider *)sender {
    NSInteger index = [[NSNumber numberWithFloat:sender.value] integerValue];
    if (index < self.history.count) {
        self.matchDescriptionLabel.text = [self.history objectAtIndex:index];
    }
}
@end
