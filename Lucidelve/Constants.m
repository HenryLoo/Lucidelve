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
};

const int DEFAULT_PLAYER_LIFE = 3;
const float GOLD_COOLDOWN = 5.f;
const int GOLD_EARN_AMOUNT = 5;
const CGSize GOLD_BUTTON_SIZE = {200, 100};
const CGSize GOLD_LABEL_SIZE = {300, 50};
const CGSize MENU_BUTTON_SIZE = {150, 150};
const CGSize SHOP_TITLE_SIZE = {300, 50};
const CGSize BACK_BUTTON_SIZE = {150, 100};
