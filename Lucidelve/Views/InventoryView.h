//
//  InventoryView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

/*!
 * @brief The view for Inventory.
 */
@interface InventoryView : BaseView

// Show all player's items
@property (nonatomic, strong) UITableView *items;

// Show the selected item's description
@property (nonatomic, strong) UIPaddedLabel *descriptionLabel;

// Displays the labels for item 1 and item 2
@property (nonatomic, strong) UILabel *item1Label;
@property (nonatomic, strong) UILabel *item2Label;

// Show the player's item 1 and item 2
@property (nonatomic, strong) UIButton *item1Button;
@property (nonatomic, strong) UIButton *item2Button;

@end
