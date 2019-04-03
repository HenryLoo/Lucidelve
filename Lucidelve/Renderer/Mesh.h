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

typedef struct {
    GLKVector3 position;
    GLKVector2 uv;
    GLKVector3 normal;
} Vertex;

/*!
 * @brief A renderable Mesh object
 */
@interface Mesh : NSObject {
    // The vertices positions of the Mesh
    NSMutableData *_vertices;
    // The texture coordinates of the Mesh
    NSMutableData *_textureCoords;
    // The normals of the Mesh
    NSMutableData *_normals;
    // The indices of the Vertices
    NSMutableData *_indices;
    // The textures this Mesh is using
    NSMutableArray<Texture *> *_textures;
    
    // The position of the Mesh
    GLKVector3 _position;
    // The rotation of the Mesh
    GLKVector3 _rotation;
    // The scale of the Mesh
    GLKVector3 _scale;
    
    GLKVector3 _specular;
    GLfloat _shininess;
}

/*!
 * @brief Wavefront OBJ model loader, loads an OBJ model into the instance of the Mesh
 * @author Jason Chung
 *
 * @param filename The filename of the OBJ model
 *
 * @return An id of the created instance
 */
// - (id)initWithFilename:(NSString *)filename;

/*!
 * @brief Initializes a Mesh instance and copies another Meshes values.
 * @author Jason Chung
 *
 * @param mesh The mesh to copy.
 *
 * @return The new Mesh.
 */
- (id)initWithMesh:(Mesh *)mesh;

/*!
 * Sets up the OpenGL buffers for this Mesh.
 * @author Jason Chung
 */
- (void)setup;

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

- (void)setVertices:(NSMutableData *)vertices;
- (void)setTextureCoordinates:(NSMutableData *)textureCoords;
- (void)setNormals:(NSMutableData *)normals;
- (void)setIndices:(NSMutableData *)indices;

/*!
 * @brief Adds a texture to the array of textures
 * @author Jason Chung
 *
 * @param texture The new texture to add
 */
- (void)addTexture:(Texture *)texture;

/*!
 * Returns the vertex positions of the Mesh.
 * @author Jason Chung
 *
 * @return The vertex positions of the Mesh.
 */
- (NSMutableData *)vertices;
/*!
 * Returns the vertex texture coordinates of the Mesh.
 * @author Jason Chung
 *
 * @return The vertex texture coordinates of the Mesh.
 */
- (NSMutableData *)textureCoords;
/*!
 * Returns the vertex normals of the Mesh.
 * @author Jason Chung
 *
 * @return The vertex normals of the Mesh.
 */
- (NSMutableData *)normals;
/*!
 * Returns the indices of the Mesh.
 * @author Jason Chung
 *
 * @return The indices of the Mesh.
 */
- (NSMutableData *)indices;
/*!
 * Returns the textures of the Mesh.
 * @author Jason Chung
 *
 * @return The textures of the Mesh.
 */
- (NSMutableArray<Texture *> *)textures;
/*!
 * Returns the texture of the Mesh at the index.
 * @author Jason Chung
 *
 * @param index The index in the textures array
 *
 * @return The texture of the Mesh at the index.
 */
- (Texture *)textureAtIndex:(GLint)index;

/*!
 * Returns the position of the Mesh.
 * @author Jason Chung
 *
 * @return The position of the Mesh.
 */
- (GLKVector3)position;
/*!
 * Returns the rotation of the Mesh.
 * @author Jason Chung
 *
 * @return The rotation of the Mesh.
 */
- (GLKVector3)rotation;
/*!
 * Returns the scale of the Mesh.
 * @author Jason Chung
 *
 * @return The scale of the Mesh.
 */
- (GLKVector3)scale;

- (GLKVector3)specular;
- (GLfloat)shininess;

/*!
 * Sets the position of the Mesh.
 * @author Jason Chung
 *
 * @param position The new position of the Mesh.
 */
- (void)setPosition:(GLKVector3)position;
/*!
 * Sets the rotation of the Mesh.
 * @author Jason Chung
 *
 * @param rotation The new rotation of the Mesh.
 */
- (void)setRotation:(GLKVector3)rotation;
/*!
 * Sets the scale of the Mesh.
 * @author Jason Chung
 *
 * @param scale The new scale of the Mesh.
 */
- (void)setScale:(GLKVector3)scale;

/*!
 * Returns the number of textures of the Mesh.
 * @author Jason Chung
 *
 * @return The number of textures of the Mesh.
 */
- (GLint)numTextures;
/*!
 * Returns the number of vertices of the Mesh.
 * @author Jason Chung
 *
 * @return The number of vertices of the Mesh.
 */
- (GLint)numVertices;
/*!
 * Returns the number of the Mesh's texture coordinates.
 * @author Jason Chung
 *
 * @return The number of texture coordinates of the Mesh.
 */
- (GLint)numTextureCoords;
/*!
 * Returns the number of normals of the Mesh.
 * @author Jason Chung
 *
 * @return The number of normals of the Mesh.
 */
- (GLint)numNormals;
/*!
 * Returns the number of indices of the Mesh.
 * @author Jason Chung
 *
 * @return The number of indices of the Mesh.
 */
- (GLint)numIndices;

/*!
 * Returns a copied instance of this Mesh.
 *
 * @return A new instance copied from this Mesh.
 */
- (id)copy;

@end

NS_ASSUME_NONNULL_END
