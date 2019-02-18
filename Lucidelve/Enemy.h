//
//  Enemy.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-14.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Contains values relating to enemies.
 */
@interface Enemy : NSObject

/*!
 * Defines the different types of enemies.
 */
typedef enum
{
    ENEMY_NONE,
    ENEMY_TREE,
    ENEMY_NUM_ENEMIES
} EnemyType;

/*!
 * Defines the different combat states for enemies.
 */
typedef enum
{
    ENEMY_NEUTRAL,
    ENEMY_ATTACKING,
    ENEMY_ALERT,
    ENEMY_HURT,
    ENEMY_DEAD
} EnemyState;

typedef struct EnemyAttack
{
    // The amount of damage this attack deals.
    int damage;
    
    // Flag for if the attack is blockable.
    bool isBlockable;
    
    // Flag for if the attack is dodgeable.
    bool isDodgeable;
} EnemyAttack;

/*!
 * Initialize an enemy with a life value, attack delay value in seconds,
 * and an array of attack patterns.
 * @author Henry Loo
 *
 * @param name The enemy's name.
 * @param life The amount of health this enemy has.
 * @param attackDelay The delay between attacks, in seconds.
 * @param attackPatterns The different types of attacks that this enemy
 * can perform.
 * @return A pointer to this instance.
 */
- (id)initWithData:(NSString *)name withLife:(int)life
   withAttackDelay:(float)attackDelay withAttackPatterns:(NSMutableArray*)attackPatterns;

/*!
 * Reset the enemy's life, attack cooldown, and state to
 * default values.
 * @author Henry Loo
 */
- (void)reset;

/*!
 * Return the enemy's name.
 * @author Henry Loo
 *
 * @return The enemy's name.
 */
- (NSString*)getName;

/*!
 * Change the enemy's current state to a new one.
 * @author Henry Loo
 *
 * @param newState The new state to change to.
 */
- (void)setState:(EnemyState)newState;

/*!
 * Return the enemy's state.
 * @author Henry Loo
 *
 * @return The enemy's state.
 */
- (EnemyState)getState;

/*!
 * Increment the enemy's current life by a specified amount.
 * @author Henry Loo
 *
 * @param amount The value to increment the enemy's current life by.
 * A positive value corresponds to a "heal", while a negative value
 * corresponds to taking "damage".
 */
- (void)addLife:(int)amount;

/*!
 * Return the enemy's current life.
 * @author Henry Loo
 *
 * @return The enemy's current life.
 */
- (int)getCurrentLife;

/*!
 * Return the enemy's max life.
 * @author Henry Loo
 *
 * @return The enemy's max life.
 */
- (int)getMaxLife;

@end
