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

@interface Mesh : NSObject

@property (nonatomic) GLfloat *_vertices;
@property (nonatomic) GLfloat *_normals;
@property (nonatomic) GLfloat *_uvs;
@property (nonatomic) GLuint *_indices;
@property (nonatomic, strong) NSMutableArray<Texture *> *_textures;

@property (nonatomic) GLsizei _numVertices;
@property (nonatomic) GLsizei _numNormals;
@property (nonatomic) GLsizei _numUvs;
@property (nonatomic) GLsizei _numIndices;

@property (nonatomic) GLKVector3 _position;
@property (nonatomic) GLKVector3 _rotation;
@property (nonatomic) GLKVector3 _scale;

- (id)initWithVertexData:(GLfloat *)vertexData numVertices:(GLsizei)numVertices normals:(GLfloat *)normals uvs:(GLfloat *)uvs numUvs:(GLsizei)numUvs indices:(GLuint *)indices numIndices:(GLsizei)numIndices;
- (id)initWithFilename:(const char *)filename;

- (void)cleanUp;
- (void)draw:(GLProgram *)program;
- (void)addTexture:(Texture *)texture;

@end

NS_ASSUME_NONNULL_END
