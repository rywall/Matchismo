//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ryan Wallace on 13-10-21.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
