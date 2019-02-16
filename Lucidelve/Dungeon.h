//
//  Dungeon.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Defines a dungeon, which contains a collection of nodes.
 */
@interface Dungeon : NSObject

// The dungeon's name
@property NSString *name;

// The dungeon's theme, which determines the visuals of the environment
//@property theme

// The pool of possible nodes in this dungeon
@property NSMutableArray *combatNodes;
@property NSMutableArray *eventNodes;

// The number of nodes in this dungeon
@property int minNumNodes;
@property int maxNumNodes;

/*!
 * Initialize a dungeon with a name.
 * @author Henry Loo
 *
 * @param name The dungeon's name.
 */
- (id)init:(NSString*)name withCombatNodes:(NSMutableArray*)combatNodes
withEventNodes:(NSMutableArray*)eventNodes withMinNodes:(int)minNodes
withMaxNodes:(int)maxNodes;

@end
