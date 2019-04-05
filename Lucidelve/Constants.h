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
extern const Item ITEMS[];

// The animation speed of the player's walk cycle
extern const float PLAYER_WALK_SPEED;

// The number of sprites in the player's walk cycle
extern const int NUM_PLAYER_WALK_SPRITES;

// Constant gravity for decelerating throwable items
extern const float GRAVITY;

// The amount time it takes (in seconds) to throw an item at the target
extern const float THROW_TIME;

// The angle that the dungeon floor is tilted at
extern const float FLOOR_ANGLE;

// The amount of health to heal from a healing potion
extern const int POTION_HEAL_AMOUNT;

// The amount of damage that a bomb deals
extern const int BOMB_DAMAGE;

// Constant deceleration for character movement in Combat
extern const float CHARACTER_DECEL;

// The threshold velocity to round down to 0 in Combat
extern const float CHARACTER_VEL_THRESHOLD;

// The player's default starting life value
extern const int DEFAULT_PLAYER_LIFE;

// The player's default starting stamina value
extern const int DEFAULT_PLAYER_STAMINA;

// The cooldown for regenerating stamina
extern const float STAMINA_COOLDOWN;

// The maximum number of heart cookies that a player can purchase
extern const int MAX_LIFE_UPGRADES;

// The cooldown on gold button press, in seconds
extern const float GOLD_COOLDOWN;

// The amount of gold to earn per button press
extern const int GOLD_EARN_AMOUNT;

// The index that represents no item selected in the Inventory
extern const int NO_SELECTED_ITEM;

// The maximum number of equipped items
extern const int MAX_EQUIPPED_ITEMS;

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

// The multipler to increase price by per upgrade level for the Golden Goose
extern const float GOOSE_PRICE_MULTIPLIER;

// The maximum number of upgrades for the Blacksmith
extern const int MAX_BLACKSMITH_UPGRADES;

// The cost for the first Blacksmith upgrade
extern const int BLACKSMITH_BASE_PRICE;

// The multipler to increase price by per upgrade level for the Blacksmith
extern const float BLACKSMITH_PRICE_MULTIPLIER;

// Hold the sword items corresponding to each upgrade level
extern const int SWORD_UPGRADES[];
