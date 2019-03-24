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
    // Three buffers for position, normals, texels
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
        self._position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._rotation = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._scale = GLKVector3Make(1.0f, 1.0f, 1.0f);
        self._textures = [[NSMutableArray<Texture *> alloc] init];
    }
    return self;
}

- (id)initWithVertexData:(GLfloat *)vertexData numVertices:(GLsizei)numVertices normals:(GLfloat *)normals uvs:(GLfloat *)uvs numUvs:(GLsizei)numUvs indices:(GLuint *)indices numIndices:(GLsizei)numIndices {
    if (self == [super init]) {
        self._numVertices = numVertices;
        self._numNormals = numVertices;
        self._numIndices = numIndices;
        self._numUvs = numUvs;
        self._vertices = malloc(sizeof(GLfloat) * numVertices);
        if (vertexData != NULL) {
            memcpy(self._vertices, vertexData, sizeof(GLfloat) * numVertices);
        }
        self._normals = malloc(sizeof(GLfloat) * numVertices);
        if (normals != NULL) {
            memcpy(self._normals, normals, sizeof(GLfloat) * numVertices);
        }
        self._uvs = malloc(sizeof(GLfloat) * numUvs);
        if (self._uvs != NULL) {
            memcpy(self._uvs, uvs, sizeof(GLfloat) * numUvs);
        }
        self._indices = malloc(sizeof(GLuint) * numIndices);
        if (indices != NULL) {
            memcpy(self._indices, indices, sizeof(GLuint) * numIndices);
        }
        
        self._position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._rotation = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._scale = GLKVector3Make(1.0f, 1.0f, 1.0f);
        self._textures = [[NSMutableArray<Texture *> alloc] init];
        
        [self setup];
    }
    
    return self;
}

- (id)initWithFilename:(const char *)filename {
    if (self == [super init]) {
        NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:"models"];
        NSString *contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        NSMutableArray<NSNumber *> *vertices = [[NSMutableArray<NSNumber *> alloc] init];
        NSMutableArray<NSNumber *> *normals = [[NSMutableArray<NSNumber *> alloc] init];
        NSMutableArray<NSNumber *> *uvs = [[NSMutableArray<NSNumber *> alloc] init];
        NSMutableArray<NSNumber *> *indices = [[NSMutableArray<NSNumber *> alloc] init];
        
        NSEnumerator *lineEnumerator = [lines objectEnumerator];
        id object;
        while (object = [lineEnumerator nextObject]) {
            if ([object length] < 2) continue;
            NSString *type = [object substringToIndex:2];
            NSString *line = [object substringFromIndex:2];
            int results = 0;
            
            if ([type isEqualToString:@"v "]) {
                GLfloat x, y, z;
                results = sscanf(line.UTF8String, "%f %f %f", &x, &y, &z);
                [vertices addObject:[NSNumber numberWithFloat:x]];
                [vertices addObject:[NSNumber numberWithFloat:y]];
                [vertices addObject:[NSNumber numberWithFloat:z]];
            } else if ([type isEqualToString:@"vn"]) {
                GLfloat x, y, z;
                results = sscanf(line.UTF8String, "%f %f %f", &x, &y, &z);
                [normals addObject:[NSNumber numberWithFloat:x]];
                [normals addObject:[NSNumber numberWithFloat:y]];
                [normals addObject:[NSNumber numberWithFloat:z]];
            } else if ([type isEqualToString:@"vt"]) {
                GLfloat x, y;
                results = sscanf(line.UTF8String, "%f %f", &x, &y);
                [uvs addObject:[NSNumber numberWithFloat:x]];
                [uvs addObject:[NSNumber numberWithFloat:y]];
            } else if ([type isEqualToString:@"f "]) {
                GLuint indexVertex[3], indexUV[3], indexNormal[3];
                results = sscanf(line.UTF8String, "%d/%d/%d %d/%d/%d %d/%d/%d"
                                 , &indexVertex[0], &indexUV[0], &indexNormal[0]
                                 , &indexVertex[1], &indexUV[1], &indexNormal[1]
                                 , &indexVertex[2], &indexUV[2], &indexNormal[2]);
                [indices addObject:[NSNumber numberWithUnsignedInt:indexVertex[0]]];
                [indices addObject:[NSNumber numberWithUnsignedInt:indexVertex[1]]];
                [indices addObject:[NSNumber numberWithUnsignedInt:indexVertex[2]]];
            } else {
                // we don't handle advanced OBJ models
                continue;
            }
        }
        
        NSUInteger vertexCount = vertices.count;
        self._numVertices = (GLsizei)vertexCount;
        self._vertices = malloc(sizeof(GLfloat) * vertexCount);
        for (int i = 0; i < vertexCount; i++) {
            self._vertices[i] = [[vertices objectAtIndex:i] floatValue];
        }
        NSUInteger normalsCount = normals.count;
        self._numNormals = (GLsizei)normalsCount;
        self._normals = malloc(sizeof(GLfloat) * normalsCount);
        for (int i = 0; i < normalsCount; i++) {
            self._normals[i] = [[normals objectAtIndex:i] floatValue];
        }
        NSUInteger uvsCount = uvs.count;
        self._numUvs = (GLsizei)uvsCount;
        self._uvs = malloc(sizeof(GLfloat) * uvsCount);
        for (int i = 0; i < uvsCount; i++) {
            self._uvs[i] = [[uvs objectAtIndex:i] floatValue];
        }
        NSUInteger indicesCount = indices.count;
        self._numIndices = (GLsizei)indicesCount;
        self._indices = malloc(sizeof(GLuint) * indicesCount);
        for (int i = 0; i < indicesCount; i++) {
            self._indices[i] = [[indices objectAtIndex:i] unsignedIntValue] - 1;
        }
        
        self._position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._rotation = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self._scale = GLKVector3Make(1.0f, 1.0f, 1.0f);
        self._textures = [[NSMutableArray<Texture *> alloc] init];
        
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
    
    if (self._vertices) {
        free(self._vertices);
    }
    
    if (self._normals) {
        free(self._normals);
    }
    
    if (self._uvs) {
        free(self._uvs);
    }
    
    if (self._indices) {
        free(self._indices);
    }
}

- (void)dealloc {
    [self cleanUp];
}

- (void)setup {
    glGenVertexArraysOES(1, &_vao);
    glGenBuffers(3, _vbo);
    glGenBuffers(1, &_ebo);
    
    glBindVertexArrayOES(_vao);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 3 * self._numVertices, self._vertices, GL_STATIC_DRAW);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (const GLvoid *)0);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[1]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 3 * self._numNormals, self._normals, GL_STATIC_DRAW);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (const GLvoid *)0);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    
    glBindBuffer(GL_ARRAY_BUFFER, _vbo[2]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 2 * self._numUvs, self._uvs, GL_STATIC_DRAW);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(GLfloat), (const GLvoid *)0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLuint) * self._numIndices, self._indices, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArrayOES(0);
}

- (void)draw:(GLProgram *)program {
    unsigned int diffuseNr = 1;
    unsigned int specularNr = 1;
    unsigned int normalNr = 1;
    unsigned int heightNr = 1;
    
    for (unsigned int i = 0; i < [self._textures count]; i++) {
        glActiveTexture(GL_TEXTURE0 + i);
        unsigned int number = 0;
        const char *name = self._textures[i]._type;
        if (strncmp(name, "texture_diffuse", 64)) {
            number = diffuseNr++;
        } else if (strncmp(name, "texture_specular", 64)) {
            number = specularNr++;
        } else if (strncmp(name, "texture_normal", 64)) {
            number = normalNr++;
        } else if (strncmp(name, "texture_height", 64)) {
            number = heightNr++;
        }
        [program set1i:i uniformName:[[NSString stringWithFormat:@"%s%u", name, number] UTF8String]];
        glBindTexture(GL_TEXTURE_2D, self._textures[i]._id);
    }
    
    glBindVertexArrayOES(_vao);
    glDrawElements(GL_TRIANGLES, self._numIndices, GL_UNSIGNED_INT, 0);
    glBindVertexArrayOES(0);
    
    glActiveTexture(GL_TEXTURE0);
}

- (void)addTexture:(Texture *)texture {
    [self._textures addObject:texture];
}

- (id)copyWithZone:(NSZone *)zone {
    GLfloat vertices[self._numVertices];
    GLfloat normals[self._numNormals];
    GLuint indices[self._numIndices];
    
    for (int i = 0; i < self._numVertices; i++) {
        vertices[i] = self._vertices[i];
    }
    
    for (int i = 0; i < self._numNormals; i++) {
        normals[i] = self._normals[i];
    }
    
    for (int i = 0; i < self._numIndices; i++) {
        indices[i] = self._indices[i];
    }
    
	Mesh *copy = [[Mesh alloc] initWithVertexData:vertices numVertices:self._numVertices normals:normals uvs:self._uvs numUvs:self._numUvs indices:indices numIndices:self._numIndices];
	return copy;
}

@end
