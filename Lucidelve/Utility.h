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
 * @return A reference to a byte-array of the resource.
 */
- (NSData *)loadResource:(NSString *)filePath;

/*!
 * Given a byte-array of JSON data, it will return a reference
 * to a NSDictionary of the contents for the JSON file.
 * @author Jason Chung
 *
 * @param jsonData A byte-array of the JSON data
 * @return A reference to a NSDictionary
 */
- (NSDictionary *)decodeJSON:(NSData *)jsonData;

/*!
 * @brief Outputs a string to the console, we can do more stuff with the log
 * information in the future.
 * @author Jason Chung
 *
 * @param str The string to output
 */
- (void)log:(const char *)str;

/*!
 * @brief Gets an absolute path to a file.
 * @author Jason Chung
 *
 * @param filename The name of the file
 * @param fileType The directory for the Assets
 *
 * @return A string containing the absolute filepath or nil
 */
- (NSString *)getFilepath:(const char *)filename fileType:(const char *)fileType;
/*!
 * @brief Gets an absolute path to a file.
 * @author Jason Chung
 *
 * @param filename The name of the file
 * @param fileType The directory for the Assets
 * @param bundle If not the main bundle, specify it here
 *
 * @return A string containing the absolute filepath or nil
 */
- (NSString *)getFilepath:(const char *)filename fileType:(const char *)fileType bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
