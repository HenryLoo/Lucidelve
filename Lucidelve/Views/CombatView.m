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
    [self setupCombatLabel];
}

- (void)setupFooterElements
{
    self.footerArea.backgroundColor = [UIColor colorWithRed:0.24 green:0.25 blue:0.26 alpha:0.8];
    
    [self setupStatsLabels];
    [self setupItemViews];
}

/*!
 * @brief Create the label element to show the number of remaining nodes.
 * @author Henry Loo
 */
- (void)setupRemainingNodesLabel
{
    _remainingNodesLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _remainingNodesLabel.text = @"Rooms: ";
    _remainingNodesLabel.textColor = UIColor.whiteColor;
    _remainingNodesLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_remainingNodesLabel setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
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
    _enemyNameLabel = [[UIPaddedLabel alloc] init];
    _enemyNameLabel.textAlignment = NSTextAlignmentCenter;
    _enemyNameLabel.textColor = UIColor.whiteColor;
    _enemyNameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_enemyNameLabel setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.bodyArea addSubview:_enemyNameLabel];
    
    // Enable autolayout
    _enemyNameLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for the combat status.
 * @author Henry Loo
 */
- (void)setupCombatLabel
{
    _combatStatusLabel = [[UIPaddedLabel alloc] init];
    _combatStatusLabel.textAlignment = NSTextAlignmentCenter;
    _combatStatusLabel.textColor = UIColor.whiteColor;
    _combatStatusLabel.numberOfLines = 2;
    [_combatStatusLabel setContentEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
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
    _playerLifeLabel = [[UILabel alloc] init];
    _playerLifeLabel.textColor = UIColor.whiteColor;
    [self.footerArea addSubview:_playerLifeLabel];
    
    _playerStaminaLabel = [[UILabel alloc] init];
    _playerStaminaLabel.textColor = UIColor.whiteColor;
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
    _item1Button = [[UIButton alloc] init];
    _item1Button.backgroundColor = UIColor.darkGrayColor;
    _item1Button.layer.borderColor = UIColor.blackColor.CGColor;
    _item1Button.layer.borderWidth = 2;
    [self.footerArea addSubview:_item1Button];
    
    _item2Button = [[UIButton alloc] init];
    _item2Button.backgroundColor = UIColor.darkGrayColor;
    _item2Button.layer.borderColor = UIColor.blackColor.CGColor;
    _item2Button.layer.borderWidth = 2;
    [self.footerArea addSubview:_item2Button];
    
    // Enable autolayout
    _item1Button.translatesAutoresizingMaskIntoConstraints = false;
    _item2Button.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Remaining nodes label constraints
    [_remainingNodesLabel.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:8].active = YES;
    [_remainingNodesLabel.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:25].active = YES;
    
    // Enemy label constraints
    [_enemyNameLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_enemyNameLabel.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor constant:25].active = YES;
    
    // Combat label label constraints
    [_combatStatusLabel.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_combatStatusLabel.centerYAnchor constraintEqualToAnchor:self.bodyArea.centerYAnchor].active = YES;
    
    // Player stats labels constraints
    [_playerLifeLabel.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:16].active = YES;
    [_playerLifeLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor constant:-16].active = YES;
    [_playerStaminaLabel.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:16].active = YES;
    [_playerStaminaLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor constant:16].active = YES;
    
    // Item 1 and item 2 constraints
    float itemViewSize = self.footerArea.frame.size.height * 2 / 3;
    float itemViewOffset = (self.footerArea.frame.size.height - itemViewSize) / 2;
    [_item2Button.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-itemViewOffset].active = YES;
    [_item2Button.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:itemViewOffset].active = YES;
    [_item2Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item2Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    [_item1Button.rightAnchor constraintEqualToAnchor:_item2Button.leftAnchor constant:-itemViewOffset].active = YES;
    [_item1Button.topAnchor constraintEqualToAnchor:_item2Button.topAnchor].active = YES;
    [_item1Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item1Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
}

@end
