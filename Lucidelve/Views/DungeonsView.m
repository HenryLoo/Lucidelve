//
//  DungeonsView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "DungeonsView.h"
#import "Constants.h"

@interface DungeonsView ()
{
    UILabel *descriptionLabel;
}
    
@end

@implementation DungeonsView
    
- (id)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) {
            // Set up elements in the view
            [super setupLayout:0.2f withBody:0.4f];
            [self setupLayout];
        }
        return self;
    }
    
- (void)setupHeaderElements
{
    [super addBackButton];
    [super addTitle:@"DUNGEONS"];
    [self setupDescriptionLabel];
}
    
- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    [self setupItemsTable];
}
    
- (void)setupDescriptionLabel
{
    descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.text = @"Select your adventure...";
    [descriptionLabel sizeToFit];
    [self.headerArea addSubview:descriptionLabel];
    
    // Enable autolayout
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
}
    
/*!
 * Create the element for displaying the player's items.
 * @author Henry Loo
 */
- (void)setupItemsTable
{
    _dungeons = [[UITableView alloc] initWithFrame:self.footerArea.frame style:UITableViewStylePlain];
    [self.footerArea addSubview:_dungeons];
    
    // Enable autolayout
    _dungeons.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    // Description label constraints
    [descriptionLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [descriptionLabel.bottomAnchor constraintEqualToAnchor:self.headerArea.bottomAnchor].active = YES;
    
    // Dungeons constraints
    [_dungeons.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_dungeons.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_dungeons.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    [_dungeons.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
}

@end
