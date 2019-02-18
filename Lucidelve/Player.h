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
- (Item)getItem:(NSUInteger)index;

/*!
 * Return the number of items that the player owns.
 * @author Henry Loo
 *
 * @return The number of items that the player owns.
 */
- (NSUInteger)getNumItems;

@end
