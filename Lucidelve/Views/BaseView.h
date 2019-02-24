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

// The Back button
@property (nonatomic, strong) UIButton *backButton;

// The view's title
@property (nonatomic, strong) UILabel *titleLabel;

/*!
 * @brief Create all the elements in the header.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupHeaderElements;

/*!
 * @brief Create all the elements in the body.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupBodyElements;

/*!
 * @brief Create all the elements in the footer.
 * This should be implemented by the subclass.
 * @author Henry Loo
 */
- (void)setupFooterElements;

/*!
 * @brief Add a Back button to the header area.
 * The subclass should call this if it needs a Back button.
 * @author Henry Loo
 */
- (void)addBackButton;

/*!
 * @brief Add a given title to the header area.
 * The subclass should call this if it needs title.
 * @author Henry Loo
 */
- (void)addTitle:(NSString*)title;

/*!
 * @brief Set the constraints for the header, body, and footers
 * areas of the view. The header and body multipliers are
 * specified, and the footer takes the remaining amount of
 * vertical space.
 * @author Henry Loo
 *
 * @param headerMultiplier The percentage of vertical space
 * that the header occupies.
 * @param bodyMultiplier The percentage of vertical space
 * that the body occupies.
 */
- (void)setupLayout:(float)headerMultiplier withBody:(float)bodyMultiplier;

@end
