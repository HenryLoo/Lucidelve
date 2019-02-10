//
//  Mesh.m
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh

- (id) initWithValues:(GLfloat *)vertices verticesArrSize:(GLsizei)verticesArrSize numVertices:(GLsizei)numVertices indices:(GLint *)indices indicesArrSize:(GLsizei)indicesArrSize numIndices:(GLsizei)numIndices {
    self = [super init];
    if (self) {
        _numVertices = numVertices;
        _numIndices = numIndices;
        _vertices = (GLfloat *)malloc(sizeof (GLfloat) * 3 * numVertices);
        memcpy(_vertices, vertices, verticesArrSize);
        _indices = (GLint *)malloc(sizeof (GLint) * numIndices);
        memcpy(_indices, indices, indicesArrSize);
    }
    return self;
}

- (void)render:(GLProgram *)program {
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), _vertices);
    glEnableVertexAttribArray(0);
    glVertexAttrib4f(1, 1.0f, 0.0f, 0.0f, 1.0f);
    [program setUniformMatrix4fv:@"modelViewProjectionMatrix" matrix:__mvp];
    glDrawElements(GL_TRIANGLES, _numIndices, GL_UNSIGNED_INT, _indices);
}

- (GLfloat *)getVertices {
    return _vertices;
}

- (GLuint)getNumVertices {
    return _numVertices;
}

- (GLint *)getIndices {
    return _indices;
}

- (GLuint)getNumIndices {
    return _numIndices;
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
