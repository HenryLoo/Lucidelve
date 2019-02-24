//
//  BlacksmithView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-24.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BlacksmithView.h"

@implementation BlacksmithView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.25f withBody:0.45f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [super addBackButton];
    [super addTitle:@"BLACKSMITH"];
    [self setupGoldLabel];
}

- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    [self setupSwordLabel];
    [self setupUpgradeButton];
}

/*!
 * @brief Create the label element for displaying the player's current gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goldLabel.text = @"Gold: ";
    [_goldLabel sizeToFit];
    [self.headerArea addSubview:_goldLabel];
    
    // Enable autolayout
    _goldLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for displaying the name of the player's sword.
 * @author Henry Loo
 */
- (void)setupSwordLabel
{
    _swordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _swordLabel.textAlignment = NSTextAlignmentCenter;
    [self.footerArea addSubview:_swordLabel];
    
    // Enable autolayout
    _swordLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the button element for upgrading the gold generation rate.
 * @author Henry Loo
 */
- (void)setupUpgradeButton
{
    _upgradeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _upgradeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.footerArea addSubview:_upgradeButton];
    
    // Enable autolayout
    _upgradeButton.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Gold label constraints
    [_goldLabel.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
    [_goldLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:25].active = YES;
    [_goldLabel.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_goldLabel.heightAnchor constraintEqualToConstant:_goldLabel.frame.size.height].active = YES;
    
    // Upgrade button constraints
    [_upgradeButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_upgradeButton.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
    
    // Sword label constraints
    [_swordLabel.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_swordLabel.bottomAnchor constraintEqualToAnchor:_upgradeButton.bottomAnchor constant:-25].active = YES;
}

@end
