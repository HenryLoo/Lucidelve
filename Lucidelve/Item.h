//
//  Item.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

/*!
 * @brief Defines the different types of items
 */
typedef enum
{
    ITEM_NONE,
    ITEM_RUSTY_SWORD,
    ITEM_HEALING_POTION,
    ITEM_BOMB,
    ITEM_HEART_COOKIE,
    ITEM_POLISHED_SWORD,
    ITEM_SHARP_SWORD,
    ITEM_TOO_SHARP_SWORD,
    ITEM_MAGIC_GOOSE_SWORD,
    ITEM_GOLDEN_EGG,
    ITEM_SHIELD,
    ITEM_NUM_ITEMS
} ItemType;

/*!
 * @brief Defines the structure of an item
 */
typedef struct Item
{
    // The name of the item.
    NSString *name;
    
    // The item's description.
    NSString *description;
    
    // The item's price in the shop
    int shopPrice;
    
    // Flag for if the player can equip this item in an
    // item slot from the Inventory
    bool isEquippable;
} Item;
