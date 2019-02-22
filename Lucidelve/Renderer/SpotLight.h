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
@interface SpotLight : Light

// The position
@property GLKVector3 _position;
// The direction
@property GLKVector3 _direction;
// Makes sure the resulting denominator never gets smaller than 1
@property GLfloat _constant;
// Linear is multiplied with the distance that reduces the intensity in a linear fashion
@property GLfloat _linear;
// Multiplied with the quadrant of the distance and sets a quadratic decease of intensity for the light source
@property GLfloat _quadratic;
// The radius of the spotlight
@property GLfloat _cutOff;
@property GLfloat _outerCutOff;

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
