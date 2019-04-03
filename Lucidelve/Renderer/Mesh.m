//
//  Mesh.m
//  Adapted from Joey DeVries LearnOpenGL tutorials found at
//  https://learnopengl.com/
//  ass_2
//
//  Created by Choy on 2019-02-17.
//

#import "Mesh.h"
#import <OpenGLES/ES2/glext.h>
#import "../Utility.h"

@interface Mesh() {
    // The buffer of vertices
    GLuint _vbo[3];
    // A vertex array
    GLuint _vao;
    // Index buffer
    GLuint _ebo;
}
@end

@implementation Mesh

- (id)init {
    if (self == [super init]) {
        _vertices = [NSMutableData data];
        _textureCoords = [NSMutableData data];
        _normals = [NSMutableData data];
        _indices = [NSMutableData data];
        
        _textures = [[NSMutableArray<Texture *> alloc] init];
        
        _position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _rotation = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _scale = GLKVector3Make(1.0f, 1.0f, 1.0f);
        
        _specular = GLKVector3Make(1.0, 1.0, 1.0);
        _shininess = 1.0f;
    }
    return self;
}

- (id)initWithMesh:(Mesh *)mesh {
    if (self == [super init]) {
        _vertices = [NSMutableData dataWithData:[mesh vertices]];
		_textureCoords = [NSMutableData dataWithData:[mesh textureCoords]];
		_normals = [NSMutableData dataWithData:[mesh normals]];
        _indices = [NSMutableData dataWithData:[mesh indices]];
        
        _textures = [NSMutableArray arrayWithCapacity:[mesh numTextures]];
        for (int i = 0; i < [mesh numTextures]; i++) {
            Texture *texture = [mesh textureAtIndex:i];
            [self addTexture:texture];
        }
        
        _position = [mesh position];
        _rotation = [mesh rotation];
        _scale = [mesh scale];
        
        _specular = [mesh specular];
        _shininess = [mesh shininess];
        
        [self setup];
    }
    return self;
}

- (void)cleanUp {
    if (_vao) {
        glDeleteVertexArraysOES(1, &_vao);
        _vao = 0;
    }
    
    if (_vbo) {
        glDeleteBuffers(3, _vbo);
        _vbo[0] = 0;
        _vbo[1] = 0;
        _vbo[2] = 0;
    }
    
    if (_ebo) {
        glDeleteBuffers(1, &_ebo);
        _ebo = 0;
    }
}

- (void)setup {
    glGenVertexArraysOES(1, &_vao);
    glGenBuffers(3, _vbo);
    glGenBuffers(1, &_ebo);
    
    glBindVertexArrayOES(_vao);
    
    GLKVector3 *verticesBuffer = (GLKVector3 *)(_vertices.bytes);
    GLKVector2 *textureCoordsBuffer = (GLKVector2 *)(_textureCoords.bytes);
    GLKVector3 *normalsBuffer = (GLKVector3 *)(_normals.bytes);
    
    GLsizei numVertices = [self numVertices];
    GLsizei numTextureCoords = [self numTextureCoords];
    GLsizei numNormals = [self numNormals];
    GLsizei numIndices = [self numIndices];
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[0]);
    glBufferData(GL_ARRAY_BUFFER, numVertices * sizeof(GLKVector3), &verticesBuffer[0], GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLKVector3), (const GLvoid *)0);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[1]);
    glBufferData(GL_ARRAY_BUFFER, numTextureCoords * sizeof(GLKVector2), &textureCoordsBuffer[0], GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLKVector2), (const GLvoid *)0);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[2]);
    glBufferData(GL_ARRAY_BUFFER, numNormals * sizeof(GLKVector3), &normalsBuffer[0], GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(GLKVector3), (const GLvoid *)0);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, numIndices * sizeof(GLuint), _indices.bytes, GL_STATIC_DRAW);
    
    glBindVertexArrayOES(0);
}

- (void)draw:(GLProgram *)program {
    unsigned int diffuseNr = 1;
    unsigned int specularNr = 1;
    unsigned int normalNr = 1;
    unsigned int heightNr = 1;
    
    for (unsigned int i = 0; i < [_textures count]; i++) {
        glActiveTexture(GL_TEXTURE0 + i);
        unsigned int number = 0;
        NSString *name = [_textures[i] type];
        if ([name isEqualToString:@"texture_diffuse"]) {
            number = diffuseNr++;
        } else if ([name isEqualToString:@"texture_specular"]) {
            number = specularNr++;
        } else if ([name isEqualToString:@"texture_normal"]) {
            number = normalNr++;
        } else if ([name isEqualToString:@"texture_height"]) {
            number = heightNr++;
        }
        [program set1i:i uniformName:[NSString stringWithFormat:@"%@%u", name, number]];
        glBindTexture(GL_TEXTURE_2D, [_textures[i] textureId]);
    }
    
    [program set3fv:_specular.v uniformName:@"material.specular"];
    [program set1f:_shininess uniformName:@"material.shininess"];
    
    glBindVertexArrayOES(_vao);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ebo);
    glDrawElements(GL_TRIANGLES, [self numIndices], GL_UNSIGNED_INT, 0);
    glBindVertexArrayOES(0);
    glActiveTexture(GL_TEXTURE0);
}

- (void)addTexture:(Texture *)texture {
    [_textures addObject:texture];
}

- (void)setVertices:(NSMutableData *)vertices {
    _vertices = [NSMutableData dataWithData:vertices];
}

- (void)setTextureCoordinates:(NSMutableData *)textureCoords {
    _textureCoords = [NSMutableData dataWithData:textureCoords];
}

- (void)setNormals:(NSMutableData *)normals {
    _normals = [NSMutableData dataWithData:normals];
}

- (void)setIndices:(NSMutableData *)indices {
    _indices = [NSMutableData dataWithData:indices];
}

- (NSMutableData *)vertices {
	return _vertices;
}

- (NSMutableData *)textureCoords {
    return _textureCoords;
}

- (NSMutableData *)normals {
    return _normals;
}

- (NSMutableData *)indices {
	return _indices;
}
 
- (NSMutableArray<Texture *> *)textures {
	return _textures;
}

- (Texture *)textureAtIndex:(GLint)index {
    if (index > [self numTextures]) return nil;
    return _textures[index];
}

- (GLKVector3)position {
	return _position;
}

- (GLKVector3)rotation {
	return _rotation;
}

- (GLKVector3)scale {
	return _scale;
}

- (GLKVector3)specular {
    return _specular;
}

- (GLfloat)shininess {
    return _shininess;
}

- (void)setPosition:(GLKVector3)position {
	_position = position;
}

- (void)setRotation:(GLKVector3)rotation {
	_rotation = rotation;
}

- (void)setScale:(GLKVector3)scale {
	_scale = scale;
}

- (GLint)numTextures {
    return (GLint)(_textures.count);
}

- (GLint)numVertices {
    return (GLint)(_vertices.length / sizeof(GLKVector3));
}

- (GLint)numTextureCoords {
    return (GLint)(_textureCoords.length / sizeof(GLKVector2));
}

- (GLint)numNormals {
    return (GLint)(_normals.length / sizeof(GLKVector3));
}

- (GLint)numIndices {
    return (GLint)(_indices.length / sizeof(GLuint));
}
 
- (id)copy {
    return [[Mesh alloc] initWithMesh:self];
}

@end
