//
//  SpotLight.h
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Light.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A spotlight which can be added to the GL Program for rendering
 */
@interface SpotLight : Light {
    // The position
    GLKVector3 _position;
    // The direction
    GLKVector3 _direction;
    // Makes sure the resulting denominator never gets smaller than 1
    GLfloat _constant;
    // Linear is multiplied with the distance that reduces the intensity in a linear fashion
    GLfloat _linear;
    // Multiplied with the quadrant of the distance and sets a quadratic decease of intensity for the light source
    GLfloat _quadratic;
    // The radius of the spotlight
    GLfloat _cutOff;
    GLfloat _outerCutOff;
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
 * Returns the position of the SpotLight.
 * @author Jason Chung
 *
 * @return The position of the SpotLight.
 */
- (GLKVector3)position;
/*!
 * Returns the direction of the SpotLight.
 * @author Jason Chung
 *
 * @return The direction of the SpotLight.
 */
- (GLKVector3)direction;
/*!
 * Returns the constant of the SpotLight.
 * @author Jason Chung
 *
 * @return The constant of the SpotLight.
 */
- (GLfloat)constant;
/*!
 * Returns the linear of the SpotLight.
 * @author Jason Chung
 *
 * @return The linear of the SpotLight.
 */
- (GLfloat)linear;
/*!
 * Returns the quadratic of the SpotLight.
 * @author Jason Chung
 *
 * @return The quadratic of the SpotLight.
 */
- (GLfloat)quadratic;
/*!
 * Returns the cutOff of the SpotLight.
 * @author Jason Chung
 *
 * @return The cutOff of the SpotLight.
 */
- (GLfloat)cutOff;
/*!
 * Returns the outerCutOff of the SpotLight.
 * @author Jason Chung
 *
 * @return The outerCutOff of the SpotLight.
 */
- (GLfloat)outerCutOff;

/*!
 * Sets the position of the SpotLight.
 * @author Jason Chung
 *
 * @param position The position of the SpotLight.
 */
- (void)setPosition:(GLKVector3)position;
/*!
 * Sets the direction of the SpotLight.
 * @author Jason Chung
 *
 * @param direction The direction of the SpotLight.
 */
- (void)setDirection:(GLKVector3)direction;
/*!
 * Sets the position of the SpotLight.
 * @author Jason Chung
 *
 * @param constant The constant of the SpotLight.
 */
- (void)setConstant:(GLfloat)constant;
/*!
 * Sets the position of the SpotLight.
 * @author Jason Chung
 *
 * @param linear The linear of the SpotLight.
 */
- (void)setLinear:(GLfloat)linear;
/*!
 * Sets the position of the SpotLight.
 * @author Jason Chung
 *
 * @param quadratic The quadratic of the SpotLight.
 */
- (void)setQuadratic:(GLfloat)quadratic;
/*!
 * Sets the cut off of the SpotLight.
 * @author Jason Chung
 *
 * @param cutOff The cut off of the SpotLight.
 */
- (void)setCutOff:(GLfloat)cutOff;
/*!
 * Sets the outer cut off of the SpotLight.
 * @author Jason Chung
 *
 * @param outerCutOff The outer cut off of the SpotLight.
 */
- (void)setOuterCutOff:(GLfloat)outerCutOff;

@end

NS_ASSUME_NONNULL_END
