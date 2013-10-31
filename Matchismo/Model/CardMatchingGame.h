//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ryan Wallace on 10/25/2013.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
         withMatchNumber:(NSUInteger)matchCount;

- (NSString *)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@end
