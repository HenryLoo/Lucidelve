//
//  ShopView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "ShopView.h"
#import "Constants.h"

@implementation ShopView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.25f withBody:0.375f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [super addBackButton];
    [super addTitle:@"SHOP"];
    [self setupGoldLabel];
}

- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    _swordButton = [self setupItemButton:ITEM_RUSTY_SWORD];
    _shieldButton = [self setupItemButton:ITEM_SHIELD];
    _heartButton = [self setupItemButton:ITEM_HEART_COOKIE];
    _bombButton = [self setupItemButton:ITEM_BOMB];
    _potionButton = [self setupItemButton:ITEM_HEALING_POTION];
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
 * @brief Create the button element for buying an item.
 * @author Henry Loo
 */
- (UIButton*)setupItemButton:(ItemType)itemType
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    Item item = ITEMS[itemType];
    NSString *title = [NSString stringWithFormat:@"%@ (%i G)",
                       item.name, item.shopPrice];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:@"SOLD OUT!" forState:UIControlStateDisabled];
    [button sizeToFit];
    [self.footerArea addSubview:button];
    
    // Enable autolayout
    button.translatesAutoresizingMaskIntoConstraints = false;
    
    return button;
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
    
    // Sword button constraints
    [_swordButton.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_swordButton.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    
    // Shield button constraints
    [_shieldButton.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_shieldButton.topAnchor constraintEqualToAnchor:_swordButton.topAnchor].active = YES;
    
    // Heart cookie button constraints
    [_heartButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_heartButton.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor].active = YES;
    
    // Bomb button constraints
    [_bombButton.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_bombButton.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
    
    // Healing potion button constraints
    [_potionButton.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_potionButton.bottomAnchor constraintEqualToAnchor:_bombButton.bottomAnchor].active = YES;
}

@end
