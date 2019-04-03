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
@property (nonatomic, strong) UIPaddedLabel *remainingNodesLabel;

// Show the player's stats
@property (nonatomic, strong) UILabel *playerLifeLabel;
@property (nonatomic, strong) UILabel *playerStaminaLabel;

// Show the player's item 1 and item 2
@property (nonatomic, strong) UIButton *item1Button;
@property (nonatomic, strong) UIButton *item2Button;

// TODO: some label to display player and enemy visuals,
// since sprite rendering isn't very usable yet.
@property (nonatomic, strong) UIPaddedLabel *enemyNameLabel;
@property (nonatomic, strong) UIPaddedLabel *combatStatusLabel;

@end
