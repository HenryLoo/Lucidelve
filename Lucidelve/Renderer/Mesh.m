//
//  Mesh.m
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh

- (id) initWithValues {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)render:(GLProgram *)program {
    // The position in the vertex shader
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof (GLfloat), _vertices);
    glEnableVertexAttribArray(0);
    
    // The colour in the vertex shader
    glVertexAttrib4f(1, 1.0f, 0.0f, 0.0f, 1.0f);
    
    // The uv coordinates in the vertex shader
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 2 * sizeof (GLfloat), _uvs);
    glEnableVertexAttribArray(2);
    
    [program setUniformMatrix4fv:@"modelViewProjectionMatrix" matrix:__mvp];
    glDrawElements(GL_TRIANGLES, _numIndices, GL_UNSIGNED_INT, _indices);
}

- (void)setVertices:(GLfloat *)vertices arrSize:(GLsizei)arrSize numVertices:(GLsizei)numVertices {
    _numVertices = numVertices;
    _vertices = (GLfloat *)malloc(sizeof (GLfloat) * 3 * numVertices);
    memcpy(_vertices, vertices, sizeof (GLfloat) * arrSize);
}

- (GLfloat *)getVertices {
    return _vertices;
}

- (GLuint)getNumVertices {
    return _numVertices;
}

- (void)setIndices:(GLint *)indices arrSize:(GLsizei)arrSize numIndices:(GLsizei)numIndices {
    _numIndices = numIndices;
    _indices = (GLint *)malloc(sizeof (GLint) * numIndices);
    memcpy(_indices, indices, sizeof (GLint) * arrSize);
}

- (GLint *)getIndices {
    return _indices;
}

- (GLuint)getNumIndices {
    return _numIndices;
}

- (void)setUVs:(GLfloat *)uvs arrSize:(GLsizei)arrSize numUVs:(GLsizei)numUVs {
    _numUVs = numUVs;
    _uvs = (GLfloat *)malloc(sizeof (GLfloat) * 3 * numUVs);
    memcpy(_uvs, uvs, sizeof (GLfloat) * arrSize);
}

- (GLfloat *)getUVs {
    return _uvs;
}

- (GLuint)getNumUVs {
    return _numUVs;
}

- (void)setNormals:(GLfloat *)normals arrSize:(GLsizei)arrSize numNormals:(GLsizei)numNormals {
    _numNormals = numNormals;
    _normals = (GLfloat *)malloc(sizeof (GLfloat) * 3 * numNormals);
    memcpy(_normals, normals, sizeof (GLfloat) * arrSize);
}

- (GLfloat *)getNormals {
    return _normals;
}

- (GLuint)getNumNormals {
    return _numNormals;
}

- (void)setTextureId:(GLuint)textureId {
    _textureId = textureId;
}

- (GLuint)getTextureId {
    return _textureId;
}

+ (GLuint)loadTexture:(NSString *)fileName {
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        [NSException raise:@"iOS error" format:@"Failed to load the texture."];
    }
    
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte *spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
    
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    free(spriteData);
    
    return texture;
}

- (void)dealloc {
    if (_vertices) {
        free(_vertices);
    }
    if (_uvs) {
        free(_uvs);
    }
    if (_normals) {
        free(_normals);
    }
}
@end
