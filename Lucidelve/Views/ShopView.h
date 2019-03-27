//
//  ShopView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for the Shop.
 */
@interface ShopView : BaseView

// Displays the player's current gold
@property (nonatomic, strong) UIPaddedLabel *goldLabel;

// Displays the button to buy a sword
@property (nonatomic, strong) UIButton *swordButton;

// Displays the button to buy a healing potion
@property (nonatomic, strong) UIButton *potionButton;

// Displays the button to buy a heart cookie
@property (nonatomic, strong) UIButton *heartButton;

// Displays the button to buy a bomb
@property (nonatomic, strong) UIButton *bombButton;

// Displays the button to buy a shield
@property (nonatomic, strong) UIButton *shieldButton;

@end
