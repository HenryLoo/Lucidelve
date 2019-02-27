//
//  Renderer.m
//  ass_2
//
//  Created by Choy on 2019-02-16.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Renderer.h"
#import "GLProgram.h"
#import "../Utility.h"
#import "DirectionalLight.h"
#import "SpotLight.h"
#import <OpenGLES/ES2/glext.h>
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface Renderer() {
    // The compiled GL program
    GLProgram *_glProgram;
    
    // Used to convert the view space to clip space
    GLKMatrix4 _projectionMatrix;
    
    // A directional light
    DirectionalLight *dirLight;
}

@end

@implementation Renderer

- (id)initWithView:(GLKView *)view {
    if (self == [super init]) {
        self._context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        
        if (!self._context) {
            [[Utility getInstance] log:"Failed to create GLES context."];
        }
        
        view.context = self._context;
        view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        
        [EAGLContext setCurrentContext:self._context];
        
        if (![self loadShaders]) {
            [[Utility getInstance] log:"Failed to setup shaders."];
        }
        
        dirLight = [[DirectionalLight alloc] init];
        
        glEnable(GL_DEPTH_TEST);
        glEnable(GL_TEXTURE_2D);
        glEnable(GL_BLEND);
        glViewport(0, 0, (GLsizei)view.bounds.size.width, (GLsizei)view.bounds.size.height);
        
        self._camera = [[Camera alloc] initWithPosition:GLKVector3Make(0.0f, 0.0f, 3.0f)];
        self._meshes = [[NSMutableArray<Mesh *> alloc] init];
        
        float aspect = fabsf((float)(view.bounds.size.width / view.bounds.size.height));
        _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 1.f, 100.0f);
    }
    return self;
}

- (void)cleanUp {
    [EAGLContext setCurrentContext:self._context];
    
    // Clean up meshes here
    for (Mesh *mesh in self._meshes) {
        [mesh cleanUp];
    }
}

- (void)update:(float)deltaTime {
    
}

- (void)render:(float)deltaTime drawInRect:(CGRect)rect {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT |  GL_DEPTH_BUFFER_BIT);
    
    [_glProgram bind];
    
    // material properties
    [_glProgram set3fv:self._camera._position.v uniformName:"viewPos"];
    
    [dirLight draw:_glProgram];

    [_glProgram set4fvm:[self._camera getViewMatrix].m uniformName:"view"];
    [_glProgram set4fvm:_projectionMatrix.m uniformName:"projection"];
    
    // Render stuff
    for (Mesh *mesh in self._meshes) {
        GLKMatrix4 modelMatrix = GLKMatrix4Identity;
        modelMatrix = GLKMatrix4Translate(modelMatrix, mesh._position.x,  mesh._position.y, mesh._position.z);
        modelMatrix = GLKMatrix4Rotate(modelMatrix, mesh._rotation.x, 1.0f, 0.0f, 0.0f);
        modelMatrix = GLKMatrix4Rotate(modelMatrix, mesh._rotation.y, 0.0f, 1.0f, 0.0f);
        modelMatrix = GLKMatrix4Rotate(modelMatrix, mesh._rotation.z, 0.0f, 0.0f, 1.0f);
        modelMatrix = GLKMatrix4Scale(modelMatrix, mesh._scale.x, mesh._scale.y, mesh._scale.z);
        GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(GLKMatrix4Multiply([self._camera getViewMatrix], modelMatrix)), NULL);
        [_glProgram set3fvm:normalMatrix.m uniformName:"normalMatrix"];
        [_glProgram set4fvm:modelMatrix.m uniformName:"model"];
        [mesh draw:_glProgram];
    }
}

- (bool)loadShaders {
    Shader *vertexShader = [[Shader alloc] initWithFilename:"basic.vsh" shaderType:GL_VERTEX_SHADER];
    Shader *fragmentShader = [[Shader alloc] initWithFilename:"basic.fsh" shaderType:GL_FRAGMENT_SHADER];
    NSMutableArray<Shader *> *shaders = [[NSMutableArray<Shader *> alloc] init];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    NSMutableArray<Attribute *> *attributes = [[NSMutableArray<Attribute *> alloc] init];
    Attribute *position = [[Attribute alloc] initWithName:"aPos" index:GLKVertexAttribPosition];
    Attribute *normal = [[Attribute alloc] initWithName:"aNormal" index:GLKVertexAttribNormal];
    Attribute *texCoordIn = [[Attribute alloc] initWithName:"aTexCoords" index:GLKVertexAttribTexCoord0];
    [attributes addObject:position];
    [attributes addObject:normal];
    [attributes addObject:texCoordIn];
    _glProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    
    if (!_glProgram) {
        return false;
    }
    
    return true;
}

- (void)setMeshes:(NSMutableArray<Mesh *> *)meshes {
    [self._meshes setArray:meshes];
}

- (void)addMesh:(Mesh *)mesh {
    [self._meshes addObject:mesh];
}

@end
