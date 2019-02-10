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
 * Create the subview for the header area of the view.
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
 * Create the subview for the body area of the view.
 * @author Henry Loo
 */
- (void)setupBodyArea
{
    _bodyArea = [[UIView alloc] initWithFrame:CGRectZero];
    _bodyArea.backgroundColor = UIColor.grayColor;
    [self addSubview:_bodyArea];
    
    // Enable autolayout
    _bodyArea.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupBodyElements];
}

/*!
 * Create the subview for the footer area of the view.
 * @author Henry Loo
 */
- (void)setupFooterArea
{
    _footerArea = [[UIView alloc] initWithFrame:CGRectZero];
    _footerArea.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:_footerArea];
    
    // Enable autolayout
    _footerArea.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupFooterElements];
}

- (void)addBackButton
{
    _backButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton sizeToFit];
    [self.headerArea addSubview:_backButton];
    
    // Enable autolayout
    _backButton.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)addTitle:(NSString*)title
{
    // Only allow adding a title if one doesn't already exist
    if (_titleLabel) return;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    [self.headerArea addSubview:_titleLabel];
    
    // Enable autolayout
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLayout:(float)headerMultiplier withBody:(float)bodyMultiplier withFooter:(float)footerMultiplier
{
    // Header area constraints
    [_headerArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_headerArea.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_headerArea.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_headerArea.heightAnchor constraintEqualToConstant:self.frame.size.height*headerMultiplier].active = YES;
    
    // Body area constraints
    [_bodyArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_bodyArea.topAnchor constraintEqualToAnchor:_headerArea.bottomAnchor].active = YES;
    [_bodyArea.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_bodyArea.heightAnchor constraintEqualToConstant:self.frame.size.height*bodyMultiplier].active = YES;
    
    // Footer area constraints
    [_footerArea.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_footerArea.topAnchor constraintEqualToAnchor:_bodyArea.bottomAnchor].active = YES;
    [_footerArea.widthAnchor constraintEqualToConstant:self.frame.size.width].active = YES;
    [_footerArea.heightAnchor constraintEqualToConstant:self.frame.size.height*footerMultiplier].active = YES;
    
    // Title constraints
    if (_titleLabel) {
        [_titleLabel.centerXAnchor constraintEqualToAnchor:self.headerArea.centerXAnchor].active = YES;
        [_titleLabel.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:50].active = YES;
        [_titleLabel.widthAnchor constraintEqualToConstant:_titleLabel.frame.size.width].active = YES;
        [_titleLabel.heightAnchor constraintEqualToConstant:_titleLabel.frame.size.height].active = YES;
    }
    
    // Back button constraints
    if (_backButton) {
        [_backButton.leftAnchor constraintEqualToAnchor:self.headerArea.leftAnchor constant:25].active = YES;
        [_backButton.topAnchor constraintEqualToAnchor:self.headerArea.topAnchor constant:25].active = YES;
        [_backButton.widthAnchor constraintEqualToConstant:_backButton.frame.size.width].active = YES;
        [_backButton.heightAnchor constraintEqualToConstant:_backButton.frame.size.height].active = YES;
    }
}

@end
