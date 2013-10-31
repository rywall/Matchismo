//
//  Card.h
//  Matchismo
//
//  Created by Ryan Wallace on 13-10-21.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
