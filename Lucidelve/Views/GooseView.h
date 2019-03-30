//
//  GooseView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-22.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for the Golden Goose.
 */
@interface GooseView : BaseView

// Show the player's current amount of gold
@property (nonatomic, strong) UIPaddedLabel *goldLabel;

// Show the current rate of gold generation
@property (nonatomic, strong) UIPaddedLabel *goldRateLabel;

// Show the upgrade button
@property (nonatomic, strong) UIButton *upgradeButton;

@end
