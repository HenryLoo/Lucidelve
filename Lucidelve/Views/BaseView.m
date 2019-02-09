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

/*!
 * Set up the layout constraints of the view
 * @author Henry Loo
 */
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
}

@end
