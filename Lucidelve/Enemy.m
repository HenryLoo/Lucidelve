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
    
    // The delay in seconds between attacks.
    float attackDelay;
    
    // The current cooldown timer for attacks.
    float attackTimer;
    
    // The enemy's attack patterns. The different attacks are
    // uniquely identified by their index in the array.
    NSMutableArray *attackPatterns;
}

@end

@implementation Enemy

- (id)initWithData:(NSString *)name withLife:(int)life
   withAttackDelay:(float)attackDelay withAttackPatterns:(NSMutableArray*)attackPatterns
{
    if (self = [super initWithData:life]) {
        self->name = name;
        self->attackDelay = attackDelay;
        self->attackPatterns = attackPatterns;
    }
    return self;
}

- (NSString*)getName
{
    return name;
}

@end
