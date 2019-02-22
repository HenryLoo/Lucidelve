//
//  Uniform.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A uniform located on the GL program
 */
@interface Uniform : NSObject

// The name of the uniform
@property const char *_name;
// The location of the uniform on the GPU
@property unsigned int _location;

/*!
 * @brief Initializes the instance with a name and location
 * @author Jason Chung
 *
 * @param name The name of the uniform
 * @param location The location of the uniform
 *
 * @return An id to the created instance
 */
- (id)initWithName:(const char *)name location:(unsigned int)location;

@end

NS_ASSUME_NONNULL_END
