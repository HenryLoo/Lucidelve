//
//  Light.h
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "GLProgram.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A base light class which can be added to the GL Program for rendering
 */
@interface Light : NSObject {
    // The ambient light
    GLKVector3 _ambient;
    // The diffuse light
    GLKVector3 _diffuse;
    // The specular light
    GLKVector3 _specular;
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
 * Returns the ambient of the Light.
 * @author Jason Chung
 *
 * @return The ambient of the Light.
 */
- (GLKVector3)ambient;
/*!
 * Returns the diffuse of the Light.
 * @author Jason Chung
 *
 * @return The diffuse of the Light.
 */
- (GLKVector3)diffuse;
/*!
 * Returns the specular of the Light.
 * @author Jason Chung
 *
 * @return The specular of the Light.
 */
- (GLKVector3)specular;

/*!
 * Sets the ambient of the Light.
 * @author Jason Chung
 *
 * @param ambient The new ambient.
 */
- (void)setAmbient:(GLKVector3)ambient;
/*!
 * Sets the diffuse of the Light.
 * @author Jason Chung
 *
 * @param diffuse The new diffuse.
 */
- (void)setDiffuse:(GLKVector3)diffuse;
/*!
 * Sets the specular of the Light.
 * @author Jason Chung
 *
 * @param specular The new specular.
 */
- (void)setSpecular:(GLKVector3)specular;

@end

NS_ASSUME_NONNULL_END
