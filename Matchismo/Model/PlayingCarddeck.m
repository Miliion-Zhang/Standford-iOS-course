//
//  PlayingCarddeck.m
//  Matchismo
//
//  Created by Minlin Zhang on 12/14/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "PlayingCarddeck.h"
#import "PlayingCard.h"

@implementation PlayingCarddeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end
