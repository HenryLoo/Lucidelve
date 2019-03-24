//
//  Mesh.h
//  Adapted from Joey DeVries LearnOpenGL tutorials found at
//  https://learnopengl.com/
//  ass_2
//
//  Created by Choy on 2019-02-17.
//

#import "GLProgram.h"
#import "Texture.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A renderable Mesh object
 */
@interface Mesh : NSObject

// The mesh's array of vertices
@property (nonatomic) GLfloat *_vertices;
// The mesh's array of normals
@property (nonatomic) GLfloat *_normals;
// The mesh's array of texels
@property (nonatomic) GLfloat *_uvs;
// The mesh's array of indices
@property (nonatomic) GLuint *_indices;
// An array of textures
@property (nonatomic, strong) NSMutableArray<Texture *> *_textures;

// The number of vertices
@property (nonatomic) GLsizei _numVertices;
// The number of normals
@property (nonatomic) GLsizei _numNormals;
// The number of texels
@property (nonatomic) GLsizei _numUvs;
// The number of indices
@property (nonatomic) GLsizei _numIndices;

// The position of the Mesh
@property (nonatomic) GLKVector3 _position;
// The rotation of the Mesh
@property (nonatomic) GLKVector3 _rotation;
// The scale of the Mesh
@property (nonatomic) GLKVector3 _scale;

/*!
 * @brief Copies mesh data into the instance of the Mesh
 * @author Jason Chung
 *
 * @param vertexData An array of vertices
 * @param numVertices The length of the vertex array
 * @param normals An array of normals
 * @param uvs An array of texels
 * @param numUvs The length of the texel array
 * @param indices An array of indices
 * @param numIndices The length of the indices array
 *
 * @return An id of the created instance
 */
- (id)initWithVertexData:(GLfloat *)vertexData numVertices:(GLsizei)numVertices normals:(GLfloat *)normals uvs:(GLfloat *)uvs numUvs:(GLsizei)numUvs indices:(GLuint *)indices numIndices:(GLsizei)numIndices;
/*!
 * @brief Wavefront OBJ model loader, loads an OBJ model into the instance of the Mesh
 * @author Jason Chung
 *
 * @param filename The filename of the OBJ model
 *
 * @return An id of the created instance
 */
- (id)initWithFilename:(const char *)filename;

/*!
 * @brief Cleans up the Mesh
 * @author Jason Chung
 */
- (void)cleanUp;
/*!
 * @brief Renders the Mesh.
 * @author Jason Chung
 *
 * @param program A pointer to the program to set uniforms
 */
- (void)draw:(GLProgram *)program;
/*!
 * @brief Adds a texture to the array of textures
 * @author Jason Chung
 *
 * @param texture The new texture to add
 */
- (void)addTexture:(Texture *)texture;

- (id)copyWithZone:(NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
