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
extern NSString *KEY_PROGRAM_SPRITE;
extern NSString *KEY_PROGRAM_DUNGEON;

/* Texture keys */
extern NSString *KEY_TEXTURE_CRATE;
extern NSString *KEY_TEXTURE_PLACEHOLDER_BLACKSMITH;
extern NSString *KEY_TEXTURE_PLACEHOLDER_DUNGEONS;
extern NSString *KEY_TEXTURE_PLACEHOLDER_GOOSE;
extern NSString *KEY_TEXTURE_PLACEHOLDER_HUB;
extern NSString *KEY_TEXTURE_PLACEHOLDER_SHOP;
extern NSString *KEY_TEXTURE_BLACKSMITH_BG;
extern NSString *KEY_TEXTURE_GOOSE_BG;
extern NSString *KEY_TEXTURE_HUB_BG;
extern NSString *KEY_TEXTURE_SHOP_BG;
extern NSString *KEY_TEXTURE_ANVIL;
extern NSString *KEY_TEXTURE_BACKPACK;
extern NSString *KEY_TEXTURE_BOMB;
extern NSString *KEY_TEXTURE_COIN;
extern NSString *KEY_TEXTURE_DOOR;
extern NSString *KEY_TEXTURE_GOLDEN_GOOSE;
extern NSString *KEY_TEXTURE_HEART;
extern NSString *KEY_TEXTURE_MONEY;
extern NSString *KEY_TEXTURE_NEST;
extern NSString *KEY_TEXTURE_POTION;
extern NSString *KEY_TEXTURE_SHIELD;
extern NSString *KEY_TEXTURE_SWORD;
extern NSString *KEY_TEXTURE_PLAYER_HUB;
extern NSString *KEY_TEXTURE_PLAYER_COMBAT;
extern NSString *KEY_TEXTURE_WOLF;
extern NSString *KEY_TEXTURE_GOBLIN;
extern NSString *KEY_TEXTURE_GOLEM;
extern NSString *KEY_TEXTURE_BAT;
extern NSString *KEY_TEXTURE_TURTLE;
extern NSString *KEY_TEXTURE_FOX;
extern NSString *KEY_TEXTURE_FOREST_FLOOR;
extern NSString *KEY_TEXTURE_FOREST_WALL;
extern NSString *KEY_TEXTURE_CAVES_FLOOR;
extern NSString *KEY_TEXTURE_CAVES_WALL;
extern NSString *KEY_TEXTURE_DEPTHS_FLOOR;
extern NSString *KEY_TEXTURE_DEPTHS_WALL;

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
 * Loads all shaders
 * @author Jason Chung
 */
- (void)loadShaders;

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
