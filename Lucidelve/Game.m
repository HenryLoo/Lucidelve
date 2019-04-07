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
#import "Storage.h"
#import "Constants.h"

@interface Game ()
{
    // Hold the player
    Player *player;
    
    // Hold the different dungeon types
    NSMutableArray *dungeons;
    
    // Hold the different enemy types
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
        
        _highscores = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self getNumDungeons]; ++i)
        {
            [self.highscores addObject:[NSNumber numberWithFloat:0]];
        }
        
        // Reload saved values
        [[Storage getInstance] loadPlayer:player];
        [[Storage getInstance] loadGameData:self];
        [player addMaxLife:self.numLifeUpgrades];
        
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
	[[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
    // Pass the Game's data before switching scenes
    newVC.game = self;
    newVC.renderer = currentVC.renderer;
	[[UIApplication sharedApplication] keyWindow].rootViewController = newVC;
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

- (int)getSwordDamage
{
    return (_numBlacksmithUpgrades * 2) + pow(1.5, _numBlacksmithUpgrades);
}

/*!
 * @brief Load all assets from the main assets list JSON.
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
    dungeons = [[NSMutableArray alloc] initWithCapacity:dungeonsArray.count];
    for (id dungeonType in dungeonsArray)
    {
        [self initDungeon:dungeonType];
    }
}

/*!
 * @brief Load an enemy from its JSON file given its type.
 * @author Henry Loo
 */
- (void)initEnemy:(NSString*)enemyType
{
    NSString *path = [NSString stringWithFormat:@"%@.json", enemyType];
    NSString *enemyPath = [[Utility getInstance] getFilepath:path fileType:@"enemies"];
    NSData *enemyData = [[Utility getInstance] loadResource:enemyPath];
    NSDictionary *enemyJSON = [[Utility getInstance] decodeJSON:enemyData];
    NSString *name = [enemyJSON valueForKey:@"name"];
    NSString *texture = [enemyJSON valueForKey:@"texture"];
    int life = [[enemyJSON valueForKey:@"life"] intValue];
    float minAttackDelay = [[enemyJSON valueForKey:@"minAttackDelay"] floatValue];
    float maxAttackDelay = [[enemyJSON valueForKey:@"maxAttackDelay"] floatValue];
    float blockChance = [[enemyJSON valueForKey:@"blockChance"] floatValue];
    
    // Add the enemy's attack patterns
    NSMutableArray *attackPatterns = [[NSMutableArray alloc] init];
    NSArray *attackData = [enemyJSON objectForKey:@"attackPatterns"];
    for (id object in attackData)
    {
        int damage = [[object valueForKey:@"damage"] intValue];
        bool isDodgeable = [[object valueForKey:@"isDodgeable"] boolValue];
        bool isBlockable = [[object valueForKey:@"isBlockable"] boolValue];
        bool isInterruptable = [[object valueForKey:@"isInterruptable"] boolValue];
        float alertDelay = [[object valueForKey:@"alertDelay"] floatValue];
        float attackDelay = [[object valueForKey:@"attackDelay"] floatValue];
        EnemyAttack attack = (EnemyAttack){.damage = damage, .isDodgeable = isDodgeable, .isBlockable = isBlockable,
            .isInterruptable = isInterruptable, .alertDelay = alertDelay, .attackDelay = attackDelay};
        NSValue *wrappedAttack = [NSValue valueWithBytes:&attack objCType:@encode(EnemyAttack)];
        [attackPatterns addObject:wrappedAttack];
    }

    // Instantiate the enemy and add it to the list of enemies
    Enemy *enemy = [[Enemy alloc] initWithData:name withTexture:texture withLife:life withMinDelay:minAttackDelay
                                  withMaxDelay:maxAttackDelay withBlockChance:blockChance withAttackPatterns:attackPatterns];
    [enemies setValue:enemy forKey:enemyType];
}

/*!
 * @brief Load a dungeon from its JSON file given its type.
 * @author Henry Loo
 */
- (void)initDungeon:(NSString*)dungeonType
{
    // Get the dungeon's JSON file
    NSString *path = [NSString stringWithFormat:@"%@.json", dungeonType];
    NSString *dungeonPath = [[Utility getInstance] getFilepath:path fileType:@"dungeons"];
    NSData *dungeonData = [[Utility getInstance] loadResource:dungeonPath];
    NSDictionary *dungeonJSON = [[Utility getInstance] decodeJSON:dungeonData];
    NSString *name = [dungeonJSON valueForKey:@"name"];
    id fog = [dungeonJSON objectForKey:@"fogColour"];
    GLKVector4 fogColour = GLKVector4Make([[fog valueForKey:@"r"] floatValue],
                                          [[fog valueForKey:@"g"] floatValue],
                                          [[fog valueForKey:@"b"] floatValue],
                                          [[fog valueForKey:@"a"] floatValue]);
    NSString *floorTexture = [dungeonJSON valueForKey:@"floorTexture"];
    NSString *wallTexture = [dungeonJSON valueForKey:@"wallTexture"];
    int minNodes = [[dungeonJSON valueForKey:@"minNodes"] intValue];
    int maxNodes = [[dungeonJSON valueForKey:@"maxNodes"] intValue];
    NSString *music = [dungeonJSON valueForKey:@"music"];
    
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
    Dungeon *dungeon = [[Dungeon alloc] init:name withFog:fogColour withFloor:floorTexture withWall:wallTexture
                                   withMusic:music withCombatNodes:combatNodes withEventNodes:eventNodes
                                    withMinNodes:minNodes withMaxNodes:maxNodes];
    
    [dungeons addObject:dungeon];
}

- (int)getScore {
    int score = 0;
    
    if (_isShopUnlocked) score++;
    if (_isSwordBought) score++;
    if (_isInventoryUnlocked) score++;
    if (_isDungeonsUnlocked) score++;
    if (_isGooseUnlocked) score++;
    score += _numGooseUpgrades;
    if (_isBlacksmithUnlocked) score++;
    score += _numBlacksmithUpgrades;
    score += _numLifeUpgrades;
    score += _numDungeonsCleared;
    
    return score;
}

@end
