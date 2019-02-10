//
//  Mesh.h
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GLProgram.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A renderable Mesh class
 */
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

// Allows the MVP to be accessed outside of the class
@property GLKMatrix4 _mvp;

/*!
 * Initializes the Mesh with some data
 * @author Jason Chung
 *
 * @param vertices The floats that make up the Mesh
 * @param verticesArrSize The size of the array
 * @param numVertices The number of vertices
 * @param indices The integers that make up the indices
 * @param indicesArrSize The size of the array
 * @param numIndices The number of indices
 */
- (id)initWithValues:(GLfloat *)vertices verticesArrSize:(GLsizei)verticesArrSize numVertices:(GLsizei)numVertices indices:(GLint *)indices indicesArrSize:(GLsizei)indicesArrSize numIndices:(GLsizei)numIndices;

/*!
 * Renders the mesh.
 * @author Jason Chung
 *
 * @param program A pointer to the GL program
 */
- (void)render:(GLProgram *)program;

/*!
 * Returns a pointer to the vertices.
 * @author Jason Chung
 *
 * @return A pointer to the vertices
 */
- (GLfloat *)getVertices;

/*!
 * Returns the number of vertices.
 * @author Jason Chung
 *
 * @return The number of vertices
 */
- (GLuint)getNumVertices;

/*!
 * Returns a pointer to the indices.
 * @author Jason Chung
 *
 * @return A pointer to the indices
 */
- (GLint *)getIndices;

/*!
 * Returns the number of indices.
 * @author Jason Chung
 *
 * @return The number of indices
 */
- (GLuint)getNumIndices;

@end

NS_ASSUME_NONNULL_END
