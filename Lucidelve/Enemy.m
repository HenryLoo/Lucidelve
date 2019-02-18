//
//  Enemy.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-15.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Enemy.h"

@interface Enemy ()
{
    // The enemy's name
    NSString *name;
    
    // The enemy's current state.
    EnemyState state;
    
    // The enemy's current health.
    int currentLife;
    
    // The enemy's maximum health.
    int maxLife;
    
    // The delay in seconds between attacks.
    float attackDelay;
    
    // The current cooldown timer for attacks.
    float attackCooldown;
    
    // The enemy's attack patterns. The different attacks are
    // uniquely identified by their index in the array.
    NSMutableArray *attackPatterns;
}

@end

@implementation Enemy

- (id)initWithData:(NSString *)name withLife:(int)life
   withAttackDelay:(float)attackDelay withAttackPatterns:(NSMutableArray*)attackPatterns
{
    if (self = [super init]) {
        self->name = name;
        self->maxLife = life;
        self->attackDelay = attackDelay;
        self->attackPatterns = attackPatterns;
        [self reset];
    }
    return self;
}

- (void)reset
{
    currentLife = maxLife;
    state = ENEMY_NEUTRAL;
    attackCooldown = 0;
}

- (NSString*)getName
{
    return name;
}

- (void)setState:(EnemyState)newState
{
    state = newState;
}

- (EnemyState)getState
{
    return state;
}

- (void)addLife:(int)amount
{
    if (amount < 0)
    {
        [self setState:ENEMY_HURT];
    }
    
    currentLife += amount;
    
    // Clamp the life value between 0 and max
    currentLife = MAX(0, MIN(currentLife, maxLife));
    
    if (currentLife == 0)
    {
        [self setState:ENEMY_DEAD];
    }
}

- (int)getCurrentLife
{
    return currentLife;
}

- (int)getMaxLife
{
    return maxLife;
}

@end
