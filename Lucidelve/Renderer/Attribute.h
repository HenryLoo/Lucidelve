//
//  Attribute.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief An attribute used by the GLSL program.
 */
@interface Attribute : NSObject {
    // The name of the attribute
    NSString *_name;
    // The location of the attribute
    GLuint _attributeId;
}

/*!
 * Initializes the instance with a name and location.
 * @author Jason Chung
 *
 * @param name The name of the attribute
 * @param attributeId The location of the attribute
 *
 * @return An id to the created instance
 */
- (id)initWithName:(NSString *)name attributeId:(GLuint)attributeId;

/*!
 * Returns the name of the Attribute.
 * @author Jason Chung
 *
 * @return The name of the Attribute.
 */
- (NSString *)name;
/*!
 * Returns the id of the Attribute.
 * @author Jason Chung
 *
 * @return The id of the Attribute.
 */
- (GLuint)attributeId;

@end

NS_ASSUME_NONNULL_END
