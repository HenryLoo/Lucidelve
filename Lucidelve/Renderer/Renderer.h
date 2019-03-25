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
@interface Renderer : NSObject

// A reference to the GL context
@property (strong, nonatomic) EAGLContext *context;
// The camera we render with
@property Camera *mainCamera;

/*!
 * @brief Initializes the renderer and keeps track of the GL context
 * @author Jason Chung
 *
 * @param view The GLKView holding the context
 *
 * @return An id to the created instance
 */
- (id)initWithView:(GLKView *)view;

- (void)setCamera:(Camera *)camera;
- (void)setupRender:(CGRect)rect;
- (void)renderMesh:(Mesh *)mesh program:(GLProgram *)program;
- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index;
- (void)renderSprite:(Mesh *)mesh spriteIndex:(int)index fogColour:(GLKVector4)fogColour;
- (void)renderWithFog:(Mesh *)mesh program:(GLProgram *)program fogColour:(GLKVector4)fogColour;

@end

NS_ASSUME_NONNULL_END
