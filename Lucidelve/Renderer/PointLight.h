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
@interface PointLight : Light

// The position of the light
@property GLKVector3 _position;
// Makes sure the resulting denominator never gets smaller than 1
@property GLfloat _constant;
// Linear is multiplied with the distance that reduces the intensity in a linear fashion
@property GLfloat _linear;
// Multiplied with the quadrant of the distance and sets a quadratic decease of intensity for the light source
@property GLfloat _quadratic;

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

@end

NS_ASSUME_NONNULL_END
