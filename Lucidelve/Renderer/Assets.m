//
//  Assets.m
//  Lucidelve
//
//  Created by Choy on 2019-03-23.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Assets.h"

NSString *KEY_PROGRAM_BASIC = @"basic";
NSString *KEY_PROGRAM_PASSTHROUGH = @"passthrough";
NSString *KEY_PROGRAM_SPRITE = @"sprite";
NSString *KEY_PROGRAM_DUNGEON = @"dungeon";

NSString *KEY_TEXTURE_CRATE = @"crate";
NSString *KEY_TEXTURE_PLACEHOLDER_BLACKSMITH = @"placeholder_blacksmith";
NSString *KEY_TEXTURE_PLACEHOLDER_DUNGEONS = @"placeholder_dungeons";
NSString *KEY_TEXTURE_PLACEHOLDER_GOOSE = @"placeholder_goose";
NSString *KEY_TEXTURE_PLACEHOLDER_HUB = @"placeholder_hub";
NSString *KEY_TEXTURE_PLACEHOLDER_SHOP = @"placeholder_shop";
NSString *KEY_TEXTURE_ANVIL = @"anvil";
NSString *KEY_TEXTURE_BACKPACK = @"backpack";
NSString *KEY_TEXTURE_BOMB = @"bomb";
NSString *KEY_TEXTURE_COIN = @"coin";
NSString *KEY_TEXTURE_DOOR = @"door";
NSString *KEY_TEXTURE_GOLDEN_GOOSE = @"golden_goose";
NSString *KEY_TEXTURE_HEART = @"heart";
NSString *KEY_TEXTURE_MONEY = @"money";
NSString *KEY_TEXTURE_NEST = @"nest";
NSString *KEY_TEXTURE_POTION = @"potion";
NSString *KEY_TEXTURE_SHIELD = @"shield";
NSString *KEY_TEXTURE_SWORD = @"sword";
NSString *KEY_TEXTURE_PLAYER = @"player";
NSString *KEY_TEXTURE_WOLF = @"wolf";
NSString *KEY_TEXTURE_GOBLIN = @"goblin";
NSString *KEY_TEXTURE_GOLEM = @"golem";
NSString *KEY_TEXTURE_BAT = @"bat";
NSString *KEY_TEXTURE_TURTLE = @"turtle";
NSString *KEY_TEXTURE_FOX = @"fox";
NSString *KEY_TEXTURE_FOREST_FLOOR = @"forest_floor";
NSString *KEY_TEXTURE_FOREST_WALL = @"forest_wall";
NSString *KEY_TEXTURE_CAVES_FLOOR = @"caves_floor";
NSString *KEY_TEXTURE_CAVES_WALL = @"caves_wall";
NSString *KEY_TEXTURE_DEPTHS_FLOOR = @"depths_floor";
NSString *KEY_TEXTURE_DEPTHS_WALL = @"depths_wall";

NSString *KEY_MESH_ANVIL = @"anvil";
NSString *KEY_MESH_CUBE = @"cube";
NSString *KEY_MESH_BACKPACK = @"backpack";
NSString *KEY_MESH_BOMB = @"bomb";
NSString *KEY_MESH_COIN = @"coin";
NSString *KEY_MESH_DOOR = @"door";
NSString *KEY_MESH_GOLDEN_GOOSE = @"golden_goose";
NSString *KEY_MESH_HAMMER = @"hammer";
NSString *KEY_MESH_HEART = @"heart";
NSString *KEY_MESH_MONEY = @"money";
NSString *KEY_MESH_NEST = @"nest";
NSString *KEY_MESH_POTION = @"potion";
NSString *KEY_MESH_SHIELD = @"shield";
NSString *KEY_MESH_SWORD = @"sword";

@interface Assets() {
    NSMutableDictionary<NSString *, GLProgram *> *programs;
    NSMutableDictionary<NSString *, Texture *> *textures;
    NSMutableDictionary<NSString *, Mesh *> *meshes;
}
@end

@implementation Assets

+ (id)getInstance {
    static Assets *INSTANCE = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[self alloc] init];
    });
    return INSTANCE;
}

- (id)init {
    if (self = [super init]) {
        // Instantiate variables here if needed
        programs = [NSMutableDictionary dictionary];
        textures = [NSMutableDictionary dictionary];
        meshes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadResources {
    [self cleanUp];
    
    [self loadShaders];
    [self loadTextures];
    [self loadMeshes];
}

- (void)cleanUp {
    [programs removeAllObjects];
    [textures removeAllObjects];
    [meshes removeAllObjects];
}

- (void)loadShaders {
    NSMutableArray<Shader *> *shaders = [[NSMutableArray<Shader *> alloc] init];
    NSMutableArray<Attribute *> *attributes = [[NSMutableArray<Attribute *> alloc] init];
    
    Shader *vertexShader = [[Shader alloc] initWithFilename:"basic.vsh" shaderType:GL_VERTEX_SHADER];
    Shader *fragmentShader = [[Shader alloc] initWithFilename:"basic.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    Attribute *position = [[Attribute alloc] initWithName:"aPos" index:GLKVertexAttribPosition];
    Attribute *normal = [[Attribute alloc] initWithName:"aNormal" index:GLKVertexAttribNormal];
    Attribute *texCoordIn = [[Attribute alloc] initWithName:"aTexCoords" index:GLKVertexAttribTexCoord0];
    [attributes addObject:position];
    [attributes addObject:normal];
    [attributes addObject:texCoordIn];
    GLProgram *basicProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:basicProgram forKey:KEY_PROGRAM_BASIC];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:"passthrough.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:"passthrough.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *passthroughProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:passthroughProgram forKey:KEY_PROGRAM_PASSTHROUGH];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:"sprite.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:"fog.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *spriteProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:spriteProgram forKey:KEY_PROGRAM_SPRITE];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:"passthrough.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:"fog.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *dungeonProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:dungeonProgram forKey:KEY_PROGRAM_DUNGEON];
}

- (void)loadTextures {
    Texture *texture = [[Texture alloc] initWithFilename:"crate.jpg"];
    [textures setObject:texture forKey:KEY_TEXTURE_CRATE];
    texture = [[Texture alloc] initWithFilename:"placeholder_blacksmith.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_BLACKSMITH];
    texture = [[Texture alloc] initWithFilename:"placeholder_dungeons.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_DUNGEONS];
    texture = [[Texture alloc] initWithFilename:"placeholder_goose.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_GOOSE];
    texture = [[Texture alloc] initWithFilename:"placeholder_hub.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_HUB];
    texture = [[Texture alloc] initWithFilename:"placeholder_shop.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_SHOP];
    texture = [[Texture alloc] initWithFilename:"anvil.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_ANVIL];
    texture = [[Texture alloc] initWithFilename:"backpack.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BACKPACK];
    texture = [[Texture alloc] initWithFilename:"bomb.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BOMB];
    texture = [[Texture alloc] initWithFilename:"coin.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_COIN];
    texture = [[Texture alloc] initWithFilename:"door.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DOOR];
    texture = [[Texture alloc] initWithFilename:"golden_goose.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOLDEN_GOOSE];
    texture = [[Texture alloc] initWithFilename:"heart.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_HEART];
    texture = [[Texture alloc] initWithFilename:"money.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_MONEY];
    texture = [[Texture alloc] initWithFilename:"nest.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_NEST];
    texture = [[Texture alloc] initWithFilename:"potion.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_POTION];
    texture = [[Texture alloc] initWithFilename:"shield.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_SHIELD];
    texture = [[Texture alloc] initWithFilename:"sword.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_SWORD];
    texture = [[Texture alloc] initWithFilename:"player.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLAYER];
    texture = [[Texture alloc] initWithFilename:"wolf.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_WOLF];
    texture = [[Texture alloc] initWithFilename:"goblin.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOBLIN];
    texture = [[Texture alloc] initWithFilename:"golem.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOLEM];
    texture = [[Texture alloc] initWithFilename:"bat.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BAT];
    texture = [[Texture alloc] initWithFilename:"turtle.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_TURTLE];
    texture = [[Texture alloc] initWithFilename:"fox.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOX];
    texture = [[Texture alloc] initWithFilename:"forest_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOREST_FLOOR];
    texture = [[Texture alloc] initWithFilename:"forest_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOREST_WALL];
    texture = [[Texture alloc] initWithFilename:"caves_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_CAVES_FLOOR];
    texture = [[Texture alloc] initWithFilename:"caves_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_CAVES_WALL];
    texture = [[Texture alloc] initWithFilename:"depths_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DEPTHS_FLOOR];
    texture = [[Texture alloc] initWithFilename:"depths_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DEPTHS_WALL];
}

- (void)loadMeshes {
    Mesh *mesh = [[Mesh alloc] initWithFilename:"anvil.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_ANVIL];
    mesh = [[Mesh alloc] initWithFilename:"cube.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_CUBE];
    mesh = [[Mesh alloc] initWithFilename:"backpack.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_BACKPACK];
    mesh = [[Mesh alloc] initWithFilename:"bomb.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_BOMB];
    mesh = [[Mesh alloc] initWithFilename:"coin.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_COIN];
    mesh = [[Mesh alloc] initWithFilename:"door.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_DOOR];
    mesh = [[Mesh alloc] initWithFilename:"golden_goose.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_GOLDEN_GOOSE];
    mesh = [[Mesh alloc] initWithFilename:"hammer.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_HAMMER];
    mesh = [[Mesh alloc] initWithFilename:"heart.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_HEART];
    mesh = [[Mesh alloc] initWithFilename:"money.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_MONEY];
    mesh = [[Mesh alloc] initWithFilename:"nest.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_NEST];
    mesh = [[Mesh alloc] initWithFilename:"potion.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_POTION];
    mesh = [[Mesh alloc] initWithFilename:"shield.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_SHIELD];
    mesh = [[Mesh alloc] initWithFilename:"sword.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_SWORD];
}

- (GLProgram *)getProgram:(NSString *)key {
    return [programs objectForKey:key];
}

- (Texture *)getTexture:(NSString *)key {
    return [textures objectForKey:key];
}

- (Mesh *)getMesh:(NSString *)key {
    return [[meshes objectForKey:key] copyWithZone:nil];
}

@end
