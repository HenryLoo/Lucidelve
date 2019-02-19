//
//  CombatView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-16.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "CombatView.h"

@interface CombatView ()
{
    
}

@end

@implementation CombatView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.1f withBody:0.7f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [self setupRemainingNodesLabel];
}

- (void)setupBodyElements
{
    [self setupEnemyLabels];
    [self setupPlayerLabels];
}

- (void)setupFooterElements
{
    self.footerArea.backgroundColor = UIColor.grayColor;
    
    [self setupLifeLabel];
    [self setupItemViews];
}

/*!
 * Create the label element to show the number of remaining nodes.
 * @author Henry Loo
 */
- (void)setupRemainingNodesLabel
{
    _remainingNodesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _remainingNodesLabel.text = @"Rooms: ";
    [_remainingNodesLabel sizeToFit];
    [self.headerArea addSubview:_remainingNodesLabel];
    
    // Enable autolayout
    _remainingNodesLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Create the label elements for enemy.
 * @author Henry Loo
 */
- (void)setupEnemyLabels
{
    _enemyNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _enemyStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _enemyNameLabel.textAlignment = _enemyStateLabel.textAlignment = NSTextAlignmentCenter;
    _enemyStateLabel.numberOfLines = 2;
    [self.bodyArea addSubview:_enemyNameLabel];
    [self.bodyArea addSubview:_enemyStateLabel];
    
    // Enable autolayout
    _enemyNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _enemyStateLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Create the label elements for player.
 * @author Henry Loo
 */
- (void)setupPlayerLabels
{
    _playerNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _playerStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _playerNameLabel.textAlignment = _playerStateLabel.textAlignment = NSTextAlignmentCenter;
    _playerNameLabel.text = @"Player";
    [self.bodyArea addSubview:_playerNameLabel];
    [self.bodyArea addSubview:_playerStateLabel];
    
    // Enable autolayout
    _playerNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _playerStateLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Create the label element to show the player's life.
 * @author Henry Loo
 */
- (void)setupLifeLabel
{
    _playerLifeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _playerLifeLabel.text = @"Life: ";
    [_playerLifeLabel sizeToFit];
    [self.footerArea addSubview:_playerLifeLabel];
    
    // Enable autolayout
    _playerLifeLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Create the view elements to show the player's item 1 and item 2.
 * @author Henry Loo
 */
- (void)setupItemViews
{
    _item1View = [[UILabel alloc] initWithFrame:CGRectZero];
    _item1View.backgroundColor = UIColor.darkGrayColor;
    [self.footerArea addSubview:_item1View];
    
    _item2View = [[UILabel alloc] initWithFrame:CGRectZero];
    _item2View.backgroundColor = UIColor.darkGrayColor;
    [self.footerArea addSubview:_item2View];
    
    // Enable autolayout
    _item1View.translatesAutoresizingMaskIntoConstraints = false;
    _item2View.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Remaining nodes label constraints
    [_remainingNodesLabel.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor].active = YES;
    [_remainingNodesLabel.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:25].active = YES;
    [_remainingNodesLabel.widthAnchor constraintEqualToConstant:self.headerArea.frame.size.width].active = YES;
    
    // Enemy label constraints
    [_enemyNameLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_enemyNameLabel.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor constant:25].active = YES;
    [_enemyNameLabel.widthAnchor constraintEqualToConstant:self.bodyArea.frame.size.width].active = YES;
    [_enemyNameLabel.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [_enemyStateLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_enemyStateLabel.topAnchor constraintEqualToAnchor:_enemyNameLabel.bottomAnchor].active = YES;
    [_enemyStateLabel.widthAnchor constraintEqualToConstant:self.bodyArea.frame.size.width].active = YES;
    [_enemyStateLabel.heightAnchor constraintEqualToConstant:100].active = YES;
    
    // Player label constraints
    [_playerStateLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_playerStateLabel.bottomAnchor constraintEqualToAnchor:self.bodyArea.bottomAnchor constant:-25].active = YES;
    [_playerStateLabel.widthAnchor constraintEqualToConstant:self.bodyArea.frame.size.width].active = YES;
    [_playerStateLabel.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [_playerNameLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_playerNameLabel.bottomAnchor constraintEqualToAnchor:_playerStateLabel.topAnchor].active = YES;
    [_playerNameLabel.widthAnchor constraintEqualToConstant:self.bodyArea.frame.size.width].active = YES;
    [_playerNameLabel.heightAnchor constraintEqualToConstant:50].active = YES;
    
    // Life label constraints
    [_playerLifeLabel.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_playerLifeLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor].active = YES;
    
    // Item 1 and item 2 constraints
    float itemViewSize = self.footerArea.frame.size.height * 2 / 3;
    float itemViewOffset = (self.footerArea.frame.size.height - itemViewSize) / 2;
    [_item2View.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-itemViewOffset].active = YES;
    [_item2View.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:itemViewOffset].active = YES;
    [_item2View.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item2View.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    [_item1View.rightAnchor constraintEqualToAnchor:_item2View.leftAnchor constant:-itemViewOffset].active = YES;
    [_item1View.topAnchor constraintEqualToAnchor:_item2View.topAnchor].active = YES;
    [_item1View.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item1View.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
}

@end
