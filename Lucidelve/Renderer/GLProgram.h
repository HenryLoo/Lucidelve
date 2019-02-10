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

@interface GLProgram : NSObject {
    GLuint _programId;
    GLuint _vertexShaderId;
    GLuint _fragmentShaderId;
    NSMutableArray<Uniform *> *_uniforms;
}

+ (GLuint)compileShader:(GLenum)shaderType shaderSource:(const GLchar *)shaderSource;
+ (GLuint)compileProgram:(GLuint)vertexShader fragmentShaderId:(GLuint)fragmentShader;
+ (void)printShaderInfoLog:(GLuint)shaderId;
+ (void)printProgramInfoLog:(GLuint)programId;

- (id)initWithSource:(NSString *)vertexShaderSource fragmentShaderSource:(NSString *)fragmentShaderSource;
- (void)bind;
- (Uniform *)getUniform:(NSString *)name;
- (void)setUniform1i:(NSString *)name value:(GLint)val;
- (void)setUniform1f:(NSString *)name value:(GLfloat)val;
- (void)setUniform2f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2;
- (void)setUniform3f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3;
- (void)setUniform4f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3 f4:(GLfloat)f4;
- (void)setUniformMatrix4fv:(NSString *)name matrix:(GLKMatrix4)mat;

@end

NS_ASSUME_NONNULL_END
