//
//  Constants.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Constants.h"

const Item ITEMS[ITEM_NUM_ITEMS] = {
    [ITEM_RUSTY_SWORD] = (Item){.name = @"Rusty Sword", .shopPrice = 10},
    [ITEM_HEALING_POTION] = (Item){.name = @"Healing Potion", .shopPrice = 0}
};

const int DEFAULT_PLAYER_LIFE = 3;
const float GOLD_COOLDOWN = 5.f;
const int GOLD_EARN_AMOUNT = 10;
const float COMBAT_COOLDOWN = 0.3f;
const int MAX_GOOSE_UPGRADES = 2;
const int GOOSE_BASE_PRICE = 20;
const int GOOSE_BASE_AMOUNT = 1;
const int GOOSE_BASE_DELAY = 5;
const float GOOSE_PRICE_MULTIPLIER = 1.2;
