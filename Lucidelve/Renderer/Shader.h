//
//  Shader.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A Shader to be compiled and linked for the GL program
 */
@interface Shader : NSObject {
    // A reference to the shader on the GPU
    GLuint _shaderId;
}

/*!
 * @brief Initializes and compiles the shader.
 * @author Jason Chung
 *
 * @param filename The filename of the shader
 * @param shaderType The type of shader (GL_VERTEX_SHADER, GL_FRAGMENT_SHADER, ...)
 *
 * @return An id to the created instance
 */
- (id)initWithFilename:(NSString *)filename shaderType:(GLenum)shaderType;

/*!
 * Returns the id of the Shader.
 * @author Jason Chung
 *
 * @return The id of the Shader.
 */
- (GLuint)shaderId;

@end

NS_ASSUME_NONNULL_END
