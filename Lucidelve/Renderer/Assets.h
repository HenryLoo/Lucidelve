//
//  Assets.h
//  Lucidelve
//
//  Created by Choy on 2019-03-23.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GLProgram.h"
#import "Texture.h"
#import "Mesh.h"

NS_ASSUME_NONNULL_BEGIN

/*  GL Program keys */
extern NSString *KEY_PROGRAM_BASIC;
extern NSString *KEY_PROGRAM_PASSTHROUGH;

/* Texture keys */
extern NSString *KEY_TEXTURE_CRATE;
extern NSString *KEY_TEXTURE_PLACEHOLDER_BLACKSMITH;
extern NSString *KEY_TEXTURE_PLACEHOLDER_DUNGEONS;
extern NSString *KEY_TEXTURE_PLACEHOLDER_GOOSE;
extern NSString *KEY_TEXTURE_PLACEHOLDER_HUB;
extern NSString *KEY_TEXTURE_PLACEHOLDER_SHOP;

/* Mesh keys */
extern NSString *KEY_MESH_ANVIL;
extern NSString *KEY_MESH_BACKPACK;
extern NSString *KEY_MESH_BOMB;
extern NSString *KEY_MESH_COIN;
extern NSString *KEY_MESH_DOOR;
extern NSString *KEY_MESH_GOLDEN_GOOSE;
extern NSString *KEY_MESH_HAMMER;
extern NSString *KEY_MESH_HEART;
extern NSString *KEY_MESH_MONEY;
extern NSString *KEY_MESH_NEST;
extern NSString *KEY_MESH_POTION;
extern NSString *KEY_MESH_SHIELD;
extern NSString *KEY_MESH_SWORD;
extern NSString *KEY_MESH_CUBE;

/*!
 * @brief A Singleton class containing all preloaded OpenGL Assets
 */
@interface Assets : NSObject

/*!
 * Returns a static instance of the Assets
 * Singleton class.
 * @author Jason Chung
 *
 * @return A reference to the Objective-C object for
 * this class.
 */
+ (id)getInstance;

/*!
 * Loads all resources
 * @author Jason Chung
 */
- (void)loadResources;

/*!
 * Returns a GLProgram if it exists at the specified key.
 * @author Jason Chung
 *
 * @param key The key to the program
 * @return A pointer to the GLProgram
 */
- (GLProgram *)getProgram:(NSString *)key;

/*!
 * Returns a Texture if it exists at the specified key.
 * @author Jason Chung
 *
 * @param key The key to the Texture
 * @return A pointer to the Texture
 */
- (Texture *)getTexture:(NSString *)key;

/*!
 * Returns a Mesh if it exists at the specified key.
 * @author Jason Chung
 *
 * @param key The key to the Mesh
 * @return A pointer to the Mesh
 */
- (Mesh *)getMesh:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
