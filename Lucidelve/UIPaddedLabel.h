//
//  UIPaddedLabel.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-03-26.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPaddedLabel : UILabel

@property float topInset, leftInset, bottomInset, rightInset;

- (void)drawTextInRect:(CGRect)uiLabelRect;
- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets;

@end
