//
//  DungeonNode.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-15.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "DungeonNode.h"

@interface DungeonNode ()
{
    // The amount of gold earned for clearing this node
    int goldReward;
    
    // The enemy type to fight in this node, if applicable
    NSString *enemyType;
}

@end

@implementation DungeonNode

- (id)initWithData:(int)goldReward withEnemy:(NSString*)enemyType
{
    if (self = [super init]) {
        self->goldReward = goldReward;
        self->enemyType = enemyType;
    }
    return self;
}

- (int)getGoldReward
{
    return goldReward;
}

- (NSString*)getEnemyType
{
    return enemyType;
}

@end
