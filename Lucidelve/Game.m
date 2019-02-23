//
//  Game.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Game.h"
#import "ViewControllers/BaseVC.h"
#import "Player.h"
#import "Dungeon.h"
#import "DungeonNode.h"
#include <stdlib.h>
#import "Utility.h"
#import "Constants.h"

@interface Game ()
{
    // Hold the player
    Player *player;
    
    // Hold the different dungeon types
    NSMutableArray *dungeons;
    
    // Hold the different enemy types
    //Enemy *enemies[ENEMY_NUM_ENEMIES];
    NSMutableDictionary *enemies;
}

@end

@implementation Game

- (id)init
{
    if (self = [super init]) {
        player = [[Player alloc] init];
        _lastTime = [NSDate date];
        _goldCooldownTimer = 0;
        [self initAssets];
        
        // Reload saved gold value
        [player addGold:[[Utility getInstance] getInt:@"gold"]];
        
        // Initialize the Golden Goose's gold generation rate
        [self updateGooseRate];
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

- (Enemy*)getEnemy:(NSString*)type
{
    return [enemies objectForKey:type];
}

- (void)updateGooseRate
{
    const int maxAmount = 10;
    _gooseAmount = GOOSE_BASE_AMOUNT + _numGooseUpgrades % maxAmount;
    
    const float multiplier = 1.2;
    _gooseDelay = GOOSE_BASE_DELAY / pow(multiplier, _numGooseUpgrades);
    
    // Reset the cooldown to reflect the new delay
    _gooseCooldownTimer = _gooseDelay;
}

- (void)updateGooseGold
{
    _gooseCooldownTimer += _deltaTime;
    if (_gooseCooldownTimer <= 0)
    {
        [player addGold:_gooseAmount];
        _gooseCooldownTimer = _gooseDelay;
    }
}

/*!
 * Load all assets from the main assets list JSON.
 * This should be called once on initalization.
 * @author Henry Loo
 */
- (void)initAssets
{
    // Load main assets list
    NSString *assetsPath = [[NSBundle mainBundle] pathForResource:@"assets.json"
                            ofType:nil inDirectory:@"Assets/"];
    NSData *assetsData = [[Utility getInstance] loadResource:assetsPath];
    NSDictionary *assetsJSON = [[Utility getInstance] decodeJSON:assetsData];

    // Load all enemies
    NSArray *enemiesArray = [assetsJSON objectForKey:@"enemies"];
    enemies = [[NSMutableDictionary alloc] initWithCapacity:enemiesArray.count];
    for (id enemyType in enemiesArray)
    {
        [self initEnemy:enemyType];
    }
    
    // Load all dungeons
    NSArray *dungeonsArray = [assetsJSON objectForKey:@"dungeons"];
    dungeons = [[NSMutableArray alloc] init];
    for (id dungeonType in dungeonsArray)
    {
        [self initDungeon:dungeonType];
    }
}

/*!
 * Load an enemy from its JSON file given its type.
 * @author Henry Loo
 */
- (void)initEnemy:(NSString*)enemyType
{
    const char *path = [[NSString stringWithFormat:@"%@.json", enemyType] UTF8String];
    NSString *enemyPath = [[Utility getInstance] getFilepath:path fileType:"enemies"];
    NSData *enemyData = [[Utility getInstance] loadResource:enemyPath];
    NSDictionary *enemyJSON = [[Utility getInstance] decodeJSON:enemyData];
    NSString *name = [enemyJSON valueForKey:@"name"];
    int life = [[enemyJSON valueForKey:@"life"] intValue];
    int attackDelay = [[enemyJSON valueForKey:@"attackDelay"] intValue];
    
    // Add the enemy's attack patterns
    NSMutableArray *attackPatterns = [[NSMutableArray alloc] init];
    NSArray *attackData = [enemyJSON objectForKey:@"attackPatterns"];
    for (id object in attackData)
    {
        int damage = [[object valueForKey:@"damage"] intValue];
        bool isDodgeable = [[object valueForKey:@"isDodgeable"] boolValue];
        bool isBlockable = [[object valueForKey:@"isBlockable"] boolValue];
        EnemyAttack attack = (EnemyAttack){.damage = damage, .isDodgeable = isDodgeable, .isBlockable = isBlockable};
        NSValue *wrappedAttack = [NSValue valueWithBytes:&attack objCType:@encode(EnemyAttack)];
        [attackPatterns addObject:wrappedAttack];
    }

    // Instantiate the enemy and add it to the list of enemies
    Enemy *enemy = [[Enemy alloc] initWithData:name withLife:life withAttackDelay:attackDelay
                            withAttackPatterns:attackPatterns];
    [enemies setValue:enemy forKey:enemyType];
}

/*!
 * Load a dungeon from its JSON file given its type.
 * @author Henry Loo
 */
- (void)initDungeon:(NSString*)dungeonType
{
    // Get the dungeon's JSON file
    const char *path = [[NSString stringWithFormat:@"%@.json", dungeonType] UTF8String];
    NSString *dungeonPath = [[Utility getInstance] getFilepath:path fileType:"dungeons"];
    NSData *dungeonData = [[Utility getInstance] loadResource:dungeonPath];
    NSDictionary *dungeonJSON = [[Utility getInstance] decodeJSON:dungeonData];
    NSString *name = [dungeonJSON valueForKey:@"name"];
    int minNodes = [[dungeonJSON valueForKey:@"minNodes"] intValue];
    int maxNodes = [[dungeonJSON valueForKey:@"maxNodes"] intValue];
    
    // Add combat nodes
    NSMutableArray *combatNodes = [[NSMutableArray alloc] init];
    NSArray *combatNodeData = [dungeonJSON objectForKey:@"combatNodes"];
    for (id object in combatNodeData)
    {
        int goldReward = [[object valueForKey:@"goldReward"] intValue];
        NSString *enemyName = [object valueForKey:@"enemy"];
        DungeonNode *node = [[DungeonNode alloc] initWithData:goldReward withEnemy:enemyName];
        [combatNodes addObject:node];
    }
    
    // TODO: Add event nodes
    NSMutableArray *eventNodes = [[NSMutableArray alloc] init];
    NSArray *eventNodeData = [dungeonJSON objectForKey:@"eventNodes"];
    for (id object in eventNodeData)
    {
        int goldReward = [[object valueForKey:@"goldReward"] intValue];
        DungeonNode *node = [[DungeonNode alloc] initWithData:goldReward withEnemy:nil];
        [eventNodes addObject:node];
    }
    
    // Instantiate the dungeon and add it to the list of dungeons
    Dungeon *forestDun = [[Dungeon alloc] init:name withCombatNodes:combatNodes
                                 withEventNodes:eventNodes withMinNodes:minNodes
                                   withMaxNodes:maxNodes];
    
    [dungeons addObject:forestDun];
}

@end
