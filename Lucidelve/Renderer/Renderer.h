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

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A renderer capable of rendering meshes
 */
@interface Renderer : NSObject

// A reference to the GL context
@property (strong, nonatomic) EAGLContext *_context;
// The camera we render with
@property (strong, nonatomic) Camera *_camera;
// An array of meshes to render
@property (strong, nonatomic) NSMutableArray<Mesh *> *_meshes;

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
 * @brief Updates the renderer
 * @author Jason Chung
 *
 * @param deltaTime The change in time
 */
- (void)update:(float)deltaTime;
/*!
 * @brief Updates the renderer
 * @author Jason Chung
 *
 * @param deltaTime The change in time
 * @param rect The rect bounds
 */
- (void)render:(float)deltaTime drawInRect:(CGRect)rect;
/*!
 * @brief Cleans up the renderer and its objects
 * @author Jason Chung
 */
- (void)cleanUp;
/*!
 * @brief Sets the mesh array
 * @author Jason Chung
 *
 * @param meshes A new list of meshes
 */
- (void)setMeshes:(NSMutableArray<Mesh *> *)meshes;
/*!
 * @brief Adds a mesh to the mesh array
 * @author Jason Chung
 *
 * @param mesh The new mesh to add
 */
- (void)addMesh:(Mesh *)mesh;

@end

NS_ASSUME_NONNULL_END
