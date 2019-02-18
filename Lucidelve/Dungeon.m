//
//  Dungeon.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Dungeon.h"
#import "DungeonNode.h"

@implementation Dungeon

- (id)init:(NSString*)name withCombatNodes:(NSMutableArray*)combatNodes
withEventNodes:(NSMutableArray*)eventNodes withMinNodes:(int)minNodes
withMaxNodes:(int)maxNodes;
{
    if (self = [super init]) {
        _name = name;
        _combatNodes = combatNodes;
        _eventNodes = eventNodes;
        _minNumNodes = minNodes;
        _maxNumNodes = maxNodes;
    }
    
    return self;
}

- (DungeonNode*)getDungeonNode
{
    // Get a random index between 0 to size of nodes array
    int random = arc4random_uniform(_combatNodes.count);
    return [_combatNodes objectAtIndex:random];
}

@end
