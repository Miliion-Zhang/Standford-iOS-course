//
//  PlayingCard.m
//  Matchismo
//
//  Created by Minlin Zhang on 12/14/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥", @"♦", @"♣", @"♠"];
    return validSuits;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}


+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings){
        rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                        @"J",@"Q",@"K"];
    }
    
    return rankStrings;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
