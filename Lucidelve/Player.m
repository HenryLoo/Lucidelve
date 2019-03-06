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

@interface Player ()
{
    // The player's current gold value
    int gold;
    
    // Holds all the player's items
    NSMutableArray *items;
}

@end

@implementation Player

- (id)init
{
    if (self = [super initWithData:DEFAULT_PLAYER_LIFE]) {
        gold = 0;
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addGold:(int)amount
{
    gold += amount;
    
    // Can't go into negative gold
    gold = MAX(0, gold);
    
    [[Utility getInstance] saveInt:gold key:@"gold"];
}

- (int)getGold
{
    return gold;
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

@end
