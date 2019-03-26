//
//  Enemy.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-14.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

/*!
 * @brief Contains values relating to enemies.
 */
@interface Enemy : GameCharacter

typedef struct EnemyAttack
{
    // The amount of damage this attack deals.
    int damage;
    
    // Flag for if the attack is blockable.
    bool isBlockable;
    
    // Flag for if the attack is dodgeable.
    bool isDodgeable;
    
    // Flag for if the attack is interruptable.
    bool isInterruptable;
    
    // Duration of time for staying in alert state, in seconds
    float alertDelay;
    
    // Duration of time for staying in attacking state, in seconds
    float attackDelay;
} EnemyAttack;

// The enemy's current attack pattern.
@property EnemyAttack currentAttack;

// Flag for if the enemy is attacking during this frame.
// This should only be true on the first frame of the attack.
@property bool isAttacking;

// The enemy's spritesheet.
@property NSString *texture;

/*!
 * @brief Initialize an enemy with a life value, attack delay value in seconds,
 * and an array of attack patterns.
 * @author Henry Loo
 *
 * @param name The enemy's name.
 * @param life The amount of health this enemy has.
 * @param minAttackDelay The minimum delay between attacks, in seconds.
 * @param maxAttackDelay The maximum delay between attacks, in seconds.
 * @param blockChance The chance that a player attack will be blocked.
 * @param attackPatterns The different types of attacks that this enemy
 * can perform.
 *
 * @return A pointer to this instance.
 */
- (id)initWithData:(NSString *)name withTexture:(NSString *)texture withLife:(int)life
   withMinDelay:(float)minAttackDelay withMaxDelay:(float)maxAttackDelay
   withBlockChance:(float)blockChance withAttackPatterns:(NSMutableArray*)attackPatterns;

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
 * @brief Return the enemy's name.
 * @author Henry Loo
 *
 * @return The enemy's name.
 */
- (NSString*)getName;

/*!
 * @brief Try to block an attack, based on this enemy's block chance.
 * If successfully blocked, then return true. Otherwise return false.
 * @author Henry Loo
 *
 * @return The success of the block.
 */
- (bool)tryBlockingAttack;

/*!
 * @brief Change the character's current combat state to a new one.
 * @author Henry Loo
 *
 * @param newState The new combat state to change to.
 */
- (void)setCombatState:(CombatState)newState;

@end
