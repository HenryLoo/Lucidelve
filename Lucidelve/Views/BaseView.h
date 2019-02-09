//
//  BaseView.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

/*!
 * @brief A base class implemented by all views
 * to conform to the constraints structure.
 */
@interface BaseView : GLKView

// The topmost area of the view
@property (nonatomic, strong) UIView *headerArea;

// The middle area of the view
@property (nonatomic, strong) UIView *bodyArea;

// The bottom area of the view
@property (nonatomic, strong) UIView *footerArea;

/*!
 * Create all the elements in the header.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupHeaderElements;

/*!
 * Create all the elements in the body.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupBodyElements;

/*!
 * Create all the elements in the footer.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupFooterElements;

/*!
 * Set the constraints for the header, body, and footers
 * areas of the view.
 * @author Henry Loo
 *
 * @param headerMultiplier The percentage of vertical space
 * that the header occupies.
 * @param bodyMultiplier The percentage of vertical space
 * that the body occupies.
 * @param footerMultiplier The percentage of vertical space
 * that the footer occupies.
 */
- (void)setupLayout:(float)headerMultiplier withBody:(float)bodyMultiplier withFooter:(float)footerMultiplier;

@end
