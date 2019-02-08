//
//  Constants.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

// Hold all item values
extern const Item ITEMS[NUM_ITEMS];

// The player's default starting life value
extern const int DEFAULT_PLAYER_LIFE;

// The cooldown on gold button press, in seconds
extern const float GOLD_COOLDOWN;

// The amount of gold to earn per button press
extern const int GOLD_EARN_AMOUNT;

// The size of the gold button
extern const CGSize GOLD_BUTTON_SIZE;

// The size of the gold label
extern const CGSize GOLD_LABEL_SIZE;

// The size of the menu buttons
extern const CGSize MENU_BUTTON_SIZE;

// The size of the shop title
extern const CGSize SHOP_TITLE_SIZE;

// The size of the back button
extern const CGSize BACK_BUTTON_SIZE;
