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
#import "Assets.h"
#import <OpenGLES/ES2/glext.h>
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface Renderer() {
    GLKMatrix4 viewMatrix;
    // Used to convert the view space to clip space
    GLKMatrix4 projectionMatrix;
    
    // A directional light
    DirectionalLight *dirLight;
}

@end

@implementation Renderer

- (id)initWithView:(GLKView *)view {
    if (self == [super init]) {
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        
        if (!_context) {
            [[Utility getInstance] log:@"Failed to create GLES context."];
        }
        
        view.context = _context;
        view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        
        [EAGLContext setCurrentContext:_context];
        
        dirLight = [[DirectionalLight alloc] init];
        
        glEnable(GL_DEPTH_TEST);
        glEnable(GL_TEXTURE_2D);
        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        float aspect = fabsf((float)(view.bounds.size.width / view.bounds.size.height));
        projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 1.f, 100.0f);
    }
    return self;
}

- (EAGLContext *)context {
	return _context;
}

- (Camera *)camera {
	return _camera;
}

- (void)setContext:(EAGLContext *)context {
	_context = context;
}

- (void)setCamera:(Camera *)camera {
    _camera = camera;
    viewMatrix = [_camera getViewMatrix];
}

- (void)setupRender:(CGRect)rect {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT |  GL_DEPTH_BUFFER_BIT);
}

- (void)renderMesh:(Mesh *)mesh program:(GLProgram *)program {
    if (mesh == nil) {
        [[Utility getInstance] log:@"Mesh was nil"];
        return;
    }
    [program bind];
    // material properties
    [program set3fv:_camera.position.v uniformName:@"viewPos"];
    
    [dirLight draw:program];
    
    [program set4fvm:viewMatrix.m uniformName:@"view"];
    [program set4fvm:projectionMatrix.m uniformName:@"projection"];
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4TranslateWithVector3(modelMatrix, [mesh position]);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, [mesh rotation].x, 1.0f, 0.0f, 0.0f);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, [mesh rotation].y, 0.0f, 1.0f, 0.0f);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, [mesh rotation].z, 0.0f, 0.0f, 1.0f);
    modelMatrix = GLKMatrix4ScaleWithVector3(modelMatrix, [mesh scale]);
    GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(GLKMatrix4Multiply(viewMatrix, modelMatrix)), NULL);
    [program set3fvm:normalMatrix.m uniformName:@"normalMatrix"];
    [program set4fvm:modelMatrix.m uniformName:@"model"];
    [mesh draw:program];
}

- (GLProgram *)baseRenderSprite:(Mesh *)mesh spriteIndex:(int)index
{
    if (mesh == nil) {
        [[Utility getInstance] log:@"Mesh was nil"];
        return nil;
    }
    GLProgram *program = [[Assets getInstance] getProgram:KEY_PROGRAM_SPRITE];
    [program bind];
    
    GLKVector2 texSize = GLKVector2Make([mesh textureAtIndex:0].width, [mesh textureAtIndex:0].height);
    [program set2fv:texSize.v uniformName:@"texSize"];
    
    GLKVector2 clipSize = GLKVector2Make(32, 32);
    [program set2fv:clipSize.v uniformName:@"clipSize"];
    
    [program set1i:index uniformName:@"spriteIndex"];
    
    return program;
}

- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index
{
    GLProgram *program = [self baseRenderSprite:mesh spriteIndex:index];
    [program set1i:true uniformName:@"isFogDisabled"];
    
    [self renderMesh:mesh program:program];
}

- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index fogColour:(GLKVector4)fogColour
       textureColour:(GLKVector4)textureColour textureColourAmount:(float)textureColourAmount
{
    GLProgram *program = [self baseRenderSprite:mesh spriteIndex:index];
    
    [program set4fv:textureColour.v uniformName:@"textureColour"];
    [program set1f:textureColourAmount uniformName:@"textureColourAmount"];
    
    [self renderWithFog:mesh program:program fogColour:fogColour];
}

- (void)renderWithFog:(Mesh *)mesh program:(GLProgram *)program fogColour:(GLKVector4)fogColour
{
    [program bind];
    
    [program set4fv:fogColour.v uniformName:@"fogColour"];
    
    [self renderMesh:mesh program:program];
}

@end
