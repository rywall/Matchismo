//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ryan Wallace on 13-10-21.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    NSUInteger suitMatches = 0;
    NSUInteger rankMatches = 0;
    NSUInteger score = 0;
    
    for (PlayingCard *otherCard in otherCards) {
        if ([self.suit isEqualToString:otherCard.suit]) {
            suitMatches += 1;
        } else if (self.rank == otherCard.rank) {
            rankMatches += 1;
        }
    }
    
    if (suitMatches == otherCards.count) {
        score = 1 * otherCards.count;
    } else if (rankMatches == otherCards.count) {
        score = 4 * otherCards.count;
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = PlayingCard.rankStrings;
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *)suit {
    if ([PlayingCard.validSuits containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return self.rankStrings.count - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= PlayingCard.maxRank) {
        _rank = rank;
    }
}
@end
