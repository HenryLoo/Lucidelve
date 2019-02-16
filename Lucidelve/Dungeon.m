//
//  Dungeon.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Dungeon.h"

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

@end
