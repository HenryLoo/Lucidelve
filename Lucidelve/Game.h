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

/*!
 * Return the player's data
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
