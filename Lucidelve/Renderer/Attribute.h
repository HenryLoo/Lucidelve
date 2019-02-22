//
//  Attribute.h
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief An attribute used by the GLSL program.
 */
@interface Attribute : NSObject

// The name of the attribute
@property (nonatomic) const char *_name;
// The location of the attribute
@property (nonatomic) unsigned int _index;

/*!
 * Initializes the instance with a name and location.
 * @author Jason Chung
 *
 * @param name The name of the attribute
 * @param index The location of the attribute
 *
 * @return An id to the created instance
 */
- (id)initWithName:(const char *)name index:(unsigned int)index;

@end

NS_ASSUME_NONNULL_END
