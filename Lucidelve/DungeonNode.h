//
//  DungeonNode.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Defines the different kinds of dungeon nodes.
 */
@interface DungeonNode : NSObject

/*!
 * Initialize a dungeon node with a type, gold reward, and enemy.
 * @author Henry Loo
 *
 * @param goldReward The amount of gold to earn when clearing this node.
 * @param enemy The enemy to encounter in this node.
 * @return A pointer to this instance.
 */
- (id)initWithData:(int)goldReward withEnemy:(NSString*)enemy;

/*!
 * Get the amount of gold rewarded for this node.
 * @author Henry Loo
 *
 * @return The node's gold reward.
 */
- (int)getGoldReward;

/*!
 * Get the type of enemy encountered in this node.
 * @author Henry Loo
 *
 * @return The node's enemy type.
 */
- (NSString*)getEnemyType;

@end
