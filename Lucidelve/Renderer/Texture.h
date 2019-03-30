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
@interface Texture : NSObject {
    // The reference to the texture on the GPU
    GLuint _textureId;
    // The type of texture
    NSString *_type;
    
    // Dimensions of the texture
    size_t _width;
    size_t _height;
}

/*!
 * @brief Initializes the texture with a filename with the default texture_diffuse type
 * @author Jason Chung
 *
 * @param filename The filename of the texture
 *
 * @return An id to the created instance
 */
- (id)initWithFilename:(NSString *)filename;
/*!
 * @brief Initializes the texture with a filename
 * @author Jason Chung
 *
 * @param filename The filename of the texture
 * @param type The type of texture (texture_diffuse, texture_normal, texture_specular, texture_height)
 *
 * @return An id to the created instance
 */
- (id)initWithFilename:(NSString *)filename type:(NSString *)type;
/*!
 * @brief Cleans up the texture
 * @author Jason Chung
 */
- (void)cleanUp;

/*!
 * Returns the id of the Texture.
 * @author Jason Chung
 *
 * @return The id of the Texture.
 */
- (GLuint)textureId;
/*!
 * Returns the type of the Texture.
 * @author Jason Chung
 *
 * @return The type of the Texture.
 */
- (NSString *)type;
/*!
 * Returns the width of the Texture.
 * @author Jason Chung
 *
 * @return The width of the Texture.
 */
- (size_t)width;
/*!
 * Returns the height of the Texture.
 * @author Jason Chung
 *
 * @return The height of the Texture.
 */
- (size_t)height;

@end

NS_ASSUME_NONNULL_END
