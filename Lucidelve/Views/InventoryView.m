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
        [super setupLayout:0.25f withBody:0.25f];
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
    [self setupItemLabels];
    [self setupItemButtons];
}

- (void)setupFooterElements
{
    [self setupItemsTable];
}

/*!
 * @brief Create the label element for item 1 and 2.
 * @author Henry Loo
 */
- (void)setupItemLabels
{
    _item1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _item2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _item1Label.textColor = _item2Label.textColor = [UIColor blackColor];
    _item1Label.textAlignment = _item2Label.textAlignment = NSTextAlignmentCenter;
    _item1Label.text = @"NONE";
    _item2Label.text = @"NONE";
    [_item1Label sizeToFit];
    [_item2Label sizeToFit];
    [self.bodyArea addSubview:_item1Label];
    [self.bodyArea addSubview:_item2Label];
    
    // Enable autolayout
    _item1Label.translatesAutoresizingMaskIntoConstraints = false;
    _item2Label.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Create the button elements for the player's item 1 and item 2.
 * @author Henry Loo
 */
- (void)setupItemButtons
{
    _item1Button = [[UIButton alloc] init];
    _item1Button.backgroundColor = UIColor.darkGrayColor;
    [self.bodyArea addSubview:_item1Button];
    
    _item2Button = [[UIButton alloc] init];
    _item2Button.backgroundColor = UIColor.darkGrayColor;
    [self.bodyArea addSubview:_item2Button];
    
    // Enable autolayout
    _item1Button.translatesAutoresizingMaskIntoConstraints = false;
    _item2Button.translatesAutoresizingMaskIntoConstraints = false;
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
    float itemLabelOffset = self.bodyArea.frame.size.width / 4;
    [_item1Label.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor constant:-itemLabelOffset].active = YES;
    [_item1Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    
    [_item2Label.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor constant:itemLabelOffset].active = YES;
    [_item2Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    
    // Item 1 and item 2 constraints
    float itemViewSize = self.bodyArea.frame.size.height * 2 / 3;
    [_item1Button.centerXAnchor constraintEqualToAnchor:_item1Label.centerXAnchor].active = YES;
    [_item1Button.topAnchor constraintEqualToAnchor:_item1Label.bottomAnchor].active = YES;
    [_item1Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item1Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    [_item2Button.centerXAnchor constraintEqualToAnchor:_item2Label.centerXAnchor].active = YES;
    [_item2Button.topAnchor constraintEqualToAnchor:_item2Label.bottomAnchor].active = YES;
    [_item2Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item2Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    // Items constraints
    [_items.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_items.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_items.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    [_items.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
}

@end
