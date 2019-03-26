//
//  HubView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HubView.h"

@interface HubView()
{
    
}

@end

@implementation HubView
    
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.5f withBody:0.35f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    _shopButton = [self setupMenuButton:@"SHOP"];
    _inventoryButton = [self setupMenuButton:@"INVENTORY"];
    _dungeonsButton = [self setupMenuButton:@"DUNGEONS"];
    _gooseButton = [self setupMenuButton:@"GOLDEN GOOSE"];
    _blacksmithButton = [self setupMenuButton:@"BLACKSMITH"];
}

- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    [self setupGoldButton];
    [self setupGoldLabel];
}

/*!
 * @brief Create the button element for generating gold.
 * @author Henry Loo
 */
- (void)setupGoldButton
{
    _goldButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _goldButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_goldButton setTitle:@"PICK UP GOLD" forState:UIControlStateNormal];
    [_goldButton sizeToFit];
    [self.footerArea addSubview:_goldButton];
    
    // Enable autolayout
    _goldButton.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the label element for displaying the player's gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goldLabel.textColor = [UIColor blackColor];
    _goldLabel.textAlignment = NSTextAlignmentCenter;
    _goldLabel.text = @"Gold: ";
    [_goldLabel sizeToFit];
    [self.footerArea addSubview:_goldLabel];
    
    // Enable autolayout
    _goldLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the button element for moving to a menu.
 * @author Henry Loo
 */
- (UIButton*)setupMenuButton:(NSString*)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateDisabled];
    [button sizeToFit];
    [button setEnabled:NO];
    [self.headerArea addSubview:button];
    
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
    [_goldLabel.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_goldLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor constant:-10].active = YES;
    
    // Gold button constraints
    [_goldButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_goldButton.topAnchor constraintEqualToAnchor:_goldLabel.bottomAnchor].active = YES;

    // Shop button constraints
    [_shopButton.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
    [_shopButton.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:25].active = YES;
    
    // Inventory button constraints
    [_inventoryButton.leftAnchor constraintEqualToAnchor:_shopButton.rightAnchor constant:25].active = YES;
    [_inventoryButton.topAnchor constraintEqualToAnchor:_shopButton.topAnchor].active = YES;
    
    // Dungeons button constraints
    [_dungeonsButton.leftAnchor constraintEqualToAnchor:_inventoryButton.rightAnchor constant:25].active = YES;
    [_dungeonsButton.topAnchor constraintEqualToAnchor:_shopButton.topAnchor].active = YES;
    
    // Golden Goose button constraints
    [_gooseButton.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
    [_gooseButton.topAnchor constraintEqualToAnchor:_shopButton.bottomAnchor constant:25].active = YES;
    
    // Blacksmith button constraints
    [_blacksmithButton.leftAnchor constraintEqualToAnchor:_gooseButton.rightAnchor constant:25].active = YES;
    [_blacksmithButton.topAnchor constraintEqualToAnchor:_gooseButton.topAnchor].active = YES;
}

@end
