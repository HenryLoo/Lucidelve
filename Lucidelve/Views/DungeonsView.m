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
    
}
    
@end

@implementation DungeonsView
    
- (id)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) {
            // Set up elements in the view
            [super setupLayout:0.3f withBody:0.25f];
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
    [self setupStartButton];
}

- (void)setupFooterElements
{
    [self setupDungeonsTable];
}
    
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
 * @brief Create the button element for starting a dungeon run.
 * @author Henry Loo
 */
- (void)setupStartButton
{
    _startButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.layer.borderColor = UIColor.blackColor.CGColor;
    [_startButton setTitle:@"ENTER THE DUNGEON" forState:UIControlStateNormal];
    [_startButton setTitle:@"" forState:UIControlStateDisabled];
    [_startButton setEnabled:false];
    [self.bodyArea addSubview:_startButton];
    
    // Enable autolayout
    _startButton.translatesAutoresizingMaskIntoConstraints = false;
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
    [_descriptionLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
    [_descriptionLabel.bottomAnchor constraintEqualToAnchor:self.headerArea.bottomAnchor].active = YES;
    
    // Start button constraints
    [_startButton.centerXAnchor constraintEqualToAnchor:self.bodyArea.centerXAnchor].active = YES;
    [_startButton.bottomAnchor constraintEqualToAnchor:self.bodyArea.bottomAnchor].active = YES;
    
    // Dungeons constraints
    [_dungeons.leftAnchor constraintEqualToAnchor:self.footerArea.leftAnchor constant:25].active = YES;
    [_dungeons.rightAnchor constraintEqualToAnchor:self.footerArea.rightAnchor constant:-25].active = YES;
    [_dungeons.topAnchor constraintEqualToAnchor:self.footerArea.topAnchor constant:18].active = YES;
    [_dungeons.bottomAnchor constraintEqualToAnchor:self.footerArea.bottomAnchor constant:-18].active = YES;
}

@end
