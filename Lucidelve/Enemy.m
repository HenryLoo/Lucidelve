//
//  Enemy.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-15.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Enemy.h"
#import "Constants.h"
#import "Utility.h"

@interface Enemy ()
{
    // The enemy's name
    NSString *name;
    
    // The minimum delay in seconds between attacks.
    float minAttackDelay;
    
    // The maximum delay in seconds between attacks.
    float maxAttackDelay;
    
    // The current cooldown timer for attacks.
    float attackTimer;
    
    // The enemy's block chance
    float blockChance;
    
    // The enemy's attack patterns. The different attacks are
    // uniquely identified by their index in the array.
    NSMutableArray *attackPatterns;
}

@end

@implementation Enemy

- (id)initWithData:(NSString *)name withTexture:(NSString *)texture withLife:(int)life
   withMinDelay:(float)minAttackDelay withMaxDelay:(float)maxAttackDelay
   withBlockChance:(float)blockChance withAttackPatterns:(NSMutableArray*)attackPatterns
{
    if (self = [super initWithData:life]) {
        self->name = name;
        _texture = texture;
        self->minAttackDelay = minAttackDelay;
        self->maxAttackDelay = maxAttackDelay;
        self->blockChance = blockChance;
        self->attackPatterns = attackPatterns;
    }
    return self;
}

- (void)update:(float)deltaTime
{
    [super update:deltaTime];
    
    // Only register the attack on the first frame
    _isAttacking = false;
    
    if (self.actionTimer == 0)
    {
        switch([self getCombatState])
        {
            case COMBAT_NEUTRAL:
                // If this enemy has attack patterns
                if (attackPatterns.count > 0)
                {
                    // Pick a random attack pattern to perform
                    int index = [[Utility getInstance] random:1 withMax:attackPatterns.count] - 1;
                    EnemyAttack attack;
                    NSValue *attackVal = [attackPatterns objectAtIndex:index];
                    [attackVal getValue:&attack];
                    _currentAttack = attack;
                    [self setCombatState:COMBAT_ALERT];
                    self.actionTimer = _currentAttack.alertDelay;
                }
                break;
                
            case COMBAT_ALERT:
                // Switch to attacking state
                [self setCombatState:COMBAT_ATTACKING];
                self.actionTimer = _currentAttack.attackDelay;
                _isAttacking = true;
                break;
                
            case COMBAT_ATTACKING:
            case COMBAT_HURT:
            case COMBAT_BLOCKING:
                [self setCombatState:COMBAT_NEUTRAL];
                const float precision = 10.f;
                self.actionTimer = (float)[[Utility getInstance] random:minAttackDelay*precision
                                                                withMax:maxAttackDelay*precision] / precision;
                break;
                
            default:
                break;
        }
    }
}

- (void)reset:(bool)isResettingLife
{
    [super reset:isResettingLife];
    
    // Don't allow the enemy to attack right away
    self.actionTimer = maxAttackDelay;
    
    self.spriteIndex = 0;
    self.position = GLKVector3Make(0, 0.5, 0);
}

- (NSString*)getName
{
    return name;
}

- (bool)tryBlockingAttack
{
    int rollBlockChance = [[Utility getInstance] random:1 withMax:100];
    if (rollBlockChance <= blockChance*100)
    {
        [self setCombatState:COMBAT_BLOCKING];
        self.actionTimer = COMBAT_COOLDOWN;
        return true;
    }
    
    return false;
}

- (void)setCombatState:(CombatState)newState
{
    [super setCombatState:newState];
    
    switch (newState)
    {
        case COMBAT_NEUTRAL:
            self.spriteIndex = 0;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = GLKVector3Make(0, 0.5, 0);
            break;
        case COMBAT_ALERT:
            self.spriteIndex = 1;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = GLKVector3Make(0, 0.5, 0);
            break;
        case COMBAT_ATTACKING:
            self.spriteIndex = 2;
            self.velocity = GLKVector3Make(0, 2, -2);
            break;
        case COMBAT_BLOCKING:
            self.spriteIndex = 3;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = GLKVector3Make(0, 0.5, 0);
            break;
        case COMBAT_HURT:
            self.spriteIndex = 4;
            self.velocity = GLKVector3Make(0, -1, 0);
            break;
        case COMBAT_DEAD:
            self.spriteIndex = 4;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = GLKVector3Make(0, 0.5, 0);
            break;
        default:
            break;
    }
}

@end
