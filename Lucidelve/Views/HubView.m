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

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.5f withBody:0.35f withFooter:0.15f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [self setupShopButton];
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
 * Create the button element for generating gold.
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
 * Create the label element for displaying the player's gold.
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
 * Create the button element for moving to the shop.
 * @author Henry Loo
 */
- (void)setupShopButton
{
    _shopButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _shopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_shopButton setTitle:@"SHOP" forState:UIControlStateNormal];
    [_shopButton setTitle:@"" forState:UIControlStateDisabled];
    [_shopButton sizeToFit];
    [_shopButton setEnabled:NO];
    [self.headerArea addSubview:_shopButton];
    
    // Enable autolayout
    _shopButton.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Gold label constraints
    [_goldLabel.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_goldLabel.centerYAnchor constraintEqualToAnchor:self.footerArea.centerYAnchor constant:-10].active = YES;
    [_goldLabel.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_goldLabel.heightAnchor constraintEqualToConstant:_goldLabel.frame.size.height].active = YES;
    
    // Gold button constraints
    [_goldButton.centerXAnchor constraintEqualToAnchor:self.footerArea.centerXAnchor].active = YES;
    [_goldButton.topAnchor constraintEqualToAnchor:_goldLabel.bottomAnchor].active = YES;
    [_goldButton.widthAnchor constraintEqualToConstant:_goldButton.frame.size.width].active = YES;
    [_goldButton.heightAnchor constraintEqualToConstant:_goldButton.frame.size.height].active = YES;

    // Shop button constraints
    [_shopButton.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
    [_shopButton.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:25].active = YES;
    [_shopButton.widthAnchor constraintEqualToConstant:_shopButton.frame.size.width].active = YES;
    [_shopButton.heightAnchor constraintEqualToConstant:_shopButton.frame.size.height].active = YES;
}

@end
