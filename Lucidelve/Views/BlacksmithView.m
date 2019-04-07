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
    [super addTitle:@"BLACKSMITH"];
    [super addBackButton];
    [self setupGoldLabel];
}

- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    [self setupInfoLabel];
    [self setupSwordLabel];
    [self setupUpgradeButton];
}

/*!
 * @brief Create the label element for displaying the player's current gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    _goldLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _goldLabel.text = @"Gold: ";
    _goldLabel.textColor = [UIColor whiteColor];
    _goldLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.8];
    float halfWidth = self.frame.size.width / 2;
    [_goldLabel setContentEdgeInsets:UIEdgeInsetsMake(12, halfWidth, 12, halfWidth)];
    _goldLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    _goldLabel.layer.borderWidth = 1;
    [self.headerArea addSubview:_goldLabel];
    
    // Enable autolayout
    _goldLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for displaying the info message.
 * @author Henry Loo
 */
- (void)setupInfoLabel
{
    _infoLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _infoLabel.numberOfLines = 3;
    float margin = 16;
    [_infoLabel setContentEdgeInsets:UIEdgeInsetsMake(margin, margin, margin, margin)];
    _infoLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    _infoLabel.layer.borderWidth = 1;
    [self.footerArea addSubview:_infoLabel];
    
    // Enable autolayout
    _infoLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for displaying the name of the player's sword.
 * @author Henry Loo
 */
- (void)setupSwordLabel
{
    _swordLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _swordLabel.textColor = [UIColor whiteColor];
    _swordLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.8];
    float halfWidth = self.frame.size.width / 2;
    [_swordLabel setContentEdgeInsets:UIEdgeInsetsMake(12, halfWidth, 12, halfWidth)];
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
    _upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upgradeButton.backgroundColor = [UIColor colorWithRed:0.04 green:0.77 blue:1.00 alpha:0.8];
    _upgradeButton.layer.borderColor = UIColor.blackColor.CGColor;
    _upgradeButton.layer.borderWidth = 1;
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
    [_goldLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [_goldLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:25].active = YES;
    
    // Upgrade button constraints
    [_upgradeButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_upgradeButton.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
    
    // Sword label constraints
    [_swordLabel.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_swordLabel.bottomAnchor constraintEqualToAnchor:_upgradeButton.topAnchor constant:-25].active = YES;
    
    // Info label constraints
    [_infoLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [_infoLabel.bottomAnchor constraintEqualToAnchor:_swordLabel.topAnchor constant:-16].active = YES;
}

@end
