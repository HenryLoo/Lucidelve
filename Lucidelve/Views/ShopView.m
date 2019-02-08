//
//  ShopView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "ShopView.h"
#import "Constants.h"

@interface ShopView()
{
    
}

@end

@implementation ShopView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [self setupShopTitle];
        [self setupBackButton];
        [self setupGoldLabel];
        [self setupSwordButton];
    }
    return self;
}

/*!
 * Create the label element for displaying the shop's title.
 * @author Henry Loo
 */
- (void)setupShopTitle
{
    CGSize frameSize = self.frame.size;
    _shopTitle = [[UILabel alloc] initWithFrame:CGRectMake((frameSize.width - SHOP_TITLE_SIZE.width) / 2,
                                                           0,
                                                           SHOP_TITLE_SIZE.width, SHOP_TITLE_SIZE.height)];
    _shopTitle.textColor = [UIColor blackColor];
    _shopTitle.textAlignment = NSTextAlignmentCenter;
    _shopTitle.text = @"SHOP";
    [self addSubview:_shopTitle];
}

/*!
 * Create the button element for going back to The Hub.
 * @author Henry Loo
 */
- (void)setupBackButton
{
    _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backButton.frame = CGRectMake(0, 0,
                                   BACK_BUTTON_SIZE.width, BACK_BUTTON_SIZE.height);
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton setEnabled:YES];
    [self addSubview:_backButton];
}

/*!
 * Create the label element for displaying the player's current gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    CGSize frameSize = self.frame.size;
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectMake((frameSize.width - GOLD_LABEL_SIZE.width) / 2,
                                                           GOLD_LABEL_SIZE.height,
                                                           GOLD_LABEL_SIZE.width, GOLD_LABEL_SIZE.height)];
    _goldLabel.textColor = [UIColor blackColor];
    _goldLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goldLabel];
}

/*!
 * Create the button element for buying a sword.
 * @author Henry Loo
 */
- (void)setupSwordButton
{
    CGSize frameSize = self.frame.size;
    _swordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _swordButton.frame = CGRectMake(0, frameSize.height - BACK_BUTTON_SIZE.height,
                                   BACK_BUTTON_SIZE.width, BACK_BUTTON_SIZE.height);
    Item sword = ITEMS[RUSTY_SWORD];
    NSString *title = [NSString stringWithFormat:@"%@ (%i)",
                       sword.name, sword.shopPrice];
    [_swordButton setTitle:title forState:UIControlStateNormal];
    [_swordButton setTitle:@"" forState:UIControlStateDisabled];
    [_swordButton setEnabled:YES];
    [self addSubview:_swordButton];
}

@end
