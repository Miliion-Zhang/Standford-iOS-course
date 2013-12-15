//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Minlin Zhang on 12/10/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flips number is %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end
