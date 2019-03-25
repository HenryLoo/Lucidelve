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
    [self setupCombatLabel];
}

- (void)setupFooterElements
{
    self.footerArea.backgroundColor = UIColor.grayColor;
    
    [self setupStatsLabels];
    [self setupItemViews];
}

/*!
 * @brief Create the label element to show the number of remaining nodes.
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
 * @brief Create the label elements for enemy.
 * @author Henry Loo
 */
- (void)setupEnemyLabels
{
    _enemyNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _enemyStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _enemyNameLabel.textAlignment = _enemyStateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bodyArea addSubview:_enemyNameLabel];
    [self.bodyArea addSubview:_enemyStateLabel];
    
    // Enable autolayout
    _enemyNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _enemyStateLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label elements for player.
 * @author Henry Loo
 */
- (void)setupPlayerLabels
{
    _playerStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.bodyArea addSubview:_playerStateLabel];
    
    // Enable autolayout
    _playerStateLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for the combat status.
 * @author Henry Loo
 */
- (void)setupCombatLabel
{
    _combatStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _combatStatusLabel.textAlignment = _playerStateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bodyArea addSubview:_combatStatusLabel];
    
    // Enable autolayout
    _combatStatusLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element to show the player's stats.
 * @author Henry Loo
 */
- (void)setupStatsLabels
{
    _playerLifeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_playerLifeLabel sizeToFit];
    [self.footerArea addSubview:_playerLifeLabel];
    
    _playerStaminaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_playerStaminaLabel sizeToFit];
    [self.footerArea addSubview:_playerStaminaLabel];
    
    // Enable autolayout
    _playerLifeLabel.translatesAutoresizingMaskIntoConstraints = false;
    _playerStaminaLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the view elements to show the player's item 1 and item 2.
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
 * @brief Set up the layout constraints of the view
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
    
    [_enemyStateLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_enemyStateLabel.topAnchor constraintEqualToAnchor:_enemyNameLabel.bottomAnchor].active = YES;
    
    // Player label constraints
    [_playerStateLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_playerStateLabel.bottomAnchor constraintEqualToAnchor:self.bodyArea.bottomAnchor constant:-25].active = YES;
    
    // Combat label label constraints
    [_combatStatusLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_combatStatusLabel.centerYAnchor constraintEqualToAnchor:self.bodyArea.centerYAnchor].active = YES;
    
    // Player stats labels constraints
    [_playerLifeLabel.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_playerLifeLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor].active = YES;
    [_playerStaminaLabel.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_playerStaminaLabel.topAnchor constraintEqualToAnchor:_playerLifeLabel.bottomAnchor].active = YES;
    
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
