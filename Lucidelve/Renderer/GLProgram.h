//
//  GLProgram.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Shader.h"
#import "Attribute.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A compiled GL program
 */
@interface GLProgram : NSObject {
    // The reference to the program
    GLuint _programId;
}

/*!
 * @brief Initializes the program with shaders and links them.
 * @author Jason Chung
 *
 * @param shaders An array of shaders to compile and link
 * @param attributes An array of attributes to bind to the program
 *
 * @return An id to the created instance
 */
- (id)initWithShaders:(NSMutableArray<Shader *> *_Nonnull*_Nonnull)shaders attributes:(NSMutableArray<Attribute *> *_Nonnull*_Nonnull)attributes;
/*!
 * @brief Binds the program to be used
 * @author Jason Chung
 */
- (void)bind;
/*!
 * @brief Unbinds the program to be used
 * @author Jason Chung
 */
- (void)unbind;
/*!
 * Returns the id of the GLProgram.
 * @author Jason Chung
 *
 * @return The id of the GLProgram.
 */
- (GLuint)programId;
 
/*!
 * @brief Returns the location of the known uniforms for the program, and adds it to the
 * list of known uniforms if it is not found.
 * @author Jason Chung
 *
 * @param name The name of the uniform to look for
 *
 * @return Returns the location of the uniform on the program
 */
- (GLuint)getUniform:(NSString *)name;
/*!
 * @brief Sets an integer to the uniform.
 * @author Jason Chung
 *
 * @param value The value to set
 * @param name The name of the uniform to update
 */
- (void)set1i:(int)value uniformName:(NSString *)name;
/*!
 * @brief Sets a float to the uniform.
 * @author Jason Chung
 *
 * @param value The value to set
 * @param name The name of the uniform to update
 */
- (void)set1f:(float)value uniformName:(NSString *)name;
/*!
 * @brief Sets two floats to the uniform.
 * @author Jason Chung
 *
 * @param f1 The first value to set
 * @param f2 The second value to set
 * @param name The name of the uniform to update
 */
- (void)set2f:(float)f1 f2:(float)f2 uniformName:(NSString *)name;
/*!
 * @brief Sets three floats to the uniform.
 * @author Jason Chung
 *
 * @param f1 The first value to set
 * @param f2 The second value to set
 * @param f3 The third value to set
 * @param name The name of the uniform to update
 */
- (void)set3f:(float)f1 f2:(float)f2 f3:(float)f3 uniformName:(NSString *)name;
/*!
 * @brief Sets four floats to the uniform.
 * @author Jason Chung
 *
 * @param f1 The first value to set
 * @param f2 The second value to set
 * @param f3 The third value to set
 * @param f4 The fourth value to set
 * @param name The name of the uniform to update
 */
- (void)set4f:(float)f1 f2:(float)f2 f3:(float)f3 f4:(float)f4 uniformName:(NSString *)name;
/*!
 * @brief Sets an array of floats to the uniform.
 * @author Jason Chung
 *
 * @param vector The vector to set
 * @param name The name of the uniform to update
 */
- (void)set2fv:(GLfloat *)vector uniformName:(NSString *)name;
/*!
 * @brief Sets an array of floats to the uniform.
 * @author Jason Chung
 *
 * @param vector The vector to set
 * @param name The name of the uniform to update
 */
- (void)set3fv:(GLfloat *)vector uniformName:(NSString *)name;
/*!
 * @brief Sets an array of floats to the uniform.
 * @author Jason Chung
 *
 * @param vector The vector to set
 * @param name The name of the uniform to update
 */
- (void)set4fv:(GLfloat *)vector uniformName:(NSString *)name;
/*!
 * @brief Sets a 3x3 matrix to the uniform
 * @author Jason Chung
 *
 * @param matrix The matrix to set
 * @param name The name of the uniform to update
 */
- (void)set3fvm:(GLfloat *)matrix uniformName:(NSString *)name;
/*!
 * @brief Sets a 4x4 matrix to the uniform.
 * @author Jason Chung
 *
 * @param matrix The matrix to set
 * @param name The name of the uniform to update
 */
- (void)set4fvm:(GLfloat *)matrix uniformName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
