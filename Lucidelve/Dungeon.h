//
//  Dungeon.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class DungeonNode;

/*!
 * @brief Defines a dungeon, which contains a collection of nodes.
 */
@interface Dungeon : NSObject

// The dungeon's name
@property NSString *name;

// The dungeon's intro description
@property NSString *intro;

// The dungeon's theme, which determines the visuals of the environment
//@property theme

// The pool of possible nodes in this dungeon
@property NSMutableArray *combatNodes;
@property NSMutableArray *eventNodes;

// The number of nodes in this dungeon
@property int minNumNodes;
@property int maxNumNodes;

// Visual properties
@property GLKVector4 fogColour;
@property NSString *floorTexture;
@property NSString *wallTexture;

// The dungeon's music
@property NSString *music;

/*!
 * @brief Initialize a dungeon with a name.
 * @author Henry Loo
 *
 * @param name The dungeon's name.
 * @param fog The dungeon's fog colour.
 * @param floor The dungeon's floor texture.
 * @param wall The dungeon's wall texture.
 * @param music The dungeon's music.
 * @param combatNodes The dungeon's combat nodes.
 * @param eventNodes The dungeon's event nodes.
 * @param minNodes The minimum number of nodes in the dungeon.
 * @param maxNodes The maximum number of nodes in the dungeon.
 */
- (id)init:(NSString *)name withFog:(GLKVector4)fog withFloor:(NSString *)floor withWall:(NSString *)wall
    withMusic:(NSString *)music withCombatNodes:(NSMutableArray *)combatNodes
    withEventNodes:(NSMutableArray *)eventNodes withMinNodes:(int)minNodes withMaxNodes:(int)maxNodes;

/*!
 * @brief Return a random node for this dungeon.
 * @author Henry Loo
 */
- (DungeonNode*)getDungeonNode;

@end
