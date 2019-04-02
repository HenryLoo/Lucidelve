//
//  BaseView.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [self setupHeaderArea];
        [self setupBodyArea];
        [self setupFooterArea];
    }
    return self;
}

/*!
 * @brief Create the subview for the header area of the view.
 * @author Henry Loo
 */
- (void)setupHeaderArea
{
    _headerArea = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_headerArea];
    
    // Enable autolayout
    _headerArea.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupHeaderElements];
}

/*!
 * @brief Create the subview for the body area of the view.
 * @author Henry Loo
 */
- (void)setupBodyArea
{
    _bodyArea = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_bodyArea];
    
    // Enable autolayout
    _bodyArea.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupBodyElements];
}

/*!
 * @brief Create the subview for the footer area of the view.
 * @author Henry Loo
 */
- (void)setupFooterArea
{
    _footerArea = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_footerArea];
    
    // Enable autolayout
    _footerArea.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupFooterElements];
}

- (void)setupHeaderElements
{
    // Subclass should implement this
}

- (void)setupBodyElements
{
    // Subclass should implement this
}

- (void)setupFooterElements
{
    // Subclass should implement this
}

- (void)addBackButton
{
    _backButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"< Back" forState:UIControlStateNormal];
    [self.headerArea addSubview:_backButton];
    
    // Enable autolayout
    _backButton.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)addTitle:(NSString*)title
{
    // Only allow adding a title if one doesn't already exist
    if (_titleLabel) return;
    
    _titleLabel = [[UIPaddedLabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = title;
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    float halfWidth = self.frame.size.width / 2;
    [_titleLabel setContentEdgeInsets:UIEdgeInsetsMake(25, halfWidth, 25, halfWidth)];
    [self.headerArea addSubview:_titleLabel];
    
    // Enable autolayout
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLayout:(float)headerMultiplier withBody:(float)bodyMultiplier
{
    if (headerMultiplier + bodyMultiplier > 1.0f)
    {
        NSLog(@"Sum of headerMultiplier and bodyMultiplier exceeds 1.0");
        return;
    }
    
    // Header area constraints
    _headerArea.frame = CGRectMake(0, 0, self.frame.size.width,
                                   self.frame.size.height * headerMultiplier);
    [_headerArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_headerArea.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_headerArea.widthAnchor constraintEqualToConstant:_headerArea.frame.size.width].active = YES;
    [_headerArea.heightAnchor constraintEqualToConstant:_headerArea.frame.size.height].active = YES;
    
    // Body area constraints
    _bodyArea.frame = CGRectMake(0, 0, self.frame.size.width,
                                   self.frame.size.height * bodyMultiplier);
    [_bodyArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_bodyArea.topAnchor constraintEqualToAnchor:_headerArea.bottomAnchor].active = YES;
    [_bodyArea.widthAnchor constraintEqualToConstant:_bodyArea.frame.size.width].active = YES;
    [_bodyArea.heightAnchor constraintEqualToConstant:_bodyArea.frame.size.height].active = YES;
    
    // Footer area constraints
    float footerMultiplier = 1 - headerMultiplier - bodyMultiplier;
    _footerArea.frame = CGRectMake(0, 0, self.frame.size.width,
                                 self.frame.size.height * footerMultiplier);
    [_footerArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_footerArea.topAnchor constraintEqualToAnchor:_bodyArea.bottomAnchor].active = YES;
    [_footerArea.widthAnchor constraintEqualToConstant:_footerArea.frame.size.width].active = YES;
    [_footerArea.heightAnchor constraintEqualToConstant:_footerArea.frame.size.height].active = YES;
    
    // Title constraints
    if (_titleLabel)
    {
        [_titleLabel.centerXAnchor constraintEqualToAnchor:_headerArea.centerXAnchor].active = YES;
        [_titleLabel.topAnchor constraintEqualToAnchor:_headerArea.topAnchor constant:50].active = YES;
    }
    
    // Back button constraints
    if (_backButton)
    {
        [_backButton.leftAnchor constraintEqualToAnchor:_headerArea.leftAnchor constant:8].active = YES;
        [_backButton.centerYAnchor constraintEqualToAnchor:_titleLabel.centerYAnchor].active = YES;
    }
}

@end
