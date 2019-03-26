//
//  Player.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Player.h"
#import "Constants.h"
#import "Utility.h"
#import "Assets.h"
#import "AudioPlayer.h"

@interface Player ()
{
    // The player's current gold value
    int gold;
    
    // The player's stamina values, in the form: currentStamina / maxStamina
    int currentStamina;
    int maxStamina;
    
    // Timer for regenerating stamina
    float staminaTimer;
    
    // Holds all the player's items
    NSMutableArray *items;
    
    // The player's currently equipped items
    NSMutableArray *equippedItems;
    
    // The default position in Combat
    GLKVector3 playerNeutralPos;
}

@end

@implementation Player

- (id)init
{
    if (self = [super initWithData:DEFAULT_PLAYER_LIFE]) {
        gold = 0;
        items = [[NSMutableArray alloc] init];
        maxStamina = DEFAULT_PLAYER_STAMINA;
        currentStamina = maxStamina;
        
        // Initialize equipped items as empty
        equippedItems = [[NSMutableArray alloc] initWithCapacity:MAX_EQUIPPED_ITEMS];
        for (int i = 0; i < MAX_EQUIPPED_ITEMS; ++i)
        {
            Item item = ITEMS[ITEM_NONE];
            NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
            [equippedItems addObject:wrappedItem];
        }
        
        playerNeutralPos = GLKVector3Make(0, -0.4, 0.5);
    }
    return self;
}

- (void)update:(float)deltaTime
{
    // Regenerate stamina if not full
    if (staminaTimer > 0 && currentStamina < maxStamina)
    {
        // Decrement stamina timer and make sure it doesn't
        // drop lower than 0
        staminaTimer += deltaTime;
        staminaTimer = MAX(0, staminaTimer);
    }
    else
    {
        [self addStamina:1];
        staminaTimer = STAMINA_COOLDOWN;
    }
    
    [super update:deltaTime];
    
    if (self.actionTimer == 0)
    {
        switch ([self getCombatState])
        {
            // Cooldown is over, so reset to Neutral
            case COMBAT_BLOCKING:
            case COMBAT_DODGING_LEFT:
            case COMBAT_DODGING_RIGHT:
            case COMBAT_ATTACKING:
            case COMBAT_ATTACKING2:
            case COMBAT_HURT:
                [self setCombatState:COMBAT_NEUTRAL];
                break;
                
            default:
                break;
        }
    }
}

- (void)reset:(bool)isResettingLife
{
    [super reset:isResettingLife];
    
    currentStamina = maxStamina;
    self.spriteIndex = 0;
    self.position = playerNeutralPos;
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

- (void)addStamina:(int)amount
{
    currentStamina += amount;
    
    // Clamp the life value between 0 and max
    currentStamina = MAX(0, MIN(currentStamina, maxStamina));
}

- (void)addMaxStamina
{
    ++maxStamina;
}

- (int)getCurrentStamina
{
    return currentStamina;
}

- (int)getMaxStamina
{
    return maxStamina;
}

- (void)addItem:(Item)item
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
    [items addObject:wrappedItem];
}

- (Item)getItem:(NSUInteger)index
{
    // Unwrap the Item struct from the stored NSValue
    Item item;
    NSValue *wrappedItem = [items objectAtIndex:index];
    [wrappedItem getValue:&item];
    return item;
}


- (NSUInteger)getIndexOfItem:(Item)item
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
    return [items indexOfObject:wrappedItem];
}

- (void)replaceItem:(Item)itemToReplace replaceWith:(Item)newItem
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&newItem objCType:@encode(Item)];
    
    // Get the index of the item to replace
    NSUInteger indexToReplace = [self getIndexOfItem:itemToReplace];
    
    // Replace the item with the new item
    [items replaceObjectAtIndex:indexToReplace withObject:wrappedItem];
}

- (void)removeItem:(Item)item
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
    [items removeObject:wrappedItem];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [items removeObjectAtIndex:index];
}

- (bool)hasItem:(Item)item
{
    // NSMutableArray can only hold NSObjects, so we need to
    // wrap the Item struct value
    NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
    return [items containsObject:wrappedItem];
}

- (NSUInteger)getNumItems
{
    return items.count;
}

- (void)equipItem:(NSUInteger)index withItemSlot:(int)itemSlot
{
    if (itemSlot >= 0 && itemSlot < MAX_EQUIPPED_ITEMS)
    {
        // Unequip any already-equipped item
        [self unequipItem:itemSlot];
        
        // Move the item from the inventory to the equipped item slot
        equippedItems[itemSlot] = items[index];
        [self removeItemAtIndex:index];
    }
}

- (void)unequipItem:(int)itemSlot
{
    if (itemSlot >= 0 && itemSlot < MAX_EQUIPPED_ITEMS)
    {
        // If nothing equipped, then there is nothing to unequip
        Item equipped = [self getEquippedItem:itemSlot];
        if (equipped.name == ITEMS[ITEM_NONE].name) return;
        
        // Move the item from the equipped item slot to the inventory
        [items addObject:equippedItems[itemSlot]];
        Item item = ITEMS[ITEM_NONE];
        NSValue *wrappedItem = [NSValue valueWithBytes:&item objCType:@encode(Item)];
        equippedItems[itemSlot] = wrappedItem;
    }
}

- (Item)getEquippedItem:(int)itemSlot
{
    // Unwrap the Item struct from the stored NSValue
    Item item;
    NSValue *wrappedItem = [equippedItems objectAtIndex:itemSlot];
    [wrappedItem getValue:&item];
    return item;
}

- (void)setCombatState:(CombatState)newState
{
    CombatState prevState = [self getCombatState];
    [super setCombatState:newState];
    
    switch (newState)
    {
        case COMBAT_NEUTRAL:
            self.spriteIndex = 0;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = playerNeutralPos;
            break;
        case COMBAT_ATTACKING:
        case COMBAT_ATTACKING2:
            self.spriteIndex = 1;
            self.velocity = GLKVector3Make(0, -2, 3);
            break;
        case COMBAT_BLOCKING:
            self.spriteIndex = 2;
            self.velocity = GLKVector3Make(0, 0, 0);
            self.position = playerNeutralPos;
            break;
        case COMBAT_DODGING_LEFT:
            self.spriteIndex = 3;
            self.velocity = GLKVector3Make(4, 0, 0);
            [[AudioPlayer getInstance] play:KEY_SOUND_DODGE];
            break;
        case COMBAT_DODGING_RIGHT:
            self.spriteIndex = 4;
            self.velocity = GLKVector3Make(-4, 0, 0);
            [[AudioPlayer getInstance] play:KEY_SOUND_DODGE];
            break;
        case COMBAT_HURT:
            self.spriteIndex = 5;
            self.velocity = GLKVector3Make(0, 1, 0);
            self.position = playerNeutralPos;
            [[AudioPlayer getInstance] play:KEY_SOUND_PLAYER_HURT];
            break;
        case COMBAT_DEAD:
            self.spriteIndex = 6;
            self.position = playerNeutralPos;
            if (prevState != newState) [[AudioPlayer getInstance] play:KEY_SOUND_DEAD];
            break;
        default:
            break;
    }
}

@end
