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
        [super setupLayout:0.35f withBody:0.25f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [super addTitle:@"INVENTORY"];
    [super addBackButton];
    [self setupDescriptionLabel];
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
 * @brief Create the label element for displaying the selected item's description.
 * @author Henry Loo
 */
- (void)setupDescriptionLabel
{
    _descriptionLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _descriptionLabel.textColor = [UIColor whiteColor];
    _descriptionLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.8];
    float halfWidth = self.frame.size.width / 2;
    [_descriptionLabel setContentEdgeInsets:UIEdgeInsetsMake(12, halfWidth, 12, halfWidth)];
    _descriptionLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    _descriptionLabel.layer.borderWidth = 1;
    [self.headerArea addSubview:_descriptionLabel];
    
    // Enable autolayout
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
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
    _item1Button.layer.borderColor = UIColor.blackColor.CGColor;
    _item1Button.layer.borderWidth = 2;
    [self.bodyArea addSubview:_item1Button];
    
    _item2Button = [[UIButton alloc] init];
    _item2Button.layer.borderColor = UIColor.blackColor.CGColor;
    _item2Button.layer.borderWidth = 2;
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
    _items.layer.borderColor = UIColor.blackColor.CGColor;
    _items.layer.borderWidth = 2;
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
    // Description label constraints
    [_descriptionLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [_descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:25].active = YES;
    
    // Item label constraints
    float itemLabelOffset = self.bodyArea.frame.size.width / 4;
    [_item1Label.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor constant:-itemLabelOffset].active = YES;
    [_item1Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    
    [_item2Label.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor constant:itemLabelOffset].active = YES;
    [_item2Label.topAnchor constraintEqualToAnchor:self.bodyArea.topAnchor].active = YES;
    
    // Item 1 and item 2 constraints
    float itemViewSize = self.bodyArea.frame.size.height * 2 / 3;
    [_item1Button.centerXAnchor constraintEqualToAnchor:_item1Label.centerXAnchor].active = YES;
    [_item1Button.topAnchor constraintEqualToAnchor:_item1Label.bottomAnchor constant:8].active = YES;
    [_item1Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item1Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    [_item2Button.centerXAnchor constraintEqualToAnchor:_item2Label.centerXAnchor].active = YES;
    [_item2Button.topAnchor constraintEqualToAnchor:_item2Label.bottomAnchor constant:8].active = YES;
    [_item2Button.widthAnchor constraintEqualToConstant:itemViewSize].active = YES;
    [_item2Button.heightAnchor constraintEqualToConstant:itemViewSize].active = YES;
    
    // Items constraints
    [_items.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_items.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_items.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:8].active = YES;
    [_items.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
}

@end
