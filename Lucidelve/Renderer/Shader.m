//
//  Shader.m
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Shader.h"
#import "../Utility.h"

@implementation Shader

- (void)printInfoLog {
    GLsizei logLen = 0;
    GLsizei charsWritten = 0;
    GLchar *message;
    
    glGetShaderiv(_shaderId, GL_INFO_LOG_LENGTH, &logLen);
    
    if (logLen > 0) {
        message = (GLchar *)malloc(logLen);
        glGetShaderInfoLog(_shaderId, logLen, &charsWritten, message);
        [[Utility getInstance] log:[NSString stringWithUTF8String:message]];
        free(message);
    }
}

- (id)initWithFilename:(NSString *)filename shaderType:(GLenum)shaderType {
    if (self == [super init]) {
        _shaderId = glCreateShader(shaderType);
        NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:@"shaders"];
        const char *shaderSource = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] UTF8String];
        glShaderSource(_shaderId, 1, &shaderSource, NULL);
        [self compile];
    }
    return self;
}

- (void)compile {
    GLsizei success;
    
    glCompileShader(_shaderId);
    
    glGetShaderiv(_shaderId, GL_COMPILE_STATUS, &success);
    
    if (success == GL_FALSE) {
        [self printInfoLog];
    }
}

- (GLuint)shaderId {
	return _shaderId;
}

@end
