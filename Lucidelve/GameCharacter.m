
//
//  GameCharacter.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-18.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GameCharacter.h"
#import "Constants.h"
#import "Mesh.h"
#import "Primitives.h"
#import "Assets.h"
#import "Renderer.h"
#import "GLProgram.h"

@interface GameCharacter ()
{
    // The character's mesh
    //Mesh *mesh;
    
    // The character's life values, in the form: currentLife / maxLife
    int currentLife;
    int maxLife;
    
    // The character's current combat state
    CombatState state;
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
    _actionTimer = 0;
}

- (void)update:(float)deltaTime
{
    if (_actionTimer > 0)
    {
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        _actionTimer += deltaTime;
        _actionTimer = MAX(0, _actionTimer);
    }
    
    _position = GLKVector3Add(_position, GLKVector3MultiplyScalar(_velocity, deltaTime));
    
    // Decelerate the character
    if (_velocity.x > 0) _velocity.x += (CHARACTER_DECEL * deltaTime);
    else if (_velocity.x < 0) _velocity.x -= (CHARACTER_DECEL * deltaTime);
    
    if (_velocity.y > 0) _velocity.y += (CHARACTER_DECEL * deltaTime);
    else if (_velocity.y < 0) _velocity.y -= (CHARACTER_DECEL * deltaTime);
    
    if (_velocity.z > 0) _velocity.z += (CHARACTER_DECEL * deltaTime);
    else if (_velocity.z < 0) _velocity.z -= (CHARACTER_DECEL * deltaTime);
    
    if (_velocity.x > -CHARACTER_VEL_THRESHOLD && _velocity.x < CHARACTER_VEL_THRESHOLD) _velocity.x = 0;
    if (_velocity.y > -CHARACTER_VEL_THRESHOLD && _velocity.y < CHARACTER_VEL_THRESHOLD) _velocity.y = 0;
    if (_velocity.z > -CHARACTER_VEL_THRESHOLD && _velocity.z < CHARACTER_VEL_THRESHOLD) _velocity.z = 0;
}

- (void)addLife:(int)amount
{
    if (amount < 0)
    {
        [self setCombatState:COMBAT_HURT];
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
    // Start cooldown if changing from neutral or taking damage
    if (state == COMBAT_NEUTRAL || newState == COMBAT_HURT)
    {
        _actionTimer = COMBAT_COOLDOWN;
    }
    
    state = newState;
}

- (CombatState)getCombatState
{
    return state;
}

@end
