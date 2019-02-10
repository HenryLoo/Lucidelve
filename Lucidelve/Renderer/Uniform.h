//
//  Uniform.h
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A simple Uniform class used by the
 * GLProgram class.
 */
@interface Uniform : NSObject {
    // The name of the Uniform
    const NSString *_name;
    // The location of the Uniform
    GLint _location;
}

/*!
 * Returns the name of the Uniform
 * @author Jason Chung
 *
 * @return The name of the Uniform
 */
- (const NSString *)getName;

/*!
 * Returns the location of the Uniform
 * @author Jason Chung
 *
 * @return The location of the Uniform
 */
- (GLint)getLocation;

/*!
 * Sets the name of the Uniform
 * @author Jason Chung
 *
 * @param name The new name of the Uniform
 */
- (void)setName:(NSString *)name;

/*!
 * Sets the location of the Uniform
 * @author Jason Chung
 *
 * @param location The new location of the Uniform
 */
- (void)setLocation:(GLint)location;

@end

NS_ASSUME_NONNULL_END
