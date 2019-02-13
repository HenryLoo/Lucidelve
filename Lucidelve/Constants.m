//
//  Constants.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Constants.h"

const Item ITEMS[NUM_ITEMS] = {
    [RUSTY_SWORD] = (Item){.name = @"Rusty Sword", .shopPrice = 10},
    [HEALING_POTION] = (Item){.name = @"Healing Potion", .shopPrice = 0}
};

const int DEFAULT_PLAYER_LIFE = 3;
const float GOLD_COOLDOWN = 5.f;
const int GOLD_EARN_AMOUNT = 10;
