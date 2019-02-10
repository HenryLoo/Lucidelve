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

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.25f withBody:0.375f withFooter:0.375f];
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
    [self setupSwordButton];
}

/*!
 * Create the label element for displaying the player's current gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goldLabel.textColor = [UIColor blackColor];
    _goldLabel.textAlignment = NSTextAlignmentLeft;
    _goldLabel.text = @"Gold: ";
    [_goldLabel sizeToFit];
    [self.headerArea addSubview:_goldLabel];
    
    // Enable autolayout
    _goldLabel.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Create the button element for buying a sword.
 * @author Henry Loo
 */
- (void)setupSwordButton
{
    _swordButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _swordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Item sword = ITEMS[RUSTY_SWORD];
    NSString *title = [NSString stringWithFormat:@"%@ (%i)",
                       sword.name, sword.shopPrice];
    [_swordButton setTitle:title forState:UIControlStateNormal];
    [_swordButton setTitle:@"" forState:UIControlStateDisabled];
    [_swordButton sizeToFit];
    [self.footerArea addSubview:_swordButton];
    
    // Enable autolayout
    _swordButton.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Set up the layout constraints of the view
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
}

@end
