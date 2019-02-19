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

@interface Renderer : NSObject

@property (strong, nonatomic) EAGLContext *_context;
@property (strong, nonatomic) Camera *_camera;
@property (strong, nonatomic) NSMutableArray<Mesh *> *_meshes;

- (void)initWithView:(GLKView *)view;
- (void)update:(float)deltaTime;
- (void)render:(float)deltaTime drawInRect:(CGRect)rect;
- (void)cleanUp;
- (void)setMeshes:(NSMutableArray<Mesh *> *)meshes;
- (void)addMesh:(Mesh *)mesh;

@end

NS_ASSUME_NONNULL_END
