//
//  HighscoreView.m
//  Lucidelve
//
//  Created by Jason Chung on 2019-04-03.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HighscoreView.h"

@interface HighscoreView ()
{
    UIPaddedLabel *descriptionLabel;
}

@end

@implementation HighscoreView

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
    [super addTitle:@"HIGHSCORE"];
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
    descriptionLabel.text = @"By unlocked discoverables.";
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
    _scores = [[UITableView alloc] initWithFrame:self.footerArea.frame style:UITableViewStylePlain];
    _scores.layer.borderColor = UIColor.blackColor.CGColor;
    _scores.layer.borderWidth = 2;
    [self.footerArea addSubview:_scores];
    
    // Enable autolayout
    _scores.translatesAutoresizingMaskIntoConstraints = false;
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
    [_scores.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_scores.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_scores.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:25].active = YES;
    [_scores.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-25].active = YES;
}

@end
