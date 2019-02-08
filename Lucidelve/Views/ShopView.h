//
//  ShopView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

/*!
 * @brief The view for the Shop.
 */
@interface ShopView : GLKView

// Displays the shop's title
@property (nonatomic, strong) UILabel *shopTitle;

// Displays the back button
@property (nonatomic, strong) UIButton *backButton;

// Displays the player's current gold
@property (nonatomic, strong) UILabel *goldLabel;

// Displays the button to buy a sword
@property (nonatomic, strong) UIButton *swordButton;

@end
