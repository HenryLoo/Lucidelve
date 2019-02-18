//
//  CombatView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-16.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for Combat.
 */
@interface CombatView : BaseView

// Shows the number of remaining nodes in the dungeon run.
@property (nonatomic, strong) UILabel *remainingNodesLabel;

// TODO: some label to display player and enemy visuals,
// since sprite rendering isn't very usable yet.
@property (nonatomic, strong) UILabel *enemyNameLabel;
@property (nonatomic, strong) UILabel *enemyStateLabel;
@property (nonatomic, strong) UILabel *playerNameLabel;
@property (nonatomic, strong) UILabel *playerStateLabel;

@end
