//
//  InventoryView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "InventoryView.h"
#import "Constants.h"

@implementation InventoryView
    
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.15f withBody:0.25f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [super addBackButton];
    [super addTitle:@"INVENTORY"];
}

- (void)setupBodyElements
{
    [self setupItemsLabel];
}

- (void)setupFooterElements
{
    [self setupItemsTable];
}

/*!
 * @brief Create the label element for item 1 and 2.
 * @author Henry Loo
 */
- (void)setupItemsLabel
{
    _item1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _item2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _item1Label.textColor = _item2Label.textColor = [UIColor blackColor];
    _item1Label.textAlignment = _item2Label.textAlignment = NSTextAlignmentCenter;
    _item1Label.text = @"ITEM 1";
    _item2Label.text = @"ITEM 2";
    [_item1Label sizeToFit];
    [_item2Label sizeToFit];
    [self.headerArea addSubview:_item1Label];
    [self.headerArea addSubview:_item2Label];
    
    // Enable autolayout
    _item1Label.translatesAutoresizingMaskIntoConstraints = false;
    _item2Label.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the element for displaying the player's items.
 * @author Henry Loo
 */
- (void)setupItemsTable
{
    _items = [[UITableView alloc] initWithFrame:self.footerArea.frame style:UITableViewStylePlain];
    [self.footerArea addSubview:_items];
    
    // Enable autolayout
    _items.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Item label constraints
    [_item1Label.leftAnchor constraintEqualToAnchor:self.bodyArea.leftAnchor constant:25].active = YES;
    [_item1Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    [_item1Label.widthAnchor constraintEqualToConstant:_item1Label.frame.size.width].active = YES;
    [_item1Label.heightAnchor constraintEqualToConstant:_item1Label.frame.size.height].active = YES;
    
    [_item2Label.rightAnchor constraintEqualToAnchor:self.bodyArea.rightAnchor constant:-25].active = YES;
    [_item2Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    [_item2Label.widthAnchor constraintEqualToConstant:_item2Label.frame.size.width].active = YES;
    [_item2Label.heightAnchor constraintEqualToConstant:_item2Label.frame.size.height].active = YES;
    
    // Items constraints
    [_items.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_items.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_items.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    [_items.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
}

@end
