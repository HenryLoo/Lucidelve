//
//  Mesh.h
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GLProgram.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mesh : NSObject {
    // Data
    GLfloat *_vertices;
    GLfloat *_uvs;
    GLfloat *_normals;
    GLint *_indices;
    
    // Data count
    GLuint _numVertices;
    GLuint _numIndices;
}

@property GLKMatrix4 _mvp;

- (id)initWithValues:(GLfloat *)vertices verticesArrSize:(GLsizei)verticesArrSize numVertices:(GLsizei)numVertices indices:(GLint *)indices indicesArrSize:(GLsizei)indicesArrSize numIndices:(GLsizei)numIndices;

- (void)allocateMemory;
- (void)render:(GLProgram *)program;

- (GLfloat *)getVertices;
- (GLuint)getNumVertices;
- (GLint *)getIndices;
- (GLuint)getNumIndices;

@end

NS_ASSUME_NONNULL_END
