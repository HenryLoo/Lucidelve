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
}

/*!
 * Create the label element to show the number of remaining nodes.
 * @author Henry Loo
 */
- (void)setupRemainingNodesLabel
{
    _remainingNodesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.headerArea addSubview:_remainingNodesLabel];
    _remainingNodesLabel.text = @"Rooms: ";
    [_remainingNodesLabel sizeToFit];
    
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
    [self.bodyArea addSubview:_playerNameLabel];
    [self.bodyArea addSubview:_playerStateLabel];
    _playerNameLabel.text = @"Player";
    
    // Enable autolayout
    _playerNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _playerStateLabel.translatesAutoresizingMaskIntoConstraints = false;
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
}

@end
