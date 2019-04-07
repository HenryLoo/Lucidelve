//
//  DungeonsView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for Dungeons.
 */
@interface DungeonsView : BaseView
    
// Show all dungeons
@property (nonatomic, strong) UITableView *dungeons;

// The label to show descriptions
@property (nonatomic, strong) UIPaddedLabel *descriptionLabel;

// Button to start a dungeon run
@property (nonatomic, strong) UIButton *startButton;
    
@end
