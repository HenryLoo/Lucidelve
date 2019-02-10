//
//  Renderer.m based on code provided by Borna Noureddin.
//  Lucidelve
//
//  Created by Choy on 2019-02-07.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Renderer.h"
#import "GLProgram.h"
#import "Mesh.h"
#import "Utility.h"

@interface Renderer () {
    // A pointer to the GLKView
    GLKView *_view;
    
    // A pointer to the compiled GL program
    GLProgram *_glProgram;
    // A simple Mesh to render
    Mesh *_square;
}
@end

@implementation Renderer

- (void)init:(GLKView *)view {
    // Creates an OpenGLES context
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!view.context) {
        [NSException raise:@"GLES error" format:@"Failed to crate GLES context"];
    }
    
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    _view = view;
    [EAGLContext setCurrentContext:_view.context];
    
    [self initShaders];
    
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glEnable(GL_DEPTH_TEST);
}

/*!
 * Loads shaders from their files, compiles them,
 * and links them to a program.
 * @author Jason Chung
 */
- (void)initShaders {
    // Obtain a reference to the bundle with all of our assets
    NSBundle *bundle = [NSBundle mainBundle];
    // Load the vertex shader into a byte array
    NSData *vertexShaderData = [[Utility getInstance] loadResource:[bundle pathForResource:@"basic.vsh" ofType:nil] error:NULL];
    // Load the fragment shader into a byte array
    NSData *fragmentShaderData = [[Utility getInstance] loadResource:[bundle pathForResource:@"basic.fsh" ofType:nil] error:NULL];
    // Create an NSString from the byte array
    NSString *vertexShaderString = [[NSString alloc] initWithData:vertexShaderData encoding:NSUTF8StringEncoding];
    // Create an NSString from the byte array
    NSString *fragmentShaderString = [[NSString alloc] initWithData:fragmentShaderData encoding:NSUTF8StringEncoding];
    
    // Creates and compiles the GL program
    _glProgram = [[GLProgram alloc] initWithSource:vertexShaderString fragmentShaderSource:fragmentShaderString];
    // Establishes that there is a modelViewProjectionMatrix uniform
    [_glProgram getUniform:@"modelViewProjectionMatrix"];
    
    GLfloat cubeVerts[] =
    {
        -0.5f, -0.5f, 0.0f,
        0.5f, 0.5f,  0.0f,
        -0.5f, 0.5f,  0.0f,
        0.5f, -0.5f,  0.0f,
    };
           
    GLint cubeIndices[] =
    {
       0, 1, 2,
       0, 3, 1,
    };
    
    GLfloat *vertices = cubeVerts;
    GLint *indices = cubeIndices;
    
    // Creates a Square mesh from the given values
    _square = [[Mesh alloc] initWithValues:vertices verticesArrSize:12 numVertices:4 indices:indices indicesArrSize: 6 numIndices:6];
}

- (void)update:(float)deltaTime {
    // Places the camera in the world
    GLKMatrix4 baseMVM = GLKMatrix4MakeTranslation(0, 0, -5);
    
    // Applies the base matrix to the square's matrix
    _square._mvp = GLKMatrix4Identity;
    _square._mvp = GLKMatrix4Multiply(baseMVM, _square._mvp);
    
    // Applies the perspective matrix
    float aspect = (float)_view.drawableWidth / (float)_view.drawableHeight;
    GLKMatrix4 perspectiveMatrix = GLKMatrix4MakePerspective(60.0f * M_PI / 180.0f, aspect, 1.0f, 20.0f);
    _square._mvp = GLKMatrix4Multiply(perspectiveMatrix, _square._mvp);
}

- (void)render:(float)deltaTime drawRect:(CGRect)drawRect {
    glUniformMatrix4fv([[_glProgram getUniform:@"modelViewProjectionMatrix"] getLocation], 1, FALSE, (const float *)_square._mvp.m);
    
    glViewport(0, 0, (int)_view.drawableWidth, (int)_view.drawableHeight);
    NSLog([NSString stringWithFormat:@"%i, %i", (int)_view.drawableWidth, (int)_view.drawableHeight]);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [_glProgram bind];
    
    [_square render:_glProgram];
}

@end