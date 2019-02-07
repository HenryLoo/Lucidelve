//
//  HubView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HubView.h"
#import "Constants.h"

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
        [self setupGoldButton];
        [self setupGoldLabel];
        [self setupShopButton];
    }
    return self;
}

/*!
 * Create the button element for generating gold.
 * @author Henry Loo
 */
- (void)setupGoldButton
{
    _goldButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGSize frameSize = self.frame.size;
    _goldButton.frame = CGRectMake((frameSize.width - GOLD_BUTTON_SIZE.width) / 2,
                                   frameSize.height - GOLD_BUTTON_SIZE.height,
                                   GOLD_BUTTON_SIZE.width, GOLD_BUTTON_SIZE.height);
    [_goldButton setTitle:@"PICK UP GOLD" forState:UIControlStateNormal];
    [_goldButton setEnabled:YES];
    [self addSubview:_goldButton];
}

/*!
 * Create the label element for displaying the player's gold.
 * @author Henry Loo
 */
- (void)setupGoldLabel
{
    CGSize frameSize = self.frame.size;
    _goldLabel = [[UILabel alloc] initWithFrame:CGRectMake((frameSize.width - GOLD_LABEL_SIZE.width) / 2,
                                                          frameSize.height - GOLD_BUTTON_SIZE.height - GOLD_LABEL_SIZE.height,
                                                          GOLD_LABEL_SIZE.width, GOLD_LABEL_SIZE.height)];
    _goldLabel.textColor = [UIColor blackColor];
    _goldLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goldLabel];
}

/*!
 * Create the button element for moving to the shop.
 * @author Henry Loo
 */
- (void)setupShopButton
{
    _shopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _shopButton.frame = CGRectMake(0, 0,
                                   MENU_BUTTON_SIZE.width, MENU_BUTTON_SIZE.height);
    [_shopButton setTitle:@"SHOP" forState:UIControlStateNormal];
    [_shopButton setTitle:@"" forState:UIControlStateDisabled];
    [_shopButton setEnabled:NO];
    [self addSubview:_shopButton];
}

@end
