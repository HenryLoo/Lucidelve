//
//  Player.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Player.h"
#import "Constants.h"

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

- (id)init
{
    if (self = [super init]) {
        currentLife = maxLife = DEFAULT_PLAYER_LIFE;
        gold = 0;
        state = NEUTRAL;
        _items = [[NSMutableArray alloc] init];
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

- (void)addItem:(Item)item
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
    [self.items addObject:wrappedItem];
}

- (Item)getItem:(int)index
{
    // Unwrap the Item struct from the stored NSValue
    Item item;
    NSValue *wrappedItem = [self.items objectAtIndex:index];
    [wrappedItem getValue:&item];
    return item;
}

@end
