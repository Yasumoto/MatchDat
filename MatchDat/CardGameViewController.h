//
//  CardGameViewController.h
//  MatchDat
//
//  Created by Joseph Smith on 12/2/13.
//  Copyright (c) 2013 bjoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *) createDeck; //abstract method
- (NSString *) titleForCard:(Card *)card; //abstract method
- (UIImage *) backgroundImageForCard:(Card *) card; //abstract method

@end
