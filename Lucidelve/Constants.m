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
    [ITEM_RUSTY_SWORD] = (Item){.name = @"Rusty Sword", .shopPrice = 10},
    [ITEM_HEALING_POTION] = (Item){.name = @"Healing Potion", .shopPrice = 1, .isEquippable = true},
    [ITEM_POLISHED_SWORD] = (Item){.name = @"Polished Sword"},
    [ITEM_SHARP_SWORD] = (Item){.name = @"Sharp Sword"},
    [ITEM_TOO_SHARP_SWORD] = (Item){.name = @"Way-too-sharp Sword"},
    [ITEM_MAGIC_GOOSE_SWORD] = (Item){.name = @"Magic Goose Sword"},
    [ITEM_BOMB] = (Item){.name = @"Bomb", .shopPrice = 1, .isEquippable = true},
    [ITEM_HEART_COOKIE] = (Item){.name = @"Heart Cookie", .shopPrice = 1},
    [ITEM_SHIELD] = (Item){.name = @"Shield", .shopPrice = 1, .isEquippable = true},
    [ITEM_GOLDEN_EGG] = (Item){.name = @"Golden Egg"},
};

const float PLAYER_WALK_SPEED = 0.2;
const int NUM_PLAYER_WALK_SPRITES = 4;
const float CHARACTER_DECEL = 15;
const float CHARACTER_VEL_THRESHOLD = 0.01;
const int DEFAULT_PLAYER_LIFE = 3;
const int DEFAULT_PLAYER_STAMINA = 5;
const float STAMINA_COOLDOWN = 5;
const int MAX_LIFE_UPGRADES = 5;
const float GOLD_COOLDOWN = 5.f;
const int GOLD_EARN_AMOUNT = 10;
const int NO_SELECTED_ITEM = -1;
const int MAX_EQUIPPED_ITEMS = 2;
const float COMBAT_COOLDOWN = 0.3f;
const int MAX_GOOSE_UPGRADES = 2;
const int GOOSE_BASE_PRICE = 20;
const int GOOSE_BASE_AMOUNT = 1;
const int GOOSE_BASE_DELAY = 5;
const float GOOSE_PRICE_MULTIPLIER = 1.2;
const int MAX_BLACKSMITH_UPGRADES = 3;
const int BLACKSMITH_BASE_PRICE = 1;
const float BLACKSMITH_PRICE_MULTIPLIER = 1.5;

const int SWORD_UPGRADES[MAX_BLACKSMITH_UPGRADES+2] = {
    ITEM_RUSTY_SWORD,
    ITEM_POLISHED_SWORD,
    ITEM_SHARP_SWORD,
    ITEM_TOO_SHARP_SWORD,
    ITEM_MAGIC_GOOSE_SWORD
};
