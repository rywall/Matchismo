//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ryan Wallace on 13-10-17.
//  Copyright (c) 2013 Culture Code. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *cardNumberSelector;

@property (weak, nonatomic) IBOutlet UILabel *actionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] withMatchNumber:self.cardNumberSelector.selectedSegmentIndex + 2];
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self deal];
}

- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    self.cardNumberSelector.enabled = true;
    
    self.actionDescriptionLabel.text = @"Match cards by suit or rank to score!";
    self.scoreLabel.text = @"Score: 0";
    self.flipsLabel.text = @"Flips: 0";
    
    UIImage *cardBackImage = [UIImage imageNamed:@"card_back.jpg"];
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImage:cardBackImage
                    forState:UIControlStateNormal];
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
        
        cardButton.selected = NO;
        cardButton.enabled = YES;
        cardButton.alpha = 1.0;
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.cardNumberSelector.enabled = false;
    self.actionDescriptionLabel.text = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)updateUI
{
    
    UIImage *cardBackImage = [UIImage imageNamed:@"card_back.jpg"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setImage:(card.isFaceUp ? nil : cardBackImage)
                    forState:UIControlStateNormal];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

@end
