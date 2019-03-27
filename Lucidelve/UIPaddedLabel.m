//
//  UIPaddedLabel.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-03-26.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "UIPaddedLabel.h"

@implementation UIPaddedLabel

- (void)drawTextInRect:(CGRect)uiLabelRect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(uiLabelRect, UIEdgeInsetsMake(_topInset, _leftInset, _bottomInset, _rightInset))];
}

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize];
    intrinsicSuperViewContentSize.height += (_topInset + _bottomInset);
    intrinsicSuperViewContentSize.width += (_leftInset + _rightInset);
    return intrinsicSuperViewContentSize;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _topInset = edgeInsets.top;
    _leftInset = edgeInsets.left;
    _rightInset = edgeInsets.right;
    _bottomInset = edgeInsets.bottom;
    [self invalidateIntrinsicContentSize];
}

@end
