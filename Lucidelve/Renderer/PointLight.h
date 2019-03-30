//
//  PointLight.h
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Light.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A point light which can be added to the GL Program for rendering
 */
@interface PointLight : Light {
    // The position of the light
    GLKVector3 _position;
    // Makes sure the resulting denominator never gets smaller than 1
    GLfloat _constant;
    // Linear is multiplied with the distance that reduces the intensity in a linear fashion
    GLfloat _linear;
    // Multiplied with the quadrant of the distance and sets a quadratic decease of intensity for the light source
    GLfloat _quadratic;
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
 * Returns the position of the PointLight.
 * @author Jason Chung
 *
 * @return The position of the PointLight.
 */
- (GLKVector3)position;
/*!
 * Returns the constant of the PointLight.
 * @author Jason Chung
 *
 * @return The constant of the PointLight.
 */
- (GLfloat)constant;
/*!
 * Returns the linear of the PointLight.
 * @author Jason Chung
 *
 * @return The linear of the PointLight.
 */
- (GLfloat)linear;
/*!
 * Returns the quadratic of the PointLight.
 * @author Jason Chung
 *
 * @return The quadratic of the PointLight.
 */
- (GLfloat)quadratic;

/*!
 * Sets the position of the PointLight.
 * @author Jason Chung
 *
 * @param position The position of the PointLight.
 */
- (void)setPosition:(GLKVector3)position;
/*!
 * Sets the position of the PointLight.
 * @author Jason Chung
 *
 * @param constant The constant of the PointLight.
 */
- (void)setConstant:(GLfloat)constant;
/*!
 * Sets the position of the PointLight.
 * @author Jason Chung
 *
 * @param linear The linear of the PointLight.
 */
- (void)setLinear:(GLfloat)linear;
/*!
 * Sets the position of the PointLight.
 * @author Jason Chung
 *
 * @param quadratic The quadratic of the PointLight.
 */
- (void)setQuadratic:(GLfloat)quadratic;

@end

NS_ASSUME_NONNULL_END
