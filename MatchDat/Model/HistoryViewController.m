//
//  HistoryViewController.m
//  MatchDat
//
//  Created by Joseph Smith on 1/10/14.
//  Copyright (c) 2014 bjoli. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

+ (NSString *) appendedStringsFromArray:(NSArray *) array;
@end

@implementation HistoryViewController

+ (NSString *) appendedStringsFromArray:(NSArray *)array {
    NSString *concatenated = @"";
    for (NSString *string in array) {
        concatenated = [NSString stringWithFormat:@"%@\n%@", concatenated, string];
    }
    return concatenated;
}

- (void) viewWillAppear:(BOOL)animated {
    self.historyTextView.text = [HistoryViewController appendedStringsFromArray:self.history];
}

@end
