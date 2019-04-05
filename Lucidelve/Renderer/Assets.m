//
//  Assets.m
//  Lucidelve
//
//  Created by Choy on 2019-03-23.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Assets.h"
#import "../Utility.h"

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
NSString *KEY_TEXTURE_BLACKSMITH_BG = @"blacksmith_bg";
NSString *KEY_TEXTURE_GOOSE_BG = @"goose_bg";
NSString *KEY_TEXTURE_HUB_BG = @"hub_bg";
NSString *KEY_TEXTURE_SHOP_BG = @"shop_bg";
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
NSString *KEY_TEXTURE_PLAYER_HUB = @"player_hub";
NSString *KEY_TEXTURE_PLAYER_COMBAT = @"player_combat";
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
    [programs removeAllObjects];
    
    NSMutableArray<Shader *> *shaders = [[NSMutableArray<Shader *> alloc] init];
    NSMutableArray<Attribute *> *attributes = [[NSMutableArray<Attribute *> alloc] init];
    
    Shader *vertexShader = [[Shader alloc] initWithFilename:@"basic.vsh" shaderType:GL_VERTEX_SHADER];
    Shader *fragmentShader = [[Shader alloc] initWithFilename:@"basic.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    Attribute *position = [[Attribute alloc] initWithName:@"aPos" attributeId:GLKVertexAttribPosition];
    Attribute *normal = [[Attribute alloc] initWithName:@"aNormal" attributeId:GLKVertexAttribNormal];
    Attribute *texCoordIn = [[Attribute alloc] initWithName:@"aTexCoords" attributeId:GLKVertexAttribTexCoord0];
    [attributes addObject:position];
    [attributes addObject:normal];
    [attributes addObject:texCoordIn];
    GLProgram *basicProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:basicProgram forKey:KEY_PROGRAM_BASIC];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:@"passthrough.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:@"passthrough.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *passthroughProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:passthroughProgram forKey:KEY_PROGRAM_PASSTHROUGH];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:@"sprite.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:@"fog.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *spriteProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:spriteProgram forKey:KEY_PROGRAM_SPRITE];
    
    [shaders removeAllObjects];
    [attributes removeAllObjects];
    
    vertexShader = [[Shader alloc] initWithFilename:@"passthrough.vsh" shaderType:GL_VERTEX_SHADER];
    fragmentShader = [[Shader alloc] initWithFilename:@"fog.fsh" shaderType:GL_FRAGMENT_SHADER];
    [shaders addObject:vertexShader];
    [shaders addObject:fragmentShader];
    [attributes addObject:position];
    [attributes addObject:texCoordIn];
    GLProgram *dungeonProgram = [[GLProgram alloc] initWithShaders:&shaders attributes:&attributes];
    [programs setObject:dungeonProgram forKey:KEY_PROGRAM_DUNGEON];
}

- (void)loadTextures {
    Texture *texture = [[Texture alloc] initWithFilename:@"crate.jpg"];
    [textures setObject:texture forKey:KEY_TEXTURE_CRATE];
    texture = [[Texture alloc] initWithFilename:@"placeholder_blacksmith.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_BLACKSMITH];
    texture = [[Texture alloc] initWithFilename:@"placeholder_dungeons.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_DUNGEONS];
    texture = [[Texture alloc] initWithFilename:@"placeholder_goose.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_GOOSE];
    texture = [[Texture alloc] initWithFilename:@"placeholder_hub.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_HUB];
    texture = [[Texture alloc] initWithFilename:@"placeholder_shop.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLACEHOLDER_SHOP];
    texture = [[Texture alloc] initWithFilename:@"blacksmith_bg.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BLACKSMITH_BG];
    texture = [[Texture alloc] initWithFilename:@"goose_bg.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOOSE_BG];
    texture = [[Texture alloc] initWithFilename:@"hub_bg.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_HUB_BG];
    texture = [[Texture alloc] initWithFilename:@"shop_bg.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_SHOP_BG];
    texture = [[Texture alloc] initWithFilename:@"anvil.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_ANVIL];
    texture = [[Texture alloc] initWithFilename:@"backpack.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BACKPACK];
    texture = [[Texture alloc] initWithFilename:@"bomb.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BOMB];
    texture = [[Texture alloc] initWithFilename:@"coin.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_COIN];
    texture = [[Texture alloc] initWithFilename:@"door.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DOOR];
    texture = [[Texture alloc] initWithFilename:@"golden_goose.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOLDEN_GOOSE];
    texture = [[Texture alloc] initWithFilename:@"heart.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_HEART];
    texture = [[Texture alloc] initWithFilename:@"money.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_MONEY];
    texture = [[Texture alloc] initWithFilename:@"nest.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_NEST];
    texture = [[Texture alloc] initWithFilename:@"potion.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_POTION];
    texture = [[Texture alloc] initWithFilename:@"shield.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_SHIELD];
    texture = [[Texture alloc] initWithFilename:@"sword.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_SWORD];
    texture = [[Texture alloc] initWithFilename:@"player_hub.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLAYER_HUB];
    texture = [[Texture alloc] initWithFilename:@"player_combat.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_PLAYER_COMBAT];
    texture = [[Texture alloc] initWithFilename:@"wolf.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_WOLF];
    texture = [[Texture alloc] initWithFilename:@"goblin.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOBLIN];
    texture = [[Texture alloc] initWithFilename:@"golem.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_GOLEM];
    texture = [[Texture alloc] initWithFilename:@"bat.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_BAT];
    texture = [[Texture alloc] initWithFilename:@"turtle.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_TURTLE];
    texture = [[Texture alloc] initWithFilename:@"fox.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOX];
    texture = [[Texture alloc] initWithFilename:@"forest_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOREST_FLOOR];
    texture = [[Texture alloc] initWithFilename:@"forest_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_FOREST_WALL];
    texture = [[Texture alloc] initWithFilename:@"caves_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_CAVES_FLOOR];
    texture = [[Texture alloc] initWithFilename:@"caves_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_CAVES_WALL];
    texture = [[Texture alloc] initWithFilename:@"depths_floor.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DEPTHS_FLOOR];
    texture = [[Texture alloc] initWithFilename:@"depths_wall.png"];
    [textures setObject:texture forKey:KEY_TEXTURE_DEPTHS_WALL];
}

- (void)loadMeshes {
    Mesh *mesh = [self loadMesh:@"anvil.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_ANVIL];
    mesh = [self loadMesh:@"cube.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_CUBE];
    mesh = [self loadMesh:@"backpack.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_BACKPACK];
    mesh = [self loadMesh:@"bomb.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_BOMB];
    mesh = [self loadMesh:@"coin.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_COIN];
    mesh = [self loadMesh:@"door.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_DOOR];
    mesh = [self loadMesh:@"golden_goose.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_GOLDEN_GOOSE];
    mesh = [self loadMesh:@"hammer.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_HAMMER];
    mesh = [self loadMesh:@"heart.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_HEART];
    mesh = [self loadMesh:@"money.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_MONEY];
    mesh = [self loadMesh:@"nest.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_NEST];
    mesh = [self loadMesh:@"potion.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_POTION];
    mesh = [self loadMesh:@"shield.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_SHIELD];
    mesh = [self loadMesh:@"sword.obj"];
    [meshes setObject:mesh forKey:KEY_MESH_SWORD];
}

- (GLProgram *)getProgram:(NSString *)key {
    return [programs objectForKey:key];
}

- (Texture *)getTexture:(NSString *)key {
    return [textures objectForKey:key];
}

- (Mesh *)getMesh:(NSString *)key {
    return [[meshes objectForKey:key] copy];
}

- (Mesh *)loadMesh:(NSString *)filename {
    [[Utility getInstance] log:[NSString stringWithFormat:@"Loading file: %@", filename]];
    Mesh *mesh = [[Mesh alloc] init];
    
    NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:@"models"];
    NSString *contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    // The final buffers to pass to the Mesh
    NSMutableData *vertices = [NSMutableData data];
    NSMutableData *uvs = [NSMutableData data];
    NSMutableData *normals = [NSMutableData data];
    NSMutableData *indices = [NSMutableData data];
    
    // The indexed points, normals, and uvs
    NSMutableArray<NSValue *> *indexed_vertices = [NSMutableArray array];
    NSMutableArray<NSValue *> *indexed_uvs = [NSMutableArray array];
    NSMutableArray<NSValue *> *indexed_normals = [NSMutableArray array];
    
    // The arrays of vertices with point, normals, and uvs matching to a single point
	NSMutableArray<NSValue *> *out_vertices = [NSMutableArray array];
	NSMutableArray<NSValue *> *out_uvs = [NSMutableArray array];
	NSMutableArray<NSValue *> *out_normals = [NSMutableArray array];
	
    // The array of indices in the OBJ file
	NSMutableArray<NSNumber *> *vertexIndices = [NSMutableArray array];
	NSMutableArray<NSNumber *> *uvIndices = [NSMutableArray array];
	NSMutableArray<NSNumber *> *normalIndices = [NSMutableArray array];
	
    // The points, uvs, and normals in the OBJ file
	NSMutableArray<NSValue *> *temp_vertices = [NSMutableArray array];
	NSMutableArray<NSValue *> *temp_uvs = [NSMutableArray array];
	NSMutableArray<NSValue *> *temp_normals = [NSMutableArray array];
    
	NSScanner *fileScanner = [NSScanner scannerWithString:contents];
	int lineNumber = 0;
	
	NSString *line;
	while ([fileScanner scanUpToString:@"\n" intoString:&line]) {
		lineNumber++;
		
		// remove comments
		line = [[line componentsSeparatedByString:@"#"] objectAtIndex:0];
		
		NSScanner *lineScanner = [NSScanner scannerWithString:line];
		
		NSString *directive;
		
        if (![lineScanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&directive]) {
            continue;
        }
		
		if ([directive isEqualToString:@"v"]) {
			GLKVector3 pt;
			BOOL xyzOK = ([lineScanner scanFloat:&pt.x] &&
						  [lineScanner scanFloat:&pt.y] &&
						  [lineScanner scanFloat:&pt.z]);
						  
			// Ignore the 'w' component
			[lineScanner scanFloat:NULL];
			
			if (!xyzOK || ![lineScanner isAtEnd]) {
				[[Utility getInstance] log:@"The 'v' directive should be followed by 3 numbers."];
				continue;
			}
			
			[temp_vertices addObject:[NSValue value:&pt withObjCType:@encode(GLKVector3)]];
		} else if ([directive isEqualToString:@"vt"]) {
			// Turn any potential texture coordinate into a 2-dimensional one
			GLKVector2 tc;
			if ([lineScanner scanFloat:&tc.x]) {
				if ([lineScanner scanFloat:&tc.y]) {
                    // OpenGL flips the UV coordinate, so we reverse it
                    tc.y = 1 - tc.y;
					if ([lineScanner scanFloat:NULL]) {
						[[Utility getInstance] log:@"This OBJ file has a texture coordinate in 3-dimensions."];
						[temp_uvs addObject:[NSValue value:&tc withObjCType:@encode(GLKVector2)]];
					} else if ([lineScanner isAtEnd]) {
						[temp_uvs addObject:[NSValue value:&tc withObjCType:@encode(GLKVector2)]];
					} else {
						[[Utility getInstance] log:@"The 'vt' directive expects 2 numbers."];
					}
				} else if ([lineScanner isAtEnd]) {
					tc.y = 0;
					[temp_uvs addObject:[NSValue value:&tc withObjCType:@encode(GLKVector2)]];
				} else {
					[[Utility getInstance] log:@"The 'vt' directive expects 2 numbers."];
				}
			} else {
				[[Utility getInstance] log:@"The 'vt' directive expects 2 numbers."];
			}
		} else if ([directive isEqualToString:@"vn"]) {
			GLKVector3 n;
			if (![lineScanner scanFloat:&n.x] ||
				![lineScanner scanFloat:&n.y] ||
				![lineScanner scanFloat:&n.z] ||
				![lineScanner isAtEnd]) {
				[[Utility getInstance] log:@"The 'vn' directive expects 3 numbers."];
				continue;
			}
			[temp_normals addObject:[NSValue value:&n withObjCType:@encode(GLKVector3)]];
		} else if ([directive isEqualToString:@"f"]) {
			NSString *vertexStr;
			while ([lineScanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&vertexStr]) {
				NSScanner *vertexScanner = [NSScanner scannerWithString:vertexStr];
				GLint pointIndex, uvIndex, normalIndex;
				if ([vertexScanner scanInt:&pointIndex]) {
					if ([vertexScanner scanString:@"/" intoString:NULL]) {
						if ([vertexScanner scanInt:&uvIndex]) {
							if ([vertexScanner scanString:@"/" intoString:NULL]) {
								if (![vertexScanner scanInt:&normalIndex]) {
									// Unable to find the normal index
									[[Utility getInstance] log:@"Parse error in vertex."];
									continue;
								}
							} else {
								// Unable to find the normal index
								[[Utility getInstance] log:@"Parse error in vertex."];
								continue;
							}
						} else {
							// Unable to find the texture index
							[[Utility getInstance] log:@"Parse error in vertex."];
							continue;
						}
					} else {
						// There's only a point in this face, no other data
						[[Utility getInstance] log:@"Parse error in vertex."];
						continue;
					}
				} else {
					// We were unable to find a point
					[[Utility getInstance] log:@"Parse error in vertex."];
					continue;
				}
				
				if (![vertexScanner isAtEnd]) {
					[[Utility getInstance] log:@"Parse error in vertex."];
					continue;
				}
				
				[vertexIndices addObject:[NSNumber numberWithUnsignedInt:pointIndex]];
				[uvIndices addObject:[NSNumber numberWithUnsignedInt:uvIndex]];
				[normalIndices addObject:[NSNumber numberWithUnsignedInt:normalIndex]];
			}
		}
	}
	
    for (GLuint i = 0; i < [vertexIndices count]; i++) {
        GLuint vertexIndex = [[vertexIndices objectAtIndex:i] unsignedIntValue];
        GLuint uvIndex = [[uvIndices objectAtIndex:i] unsignedIntValue];
        GLuint normalIndex = [[normalIndices objectAtIndex:i] unsignedIntValue];
        
        GLKVector3 vertex, normal;
        GLKVector2 uv;
        [[temp_vertices objectAtIndex:(vertexIndex - 1)] getValue:&vertex];
        [[temp_uvs objectAtIndex:(uvIndex - 1)] getValue:&uv];
        [[temp_normals objectAtIndex:(normalIndex - 1)] getValue:&normal];
        
        [out_vertices addObject:[NSValue value:&vertex withObjCType:@encode(GLKVector3)]];
        [out_uvs addObject:[NSValue value:&uv withObjCType:@encode(GLKVector2)]];
        [out_normals addObject:[NSValue value:&normal withObjCType:@encode(GLKVector3)]];
    }
    
    NSMutableDictionary<NSValue *, NSNumber *> *VertexToOutIndex = [NSMutableDictionary dictionary];
    for (GLuint i = 0; i < out_vertices.count; i++) {
        Vertex vertex;
        [out_vertices[i] getValue:&vertex.position];
        [out_uvs[i] getValue:&vertex.uv];
        [out_normals[i] getValue:&vertex.normal];
        
        bool found = false;
        NSNumber *indexNumber = [VertexToOutIndex objectForKey:[NSValue value:&vertex withObjCType:@encode(Vertex)]];
        if (indexNumber != nil) {
            found = true;
        }
        if (found) {
            GLuint index = [indexNumber unsignedIntValue];
            [indices appendBytes:&index length:sizeof(GLuint)];
        } else {
            [indexed_vertices addObject:[NSValue value:&vertex.position withObjCType:@encode(GLKVector3)]];
            [indexed_uvs addObject:[NSValue value:&vertex.uv withObjCType:@encode(GLKVector2)]];
            [indexed_normals addObject:[NSValue value:&vertex.normal withObjCType:@encode(GLKVector3)]];
            GLuint index = (GLuint)indexed_vertices.count - 1;
            [indices appendBytes:&index length:sizeof(GLuint)];
        }
    }
    
    for (GLuint i = 0; i < indexed_vertices.count; i++) {
        GLKVector3 value;
        [indexed_vertices[i] getValue:&value];
        [vertices appendBytes:&value length:sizeof(GLKVector3)];
    }
    
    for (GLuint i = 0; i < indexed_uvs.count; i++) {
        GLKVector2 value;
        [indexed_uvs[i] getValue:&value];
        [uvs appendBytes:&value length:sizeof(GLKVector2)];
    }
    
    for (GLuint i = 0; i < indexed_normals.count; i++) {
        GLKVector3 value;
        [indexed_normals[i] getValue:&value];
        [normals appendBytes:&value length:sizeof(GLKVector3)];
    }
    
    [mesh setVertices:vertices];
    [mesh setTextureCoordinates:uvs];
    [mesh setNormals:normals];
    [mesh setIndices:indices];
    
    return mesh;
}

@end
