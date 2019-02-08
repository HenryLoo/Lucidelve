//
//  Player.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

/*!
 * @brief Contains values relating to the player.
 */
@interface Player : NSObject

/*!
 * Defines the different states that the player can
 * be in during combat.
 */
typedef enum
{
    NEUTRAL,
    REGULAR_ATTACKING,
    HIGH_ATTACKING,
    BLOCKING,
    DODGING,
    HURT,
    DEAD
} CombatState;

// Holds all the player's items
@property NSMutableArray *items;

/*!
 * Increment the player's current life by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the player's current life by.
 * A positive value corresponds to a "heal", while a negative value
 * corresponds to taking "damage".
 */
- (void)addLife:(int)amount;

/*!
 * Increment the player's max life by one.
 * This will typically be used during health upgrades.
 * @author Henry Loo
 */
- (void)addMaxLife;

/*!
 * Increment the player's gold by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the player's gold by.
 * Setting this to a negative value will decrement the gold instead.
 */
- (void)addGold:(int)amount;

/*!
 * Return the player's gold amount
 * @author Henry Loo
 *
 * @return The player's gold
 */
- (int)getGold;

/*!
 * Change the player's current combat state to a new one.
 * @author Henry Loo
 *
 * @param newState The new combat state to change to.
 */
- (void)setCombatState:(CombatState)newState;

/*!
 * Add an item to the player's inventory.
 * @author Henry Loo
 *
 * @param item The item to give the player.
 */
- (void)addItem:(Item)item;

/*!
 * Return the item from the player's inventory at a given index.
 * @author Henry Loo
 *
 * @param index The index of the item in the player's inventory.
 * @return The item at the given index.
 */
- (Item)getItem:(int)index;

@end
