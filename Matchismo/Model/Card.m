//
//  Card.m
//  Matchismo
//
//  Created by Ryan Wallace on 13-10-21.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)description {
    return [self contents];
}

@end
