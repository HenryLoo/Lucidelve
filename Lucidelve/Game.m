//
//  Game.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Game.h"
#import "BaseVC.h"
#import "Player.h"
#import "Dungeon.h"
#import "DungeonNode.h"
#include <stdlib.h>

@interface Game ()
{
    // Hold the player
    Player *player;
    
    // Hold the different dungeon types
    NSMutableArray *dungeons;
    
    // Hold the different enemy types
    Enemy *enemies[ENEMY_NUM_ENEMIES];
}

@end

@implementation Game

- (id)init
{
    if (self = [super init]) {
        player = [[Player alloc] init];
        _hubLastTime = _dungeonLastTime = [NSDate date];
        _goldCooldownTimer = 0;
        [self initDungeons];
    }
    return self;
}

- (Player*)getPlayer
{
    return player;
}

- (void)changeScene:(BaseVC*)currentVC newVC:(BaseVC*)newVC
{
    // Pass the Game's data before switching scenes
    newVC.game = self;
    [currentVC presentViewController:newVC animated:NO completion:nil];
}

- (Dungeon*)getDungeon:(NSUInteger)level
{
    return [dungeons objectAtIndex:level];
}

- (NSUInteger)getNumDungeons
{
    return dungeons.count;
}

- (void)initDungeons
{
    // TODO: replace hard-coded Forest dungeon definition with JSON file
    dungeons = [[NSMutableArray alloc] init];
    
    NSString *name = @"Forest";
    NSMutableArray *combatNodes = [[NSMutableArray alloc] init];
    NSMutableArray *eventNodes = [[NSMutableArray alloc] init];
    int minNodes = 2;
    int maxNodes = 4;
    
    // Create Tree enemy type
    NSMutableArray *attackPatterns;
    Enemy *tree = [[Enemy alloc] initWithData:@"Tree" withLife:5 withAttackDelay:3 withAttackPatterns:attackPatterns];
    enemies[ENEMY_TREE] = tree;
    
    // Add Tree enemy node
    DungeonNode *node = [[DungeonNode alloc] initWithData:10 withEnemy:ENEMY_TREE];
    [combatNodes addObject:node];
    
    Dungeon *forestDun = [[Dungeon alloc] init:name withCombatNodes:combatNodes
                                 withEventNodes:eventNodes withMinNodes:minNodes
                                   withMaxNodes:maxNodes];
    
    [dungeons addObject:forestDun];
}

- (Enemy*)getEnemy:(EnemyType)type
{
    return enemies[type];
}

@end
