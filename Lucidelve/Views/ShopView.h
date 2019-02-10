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
@property (nonatomic, strong) UILabel *goldLabel;

// Displays the button to buy a sword
@property (nonatomic, strong) UIButton *swordButton;

@end
