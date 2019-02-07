//
//  HubView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

/*!
 * @brief The view for The Hub
 */
@interface HubView : GLKView

// Displays the player's current gold
@property (nonatomic, strong) UILabel *goldLabel;

// Button for generating gold
@property (nonatomic, strong) UIButton *goldButton;

@end
