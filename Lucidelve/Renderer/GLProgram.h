//
//  GLProgram.h
//  Lucidelve
//
//  Created by Choy on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Uniform.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A program on the GPU created from
 * a compiled vertex and fragment shader.
 */
@interface GLProgram : NSObject {
    // A reference to the program on the GPU
    GLuint _programId;
    // A reference to the vertex shader on the GPU
    GLuint _vertexShaderId;
    // A reference to the fragment shader on the GPU
    GLuint _fragmentShaderId;
    // An array of available Uniforms for the program
    NSMutableArray<Uniform *> *_uniforms;
}

/*!
 * Compiles and returns a reference to a shader given
 * the shader type and shader source code.
 * @author Jason Chung
 *
 * @param shaderType The type of shader
 * @param shaderSource The source code of a shader
 * @return A reference to the compiled shader
 */
+ (GLuint)compileShader:(GLenum)shaderType shaderSource:(const GLchar *)shaderSource;
/*!
 * Compiles and returns a reference to a program given
 * a reference to a vertex and fragment shader.
 * @author Jason Chung
 *
 * @param vertexShader A reference to a vertex shader
 * @param fragmentShader A reference to a fragment shader
 * @return A reference to the compiled program
 */
+ (GLuint)compileProgram:(GLuint)vertexShader fragmentShaderId:(GLuint)fragmentShader;
/*!
 * Retrieves the info log for a shader.
 * @author Jason Chung
 *
 * @param shaderId A reference to a shader
 */
+ (void)printShaderInfoLog:(GLuint)shaderId;
/*!
 * Retrieves the info log for a program.
 * @author Jason Chung
 *
 * @param programId A reference to a program
 */
+ (void)printProgramInfoLog:(GLuint)programId;

/*!
 * Initializes the GLProgram class with the source code
 * from a vertex and fragment shader.
 * @author Jason Chung
 *
 * @param vertexShaderSource The source code of a vertex shader
 * @param fragmentShaderSource The source code of a fragment shader
 * @return A reference to itself
 */
- (id)initWithSource:(NSString *)vertexShaderSource fragmentShaderSource:(NSString *)fragmentShaderSource;
/*!
 * Binds the program instance to be used
 */
- (void)bind;
/*!
 * Returns a uniform location from the program, if
 * it doesn't exist, then it is created and returned.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @return A pointer to the Uniform
 */
- (Uniform *)getUniform:(NSString *)name;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param val The value to set
 */
- (void)setUniform1i:(NSString *)name value:(GLint)val;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param val The value to set
 */
- (void)setUniform1f:(NSString *)name value:(GLfloat)val;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param f1 The value to set
 * @param f2 The value to set
 */
- (void)setUniform2f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param f1 The value to set
 * @param f2 The value to set
 * @param f3 The value to set
 */
- (void)setUniform3f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param f1 The value to set
 * @param f2 The value to set
 * @param f3 The value to set
 * @param f4 The value to set
 */
- (void)setUniform4f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3 f4:(GLfloat)f4;
/*!
 * Sets the Uniform value.
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param mat The value to set
 */
- (void)setUniformMatrix4fv:(NSString *)name matrix:(GLKMatrix4)mat;

@end

NS_ASSUME_NONNULL_END
