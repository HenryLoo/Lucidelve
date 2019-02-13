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

// Displays the label for item 1
@property (nonatomic, strong) UILabel *item1Label;

// Displays the label for item 2
@property (nonatomic, strong) UILabel *item2Label;

@end
