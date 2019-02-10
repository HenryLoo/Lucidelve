//
//  GLProgram.m
//  Lucidelve
//
//  Created by Choy on 2019-02-08.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GLProgram.h"

@implementation GLProgram

+ (void)printShaderInfoLog:(GLuint)shaderId {
    GLint logLength = 0;
    GLint charsWritten = 0;
    GLchar *message;
    
    glGetShaderiv(shaderId, GL_INFO_LOG_LENGTH, &logLength);
    
    if (logLength > 0) {
        message = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(shaderId, logLength, &charsWritten, message);
        NSLog(@"%@", [NSString stringWithFormat:@"%s", message]);
        free(message);
    }
}

+ (void)printProgramInfoLog:(GLuint)programId {
    GLint logLength = 0;
    GLint charsWritten = 0;
    GLchar *message;
    
    glGetProgramiv(programId, GL_INFO_LOG_LENGTH, &logLength);
    
    if (logLength > 0) {
        message = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(programId, logLength, &charsWritten, message);
        NSLog(@"%@", [NSString stringWithFormat:@"%s", message]);
        free(message);
    }
}

+ (GLuint)compileShader:(GLenum)shaderType shaderSource:(const GLchar *)shaderSource {
    GLuint shader = glCreateShader(shaderType);
    
    if (shader == 0) {
        NSLog(@"Failed to create the shader.");
        return 0;
    }
    
    glShaderSource(shader, 1, &shaderSource, NULL);
    glCompileShader(shader);
    
    GLint compiled;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    if (!compiled) {
        [[self class] printShaderInfoLog:shader];
        glDeleteShader(shader);
        return 0;
    }
    
    return shader;
}

+ (GLuint)compileProgram:(GLuint)vertexShader fragmentShaderId:(GLuint)fragmentShader {
    GLuint program = glCreateProgram();
    if (program == 0) {
        NSLog(@"Failed to create the program.");
        glDeleteShader(vertexShader);
        glDeleteShader(fragmentShader);
        return 0;
    }
    
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    
    GLint linked;
    glGetProgramiv(program, GL_LINK_STATUS, &linked);
    if (!linked) {
        [[self class] printProgramInfoLog:program];
        glDeleteShader(vertexShader);
        glDeleteShader(fragmentShader);
        glDeleteProgram(program);
        return 0;
    }
    
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    return program;
}

- (id)initWithSource:(NSString *)vertexShaderSource fragmentShaderSource:(NSString *)fragmentShaderSource {
    self = [super init];
    if (self) {
        const GLchar *vertexString = [vertexShaderSource UTF8String];
        const GLchar *fragmentString = [fragmentShaderSource UTF8String];
        
        _vertexShaderId = [[self class] compileShader:GL_VERTEX_SHADER shaderSource:vertexString];
        _fragmentShaderId = [[self class] compileShader:GL_FRAGMENT_SHADER shaderSource:fragmentString];
        _programId = [[self class] compileProgram:_vertexShaderId fragmentShaderId:_fragmentShaderId];
        
        _uniforms = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)bind {
    glUseProgram(_programId);
}

- (void)dealloc {
    glDetachShader(_programId, _vertexShaderId);
    glDetachShader(_programId, _fragmentShaderId);
    glDeleteShader(_vertexShaderId);
    glDeleteShader(_fragmentShaderId);
    glDeleteProgram(_programId);
}

- (Uniform *)getUniform:(NSString *)name {
    for (Uniform *uniform in _uniforms) {
        if ([[uniform getName] isEqualToString:name]) {
            return uniform;
        }
    }
    
    Uniform *uniform = [[Uniform alloc] init];
    [uniform setName:name];
    [uniform setLocation:glGetUniformLocation(_programId, name.UTF8String)];
    [_uniforms addObject:uniform];
    
    return _uniforms.lastObject;
}

- (void)setUniform1i:(NSString *)name value:(GLint)val {
    glUniform1i([[self getUniform:name] getLocation], val);
}

- (void)setUniform1f:(NSString *)name value:(GLfloat)val {
    glUniform1f([[self getUniform:name] getLocation], val);
}

- (void)setUniform2f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 {
    glUniform2f([[self getUniform:name] getLocation], f1, f2);
}

- (void)setUniform3f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3 {
    glUniform3f([[self getUniform:name] getLocation], f1, f2, f3);
}

- (void)setUniform4f:(NSString *)name f1:(GLfloat)f1 f2:(GLfloat)f2 f3:(GLfloat)f3 f4:(GLfloat)f4 {
    glUniform4f([[self getUniform:name] getLocation], f1, f2, f3, f4);
}

- (void)setUniformMatrix4fv:(NSString *)name matrix:(GLKMatrix4)mat {
    glUniformMatrix4fv([[self getUniform:name] getLocation], 1, GL_FALSE, mat.m);
}

@end
