//
//  Texture.h
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A texture instance
 */
@interface Texture : NSObject

// The reference to the texture on the GPU
@property (nonatomic) GLuint _id;
// The type of texture
@property const char *_type;

// Dimensions of the texture
@property size_t width;
@property size_t height;

/*!
 * @brief Initializes the texture with a filename with the default texture_diffuse type
 * @author Jason Chung
 *
 * @param filename The filename of the texture
 *
 * @return An id to the created instance
 */
- (id)initWithFilename:(const char *)filename;
/*!
 * @brief Initializes the texture with a filename
 * @author Jason Chung
 *
 * @param filename The filename of the texture
 * @param type The type of texture (texture_diffuse, texture_normal, texture_specular, texture_height)
 *
 * @return An id to the created instance
 */
- (id)initWithFilename:(const char *)filename type:(const char *)type;
/*!
 * @brief Cleans up the texture
 * @author Jason Chung
 */
- (void)cleanUp;

@end

NS_ASSUME_NONNULL_END
