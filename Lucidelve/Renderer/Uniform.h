//
//  Uniform.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A uniform located on the GL program
 */
@interface Uniform : NSObject {
    // The name of the uniform
    NSString *_name;
    // The location of the uniform on the GPU
    GLuint _uniformId;
}

/*!
 * @brief Initializes the instance with a name and location
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param uniformId The location of the uniform
 *
 * @return An id to the created instance
 */
- (id)initWithName:(NSString *)name uniformId:(GLuint)uniformId;

/*!
 * Returns the name of the Uniform.
 * @author Jason Chung
 *
 * @return The name of the Uniform.
 */
- (NSString *)name;
/*!
 * Returns the id of the Uniform.
 * @author Jason Chung
 *
 * @return The id of the Uniform.
 */
- (GLuint)uniformId;

@end

NS_ASSUME_NONNULL_END
