//
//  Renderer.h
//  ass_2
//
//  Created by Choy on 2019-02-16.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Camera.h"
#import "Mesh.h"
#import "GLProgram.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A renderer capable of rendering meshes
 */
@interface Renderer : NSObject {
    // A reference to the GL context
    EAGLContext *_context;
    // The camera we render with
    Camera *_camera;
}

/*!
 * @brief Initializes the renderer and keeps track of the GL context
 * @author Jason Chung
 *
 * @param view The GLKView holding the context
 *
 * @return An id to the created instance
 */
- (id)initWithView:(GLKView *)view;

/*!
 * Returns the OpenGL context.
 * @author Jason Chung
 *
 * @return The OpenGL context.
 */
- (EAGLContext *)context;
/*!
 * Returns the current Camera.
 * @author Jason Chung
 *
 * @return The current Camera.
 */
- (Camera *)camera;

/*!
 * Sets the OpenGL context.
 * @author Jason Chung
 *
 * @param context The new OpenGL context.
 */
- (void)setContext:(EAGLContext *)context;

/*!
 * Sets the view Camera.
 * @author Jason Chung
 *
 * @param camera The new view Camera.
 */
- (void)setCamera:(Camera *)camera;

/*!
 * Sets up OpenGL states prior to render.
 * @author Jason Chung
 *
 * @param rect The dimensions of the screen. (DOES NOT TAKE INTO ACCOUNT RESOLUTION SCALING)
 */
- (void)setupRender:(CGRect)rect;

/*!
 * Renders a Mesh with the given GLProgram.
 * @author Jason Chung
 *
 * @param mesh The mesh to render.
 * @param program The program to render with.
 */
- (void)renderMesh:(Mesh *)mesh program:(GLProgram *)program;
/*!
 * Renders a sprite at the sprite index.
 * @author Jason Chung
 *
 * @param mesh The mesh to render.
 * @param index The sprite index.
 */
- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index;
/*!
 * Renders a sprite at the sprite index, with fog.
 * @author Jason Chung
 *
 * @param mesh The mesh to render.
 * @param index The sprite index.
 * @param fogColour The colour of the fog.
 * @param textureColour The colour of the texture.
 * @param textureColourAmount The fraction of texture colour to mix.
 */
- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index fogColour:(GLKVector4)fogColour
       textureColour:(GLKVector4)textureColour textureColourAmount:(float)textureColourAmount;
/*!
 * Renders a Mesh with the given GLProgram, with fog.
 * @author Jason Chung
 *
 * @param mesh The mesh to render.
 * @param program The program to render with.
 * @param fogColour The colour of the fog.
 */
- (void)renderWithFog:(Mesh *)mesh program:(GLProgram *)program fogColour:(GLKVector4)fogColour;

@end

NS_ASSUME_NONNULL_END
