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
@interface Light : NSObject

// The ambient light
@property GLKVector3 _ambient;
// The diffuse light
@property GLKVector3 _diffuse;
// The specular light
@property GLKVector3 _specular;

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
