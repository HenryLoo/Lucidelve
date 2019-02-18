//
//  Game.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@class Player;
@class BaseVC;
@class Dungeon;
@class DungeonNode;

/*!
 * @brief Handle general persistent data throughout the life of the game.
 */
@interface Game : NSObject

// The time for the previous frame, used in The Hub's scenes.
@property NSDate *hubLastTime;

// The time for the previous frame, used in The Dungeon's scenes.
@property NSDate *dungeonLastTime;

// The time between each frame in seconds.
@property NSTimeInterval deltaTime;

// The current value of the gold button's cooldown.
// This value should be decremented every frame by deltaTime
// starting until it reaches 0.
@property float goldCooldownTimer;

// Flag for if the Shop has been unlocked.
@property bool isShopUnlocked;

// Flag for if the Rusty Sword has been bought.
@property bool isSwordBought;

// Flag for if Inventory has been unlocked.
@property bool isInventoryUnlocked;
    
// Flag for if Dungeons has been unlocked.
@property bool isDungeonsUnlocked;

/*!
 * Return the player's data.
 * @author Henry Loo
 */
- (Player*)getPlayer;

/*!
 * Change the current scene to a new specified one.
 * @author Henry Loo
 *
 * @param currentVC The view controller for the current scene.
 * @param newVC The view controller for the new scene.
 */
- (void)changeScene:(BaseVC*)currentVC newVC:(BaseVC*)newVC;

/*!
 * Return the dungeon corresponding to the given level,
 * starting with index 0.
 * @author Henry Loo
 */
- (Dungeon*)getDungeon:(NSUInteger)level;

/*!
 * Get the number of dungeons types.
 * @author Henry Loo
 *
 * @return The number of dungeon types.
 */
- (NSUInteger)getNumDungeons;

/*!
 * Get an enemy, given its type.
 * @author Henry Loo
 *
 * @param type The enemy's type.
 * @return The enemy.
 */
- (Enemy*)getEnemy:(EnemyType)type;

@end
