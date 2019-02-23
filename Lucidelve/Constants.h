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
extern const Item ITEMS[ITEM_NUM_ITEMS];

// The player's default starting life value
extern const int DEFAULT_PLAYER_LIFE;

// The cooldown on gold button press, in seconds
extern const float GOLD_COOLDOWN;

// The amount of gold to earn per button press
extern const int GOLD_EARN_AMOUNT;

// The cooldown between combat actions
extern const float COMBAT_COOLDOWN;

// The maximum number of upgrades for the Golden Goose
extern const int MAX_GOOSE_UPGRADES;

// The cost for the first Golden Goose upgrade
extern const int GOOSE_BASE_PRICE;

// The amount of gold earned per instance for the first
// Golden Goose upgrade
extern const int GOOSE_BASE_AMOUNT;

// The delay between instances in seconds for the first
// Golden Goose upgrade
extern const int GOOSE_BASE_DELAY;

// The multipler to increase price by per upgrade level
extern const float GOOSE_PRICE_MULTIPLIER;
