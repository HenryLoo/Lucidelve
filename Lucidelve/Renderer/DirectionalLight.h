//
//  DirectionalLight.h
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Light.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A directional light which can be added to the GL Program for rendering
 */
@interface DirectionalLight : Light {
    // The direction of the light
    GLKVector3 _direction;
}

/*!
 * @brief Initializes the instance
 * @author Jason Chung
 *
 * @return An id to the created instance
 */
- (id)init;
/*!
 * @brief Sets uniform values for the program to render
 * @author Jason Chung
 *
 * @param program The corresponding GL program
 */
- (void)draw:(GLProgram *)program;

/*!
 * Returns the direction of the DirectionalLight.
 * @author Jason Chung
 *
 * @return The direction of the DirectionalLight.
 */
- (GLKVector3)direction;
/*!
 * Sets the direction of the DirectionalLight.
 * @author Jason Chung
 *
 * @param direction The direction of the DirectionalLight.
 */
- (void)setDirection:(GLKVector3)direction;

@end

NS_ASSUME_NONNULL_END
