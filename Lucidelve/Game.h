//
//  Game.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class BaseVC;

/*!
 * @brief Handle general persistent data throughout the life of the game.
 */
@interface Game : NSObject

// The time for the previous frame.
@property NSDate *lastTime;

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

@end
