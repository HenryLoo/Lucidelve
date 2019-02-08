//
//  Item.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

/*!
 * Defines the different types of items
 */
typedef enum
{
    NONE,
    RUSTY_SWORD,
    HEALING_POTION,
    BOMB,
    HEART_COOKIE,
    POLISHED_SWORD,
    SHARP_SWORD,
    TOO_SHARP_SWORD,
    MAGIC_GOOSE_SWORD,
    GOLDEN_EGG,
    NUM_ITEMS
} ItemType;

/*!
 * Defines the structure of an item
 */
typedef struct Item
{
    // The name of the item.
    NSString *name;
    
    // The item's price in the shop
    int shopPrice;
} Item;
