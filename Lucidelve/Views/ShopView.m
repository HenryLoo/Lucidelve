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
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goldLabel.text = @"Gold: ";
    [_goldLabel sizeToFit];
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
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
    [_goldLabel.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
    [_goldLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:25].active = YES;
    [_goldLabel.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_goldLabel.heightAnchor constraintEqualToConstant:_goldLabel.frame.size.height].active = YES;
    
    // Sword button constraints
    [_swordButton.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_swordButton.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    [_swordButton.widthAnchor constraintEqualToConstant:_swordButton.frame.size.width].active = YES;
    [_swordButton.heightAnchor constraintEqualToConstant:_swordButton.frame.size.height].active = YES;
    
    // Shield button constraints
    [_shieldButton.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_shieldButton.topAnchor constraintEqualToAnchor:_swordButton.topAnchor].active = YES;
    [_shieldButton.widthAnchor constraintEqualToConstant:_shieldButton.frame.size.width].active = YES;
    [_shieldButton.heightAnchor constraintEqualToConstant:_shieldButton.frame.size.height].active = YES;
    
    // Heart cookie button constraints
    [_heartButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_heartButton.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor].active = YES;
    [_heartButton.widthAnchor constraintEqualToConstant:_heartButton.frame.size.width].active = YES;
    [_heartButton.heightAnchor constraintEqualToConstant:_heartButton.frame.size.height].active = YES;
    
    // Bomb button constraints
    [_bombButton.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_bombButton.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
    [_bombButton.widthAnchor constraintEqualToConstant:_bombButton.frame.size.width].active = YES;
    [_bombButton.heightAnchor constraintEqualToConstant:_bombButton.frame.size.height].active = YES;
    
    // Healing potion button constraints
    [_potionButton.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_potionButton.bottomAnchor constraintEqualToAnchor:_bombButton.bottomAnchor].active = YES;
    [_potionButton.widthAnchor constraintEqualToConstant:_potionButton.frame.size.width].active = YES;
    [_potionButton.heightAnchor constraintEqualToConstant:_potionButton.frame.size.height].active = YES;
}

@end
