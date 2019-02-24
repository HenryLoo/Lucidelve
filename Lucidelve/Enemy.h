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
} EnemyAttack;

/*!
 * @brief Initialize an enemy with a life value, attack delay value in seconds,
 * and an array of attack patterns.
 * @author Henry Loo
 *
 * @param name The enemy's name.
 * @param life The amount of health this enemy has.
 * @param attackDelay The delay between attacks, in seconds.
 * @param attackPatterns The different types of attacks that this enemy
 * can perform.
 *
 * @return A pointer to this instance.
 */
- (id)initWithData:(NSString *)name withLife:(int)life
   withAttackDelay:(float)attackDelay withAttackPatterns:(NSMutableArray*)attackPatterns;

/*!
 * @brief Return the enemy's name.
 * @author Henry Loo
 *
 * @return The enemy's name.
 */
- (NSString*)getName;

@end
