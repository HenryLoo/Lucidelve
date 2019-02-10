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
    GLuint _textureId;
    
    // Data count
    GLuint _numVertices;
    GLuint _numIndices;
    GLuint _numUVs;
    GLuint _numNormals;
}

// Allows the MVP to be accessed outside of the class
@property GLKMatrix4 _mvp;
// Allows the normal matrix to be accessed outside of the class
@property GLKMatrix3 _normalMatrix;

/*!
 * Initializes the Mesh with some data
 * @author Jason Chung
 */
- (id)initWithValues;

/*!
 * Renders the mesh.
 * @author Jason Chung
 *
 * @param program A pointer to the GL program
 */
- (void)render:(GLProgram *)program;

/*!
 * Sets the vertices for the Mesh
 * @author Jason Chung
 */
- (void)setVertices:(GLfloat *)vertices arrSize:(GLsizei)arrSize numVertices:(GLsizei)numVertices;
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
 * Sets the indices for the Mesh
 * @author Jason Chung
 *
 * @param indices The integers that make up the indices
 * @param arrSize The size of the array
 * @param numIndices The number of indices
 */
- (void)setIndices:(GLint *)indices arrSize:(GLsizei)arrSize numIndices:(GLsizei)numIndices;
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
/*!
 * Sets the UVs for the Mesh
 * @author Jason Chung
 */
- (void)setUVs:(GLfloat *)uvs arrSize:(GLsizei)arrSize numUVs:(GLsizei)numUVs;
/*!
 * Returns a pointer to the UVs.
 * @author Jason Chung
 *
 * @return A pointer to the UVs
 */
- (GLfloat *)getUVs;
/*!
 * Returns the number of UVs.
 * @author Jason Chung
 *
 * @return The number of UVs
 */
- (GLuint)getNumUVs;
/*!
 * Sets the normals for the Mesh
 * @author Jason Chung
 */
- (void)setNormals:(GLfloat *)normals arrSize:(GLsizei)arrSize numNormals:(GLsizei)numNormals;
/*!
 * Returns a pointer to the normals.
 * @author Jason Chung
 *
 * @return A pointer to the normals
 */
- (GLfloat *)getNormals;
/*!
 * Returns the number of normals.
 * @author Jason Chung
 *
 * @return The number of normals
 */
- (GLuint)getNumNormals;
/*!
 * Sets the texture id
 * @author Jason Chung
 *
 * @param textureId The texture id
 */
- (void)setTextureId:(GLuint)textureId;
/*!
 * Returns the texture id
 * @author Jason Chung
 *
 * @return The texture id
 */
- (GLuint)getTextureId;
/*!
 * Returns the texture id of a loaded texture,
 * from Borna Noureddin's example code.
 * @author Jason Chung
 *
 * @param fileName The name of a file
 * @return The texture id
 */
+ (GLuint)loadTexture:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
