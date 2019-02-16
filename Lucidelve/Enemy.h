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
 * @param life The amount of health this enemy has.
 * @param attackDelay The delay between attacks, in seconds.
 * @param attackPatterns The different types of attacks that this enemy
 * can perform.
 * @return A pointer to this instance.
 */
- (id)initWithData:(int)life withAttackDelay:(float)attackDelay
withAttackPatterns:(NSMutableArray*)attackPatterns;

@end
