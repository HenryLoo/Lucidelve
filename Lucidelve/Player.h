//
//  Player.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "GameCharacter.h"

/*!
 * @brief Contains values relating to the player.
 */
@interface Player : GameCharacter

/*!
 * @brief Update the character's values.
 * This should be called each frame in the update loop.
 */
- (void)update:(float)deltaTime;

/*!
 * @brief Reset the character's life, attack cooldown, and state to
 * default values.
 * @author Henry Loo
 *
 * @param isResettingLife Flag for if current life is reset.
 */
- (void)reset:(bool)isResettingLife;

/*!
 * @brief Increment the player's gold by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the player's gold by.
 * Setting this to a negative value will decrement the gold instead.
 */
- (void)addGold:(int)amount;

/*!
 * @brief Return the player's gold amount
 * @author Henry Loo
 *
 * @return The player's gold
 */
- (int)getGold;

/*!
 * @brief Increment the player's current stamina by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the character's current stamina by.
 */
- (void)addStamina:(int)amount;

/*!
 * @brief Increment the player's max stamina by one.
 * This will typically be used during stamina upgrades.
 * @author Henry Loo
 */
- (void)addMaxStamina;

/*!
 * @brief Return the player's current stamina.
 * @author Henry Loo
 *
 * @return The player's current stamina.
 */
- (int)getCurrentStamina;

/*!
 * @brief Return the player's max stamina.
 * @author Henry Loo
 *
 * @return The player's max stamina.
 */
- (int)getMaxStamina;

/*!
 * @brief Add an item to the player's inventory.
 * @author Henry Loo
 *
 * @param item The item to give the player.
 */
- (void)addItem:(Item)item;

/*!
 * @brief Return the item from the player's inventory at a given index.
 * @author Henry Loo
 *
 * @param index The index of the item in the player's inventory.
 *
 * @return The item at the given index.
 */
- (Item)getItem:(NSUInteger)index;

/*!
 * @brief Get the index of the first instance of the item in the player's
 * inventory. If the item is not found, return NSNotFound.
 * @author Henry Loo
 *
 * @param item The item to check.
 *
 * @return The index of the first instance of the item.
 */
- (NSUInteger)getIndexOfItem:(Item)item;

/*!
 * @brief Remove the first instance of an item from the player's inventory.
 * @author Henry Loo
 *
 * @param item The item to remove.
 */
- (void)removeItem:(Item)item;

/*!
 * @brief Remove the item at the given index from the player's inventory.
 * @author Henry Loo
 *
 * @param index The index of the item to remove.
 */
- (void)removeItemAtIndex:(NSUInteger)index;

/*!
 * @brief Replace the first instance of an item with a new item.
 * @author Henry Loo
 *
 * @param itemToReplace The item to replace.
 * @param newItem The new item to replace with.
 */
- (void)replaceItem:(Item)itemToReplace replaceWith:(Item)newItem;

/*!
 * @brief Check if the player has a given item in their inventory.
 * @author Henry Loo
 *
 * @param item The item to check.
 *
 * @return Whether the player has the given item or not.
 */
- (bool)hasItem:(Item)item;

/*!
 * @brief Return the number of items that the player owns.
 * @author Henry Loo
 *
 * @return The number of items that the player owns.
 */
- (NSUInteger)getNumItems;

/*!
 * @brief Equip an item from a given index onto the given Inventory item slot.
 * @author Henry Loo
 *
 * @param index The index of the item to equip.
 * @param itemSlot The item slot to equip the item to.
 */
- (void)equipItem:(NSUInteger)index withItemSlot:(int)itemSlot;


/*!
 * @brief Unequip an item from the given Inventory item slot.
 * @author Henry Loo
 *
 * @param itemSlot The item slot to unequip the item from.
 */
- (void)unequipItem:(int)itemSlot;

/*!
 * @brief Get the equipped item from the given Inventory item slot.
 * @author Henry Loo
 *
 * @param itemSlot The item slot to check.
 *
 * @return The equipped item.
 */
- (Item)getEquippedItem:(int)itemSlot;

@end
