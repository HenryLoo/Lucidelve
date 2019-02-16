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
    int life;
    
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

- (id)initWithData:(int)life withAttackDelay:(float)attackDelay
withAttackPatterns:(NSMutableArray*)attackPatterns
{
    if (self = [super init]) {
        self->life = life;
        self->attackDelay = attackDelay;
        self->attackPatterns = attackPatterns;
        state = ENEMY_NEUTRAL;
        attackCooldown = 0;
    }
    return self;
}

@end
