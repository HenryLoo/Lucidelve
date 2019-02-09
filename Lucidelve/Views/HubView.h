//
//  HubView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for The Hub.
 */
@interface HubView : BaseView

// Displays the player's current gold
@property (nonatomic, strong) UILabel *goldLabel;

// Button for generating gold
@property (nonatomic, strong) UIButton *goldButton;

// Button for moving to the Shop
@property (nonatomic, strong) UIButton *shopButton;

@end
