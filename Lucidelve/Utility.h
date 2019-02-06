//
//  Utility.h
//  Lucidelve
//
//  Created by Choy on 2019-02-05.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A generic Singleton class containing
 * generic functions.
 */
@interface Utility : NSObject

/*!
 * Returns a static instance of the Utility
 * Singleton class.
 * @author Jason Chung
 *
 * @return A reference to the Objective-C object for
 * this class.
 */
+ (id)getInstance;

/*!
 * Given a file path, it will return a reference
 * to a byte-array of the resource.
 * @author Jason Chung
 *
 * @param filePath An absolute path to the resource.
 * @param errorPtr A reference to an error if the resource does not exist at the specified file path.
 * @return A reference to a byte-array of the resource.
 */
- (NSData *)loadResource:(NSString *)filePath error:(NSError **)errorPtr;

@end

NS_ASSUME_NONNULL_END
