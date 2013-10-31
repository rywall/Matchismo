//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ryan Wallace on 10/25/2013.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic) int matchCount;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck withMatchNumber:(NSUInteger)matchCount
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    self.matchCount = matchCount;
    
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (NSString *)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *matchDescription = @"";
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            matchDescription = [self performMatching:card];
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    } else {
        matchDescription = @"You can't flip that card!";
    }
    
    return matchDescription;
}

- (NSString *)performMatching:(Card *)card
{
    NSString *matchDescription = [NSString stringWithFormat:@"Flipped up %@", card.contents];
    
    NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
            [faceUpCards addObject:otherCard];
        }
    }
    
    if (faceUpCards.count == (self.matchCount - 1)) {
        int matchScore = [card match:faceUpCards];
        NSString *otherCardString = [faceUpCards componentsJoinedByString:@", "];
        
        if (matchScore) {
            for (Card *otherCard in faceUpCards) {
                otherCard.unplayable = YES;
            }
            card.unplayable = YES;
            self.score += matchScore * MATCH_BONUS;
            matchDescription = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", otherCardString, card.contents, matchScore * MATCH_BONUS];
        } else {
            for (Card *otherCard in faceUpCards) {
                otherCard.faceUp = NO;
            }
            self.score -= MISMATCH_PENALTY;
            matchDescription = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", otherCardString, card.contents, MISMATCH_PENALTY];
        }
    }
    
    return matchDescription;
}

@end
