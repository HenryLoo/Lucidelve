//
//  GameCharacter.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-18.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GameCharacter.h"
#import "Constants.h"

@interface GameCharacter ()
{
    // The character's life values, in the form: currentLife / maxLife
    int currentLife;
    int maxLife;
    
    // The character's current combat state
    CombatState state;
    
    // The remaining delay in seconds between each character action,
    // before the character's combat state reverts to Neutral.
    float actionTimer;
}

@end

@implementation GameCharacter

- (id)initWithData:(int)life
{
    if (self = [super init]) {
        maxLife = life;
        [self reset:true];
    }
    return self;
}

- (void)reset:(bool)isResettingLife
{
    if (isResettingLife)
    {
        currentLife = maxLife;
    }
    
    state = COMBAT_NEUTRAL;
    actionTimer = 0;
}

- (void)update:(float)deltaTime
{
    CombatState state = [self getCombatState];
    if (state != COMBAT_NEUTRAL && state != COMBAT_DEAD)
    {
        // We just changed from Neutral, so start the cooldown
        if (actionTimer == 0)
        {
            actionTimer = COMBAT_COOLDOWN;
        }
        
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        actionTimer += deltaTime;
        actionTimer = MAX(0, actionTimer);
        
        // Cooldown is over, so reset to Neutral
        if (actionTimer == 0)
        {
            [self setCombatState:COMBAT_NEUTRAL];
        }
    }
}

- (void)addLife:(int)amount
{
    if (amount < 0)
    {
        [self setCombatState:COMBAT_HURT];
        
        // Restart the action cooldown
        actionTimer = COMBAT_COOLDOWN;
    }
    
    currentLife += amount;
    
    // Clamp the life value between 0 and max
    currentLife = MAX(0, MIN(currentLife, maxLife));
    
    if (currentLife == 0)
    {
        [self setCombatState:COMBAT_DEAD];
    }
}

- (void)addMaxLife
{
    ++maxLife;
}

- (int)getCurrentLife
{
    return currentLife;
}

- (int)getMaxLife
{
    return maxLife;
}

- (void)setCombatState:(CombatState)newState
{
    state = newState;
}

- (CombatState)getCombatState
{
    return state;
}

@end
