//
//  CombatVC.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-16.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseVC.h"

@class Dungeon;

/*!
 * @brief The view controller for Combat during dungeon runs.
 */
@interface CombatVC : BaseVC

    // The current dungeon being played.
    @property Dungeon *currentDungeon;

@end
