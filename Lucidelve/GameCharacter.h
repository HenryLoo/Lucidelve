//
//  GameCharacter.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-18.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Contains common values for game characters
 */
@interface GameCharacter : NSObject

/*!
 * Defines the different states that the characters can
 * be in during combat.
 */
typedef enum
{
    COMBAT_NEUTRAL,
    COMBAT_ATTACKING,
    COMBAT_ATTACKING2,
    COMBAT_BLOCKING,
    COMBAT_DODGING_LEFT,
    COMBAT_DODGING_RIGHT,
    COMBAT_HURT,
    COMBAT_DEAD,
    COMBAT_ALERT
} CombatState;

/*!
 * Initialize a character with a life value.
 * @author Henry Loo
 *
 * @param life The amount of health this character has.
 * @return A pointer to this instance.
 */
- (id)initWithData:(int)life;

/*!
 * Reset the character's life, attack cooldown, and state to
 * default values.
 * @author Henry Loo
 *
 * @param isResettingLife Flag for if current life is reset.
 */
- (void)reset:(bool)isResettingLife;

/*!
 * Update the character's values.
 * This should be called each frame in the update loop.
 */
- (void)update:(float)deltaTime;

/*!
 * Increment the character's current life by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the character's current life by.
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
 * Return the character's current life.
 * @author Henry Loo
 *
 * @return The character's current life.
 */
- (int)getCurrentLife;

/*!
 * Return the character's max life.
 * @author Henry Loo
 *
 * @return The character's max life.
 */
- (int)getMaxLife;

/*!
 * Change the character's current combat state to a new one.
 * @author Henry Loo
 *
 * @param newState The new combat state to change to.
 */
- (void)setCombatState:(CombatState)newState;

/*!
 * Return the character's combat state.
 * @author Henry Loo
 *
 * @return The character's combat state.
 */
- (CombatState)getCombatState;

@end