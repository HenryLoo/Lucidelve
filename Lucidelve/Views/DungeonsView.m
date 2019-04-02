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
    UIPaddedLabel *descriptionLabel;
}
    
@end

@implementation DungeonsView
    
- (id)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) {
            // Set up elements in the view
            [super setupLayout:0.3f withBody:0.3f];
            [self setupLayout];
        }
        return self;
    }
    
- (void)setupHeaderElements
{
    [super addTitle:@"DUNGEONS"];
    [super addBackButton];
    [self setupDescriptionLabel];
}
    
- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    [self setupDungeonsTable];
}
    
- (void)setupDescriptionLabel
{
    descriptionLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.text = @"Select your adventure...";
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.8];
    float halfWidth = self.frame.size.width / 2;
    [descriptionLabel setContentEdgeInsets:UIEdgeInsetsMake(12, halfWidth, 12, halfWidth)];
    descriptionLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    descriptionLabel.layer.borderWidth = 1;
    [self.headerArea addSubview:descriptionLabel];
    
    // Enable autolayout
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
}
    
/*!
 * @brief Create the element for displaying the dungeons.
 * @author Henry Loo
 */
- (void)setupDungeonsTable
{
    _dungeons = [[UITableView alloc] initWithFrame:self.footerArea.frame style:UITableViewStylePlain];
    _dungeons.layer.borderColor = UIColor.blackColor.CGColor;
    _dungeons.layer.borderWidth = 2;
    [self.footerArea addSubview:_dungeons];
    
    // Enable autolayout
    _dungeons.translatesAutoresizingMaskIntoConstraints = false;
}

/*!
 * @brief Set up the layout constraints of the view
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
