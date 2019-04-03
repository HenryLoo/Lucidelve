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
        [super setupLayout:0.55f withBody:0.30f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    _shopButton = [self setupMenuButton:@"Shop"];
    _inventoryButton = [self setupMenuButton:@"Inventory"];
    _dungeonsButton = [self setupMenuButton:@"Dungeons"];
    _gooseButton = [self setupMenuButton:@"Golden Goose"];
    _blacksmithButton = [self setupMenuButton:@"Blacksmith"];
    _highscoreButton = [self setupMenuButton:@"Highscore"];
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
    _goldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goldButton.backgroundColor = [UIColor colorWithRed:1.00 green:0.73 blue:0.04 alpha:0.6];
    [_goldButton setTitle:@"PICK UP GOLD" forState:UIControlStateNormal];
    _goldButton.layer.borderColor = UIColor.blackColor.CGColor;
    _goldButton.layer.borderWidth = 1;
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
    button = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    // Highscore button constrants
    [_highscoreButton.topAnchor constraintEqualToAnchor:_goldLabel.bottomAnchor].active = YES;
    [_highscoreButton.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor].active = YES;

    // Shop button constraints
    float xOffset = self.headerArea.frame.size.width / 4;
    float yOffset = self.headerArea.frame.size.height / 4;
    [_shopButton.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor constant:-xOffset].active = YES;
    [_shopButton.centerYAnchor constraintEqualToAnchor:self.headerArea.centerYAnchor constant:-yOffset].active = YES;
    
    // Blacksmith button constraints
    [_blacksmithButton.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor constant:xOffset].active = YES;
    [_blacksmithButton.centerYAnchor constraintEqualToAnchor:self.headerArea.centerYAnchor constant:-yOffset].active = YES;
    
    // Dungeons button constraints
    [_dungeonsButton.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [_dungeonsButton.centerYAnchor constraintEqualToAnchor:self.headerArea.centerYAnchor].active = YES;
    
    // Inventory button constraints
    [_inventoryButton.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor constant:-xOffset].active = YES;
    [_inventoryButton.centerYAnchor constraintEqualToAnchor:self.headerArea.centerYAnchor constant:yOffset].active = YES;
    
    // Golden Goose button constraints
    [_gooseButton.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor constant:xOffset].active = YES;
    [_gooseButton.centerYAnchor constraintEqualToAnchor:self.headerArea.centerYAnchor constant:yOffset].active = YES;
}

@end
