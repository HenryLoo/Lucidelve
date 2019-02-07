//
//  Player.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Player.h"

@interface Player ()
{
    // The player's life values, in the form: currentLife / maxLife
    int currentLife;
    int maxLife;
    
    // The player's current gold value
    int gold;
    
    // The player's current combat state
    CombatState state;
}

@end

@implementation Player

// The default starting life value
const int DEFAULT_LIFE = 3;

- (id)init
{
    if (self = [super init]) {
        currentLife = maxLife = DEFAULT_LIFE;
        gold = 0;
        state = NEUTRAL;
    }
    return self;
}

- (void)addLife:(int)amount
{
    currentLife += amount;
    
    // Clamp the life value between 0 and max
    currentLife = MAX(0, MIN(currentLife, maxLife));
}

- (void)addMaxLife
{
    ++maxLife;
}

- (void)addGold:(int)amount
{
    gold += amount;
    
    // Can't go into negative gold
    gold = MAX(0, gold);
}

- (int)getGold
{
    return gold;
}

- (void)setCombatState:(CombatState)newState
{
    state = newState;
}

@end
