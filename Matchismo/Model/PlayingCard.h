//
//  PlayingCard.h
//  Matchismo
//
//  Created by Minlin Zhang on 12/14/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
