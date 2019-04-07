//
//  Constants.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Constants.h"

const Item ITEMS[ITEM_NUM_ITEMS] = {
    [ITEM_NONE] = (Item){.name = @"None"},
    [ITEM_RUSTY_SWORD] = (Item){.name = @"Rusty Sword", .description = @"You can explore the Dungeon with this.", .shopPrice = 10},
    [ITEM_HEALING_POTION] = (Item){.name = @"Potion", .description = @"Fully restore Life and Stamina.", .shopPrice = 20, .isEquippable = true},
    [ITEM_POLISHED_SWORD] = (Item){.name = @"Polished Sword", .description = @"It's not rusty anymore."},
    [ITEM_SHARP_SWORD] = (Item){.name = @"Sharp Sword", .description = @"It's pretty sharp, I guess."},
    [ITEM_TOO_SHARP_SWORD] = (Item){.name = @"Way-too-sharp Sword", .description = @"Those monsters had better watch out."},
    [ITEM_MAGIC_GOOSE_SWORD] = (Item){.name = @"Magic Goose Sword", .description = @"NOTHING IS IMPOSSIBLE."},
    [ITEM_BOMB] = (Item){.name = @"Bomb", .description = @"Stun and deal 30 damage.", .shopPrice = 30, .isEquippable = true},
    [ITEM_HEART_COOKIE] = (Item){.name = @"Heart Cookie", .shopPrice = 30},
    [ITEM_SHIELD] = (Item){.name = @"Shield", .description = @"50% chance to auto-block for 1 fight.", .shopPrice = 15, .isEquippable = true},
    [ITEM_GOLDEN_EGG] = (Item){.name = @"Golden Egg", .description = @"I threw all my money for this."},
};

const float PLAYER_WALK_SPEED = 0.2;
const int NUM_PLAYER_WALK_SPRITES = 4;
const float GRAVITY = -2;
const float THROW_TIME = 1;
const float FLOOR_ANGLE = M_PI / 2.5;
const int BOMB_DAMAGE = 30;
const float CHARACTER_DECEL = -15;
const float CHARACTER_VEL_THRESHOLD = 0.5;
const int DEFAULT_PLAYER_LIFE = 3;
const int DEFAULT_PLAYER_STAMINA = 5;
const float STAMINA_COOLDOWN = 10;
const float COMBAT_COOLDOWN = 0.3f;
const float BLOCK_DURATION = 0.2f;
const float DODGE_DURATION = 0.4f;
const float DEFENCE_COOLDOWN = 0.4f;
const float ENEMY_STUN_DURATION = 2.f;
const int MAX_LIFE_UPGRADES = 10;
const float GOLD_COOLDOWN = 5.f;
const int GOLD_EARN_AMOUNT = 10;
const int NO_SELECTED_ITEM = -1;
const int MAX_EQUIPPED_ITEMS = 2;
const int NO_SELECTED_DUNGEON = -1;
const int MAX_GOOSE_UPGRADES = 59;
const int GOOSE_BASE_PRICE = 1;
const int GOOSE_BASE_AMOUNT = 1;
const int GOOSE_BASE_DELAY = 60 * 60 * 24;
const float GOOSE_PRICE_MULTIPLIER = 1.05;
const int MAX_BLACKSMITH_UPGRADES = 3;
const int BLACKSMITH_BASE_PRICE = 100;
const float BLACKSMITH_PRICE_MULTIPLIER = 1.5;

const int SWORD_UPGRADES[MAX_BLACKSMITH_UPGRADES+2] = {
    ITEM_RUSTY_SWORD,
    ITEM_POLISHED_SWORD,
    ITEM_SHARP_SWORD,
    ITEM_TOO_SHARP_SWORD,
    ITEM_MAGIC_GOOSE_SWORD
};
