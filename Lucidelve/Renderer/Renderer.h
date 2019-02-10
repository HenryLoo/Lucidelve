//
//  Renderer.h based on code by Borna Noureddin.
//  Lucidelve
//
//  Created by Choy on 2019-02-07.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * @brief A glES renderer based on code by Borna Noureddin.
 */
@interface Renderer : NSObject

/*!
 * Initializes the Renderer instance, keeps
 * a pointer to the GLKView and creates a GL context
 * for the GLKView. Initializes shaders and sets some GL states.
 * @author Jason Chung
 */
- (void)init:(GLKView *)_view;
/*!
 * Updates any GL states and renderable object states.
 * @author Jason Chung
 *
 * @param deltaTime The change in time
 */
- (void)update:(float)deltaTime;
/*!
 * Renders the scene and any renderable objects.
 * @author Jason Chung
 *
 * @param deltaTime The change in time
 */
- (void)render:(float)deltaTime drawRect:(CGRect)drawRect;



@end

NS_ASSUME_NONNULL_END
