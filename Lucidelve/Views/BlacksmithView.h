//
//  BlacksmithView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-24.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for the Blacksmith.
 */
@interface BlacksmithView : BaseView

// Show the player's current amount of gold
@property (nonatomic, strong) UILabel *goldLabel;

// Show the name of the player's sword
@property (nonatomic, strong) UILabel *swordLabel;

// Show the upgrade button
@property (nonatomic, strong) UIButton *upgradeButton;

@end
