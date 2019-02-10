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

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set up elements in the view
        [super setupLayout:0.25f withBody:0.375f withFooter:0.375f];
        [self setupLayout];
    }
    return self;
}

- (void)setupHeaderElements
{
    [super addBackButton];
    [super addTitle:@"INVENTORY"];
}

- (void)setupBodyElements
{
    
}

- (void)setupFooterElements
{
    
}

/*!
 * Set up the layout constraints of the view
 * @author Henry Loo
 */
- (void)setupLayout
{
    
}

@end
