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

/*!
 * @brief Saves the bool value to user preferences.
 *
 * @param value The value to set
 * @param key The key for the key/value pair
 */
- (void)saveBool:(bool)value key:(NSString *)key;
/*!
 * @brief Saves the float value to user preferences.
 *
 * @param value The value to set
 * @param key The key for the key/value pair
 */
- (void)saveFloat:(float)value key:(NSString *)key;
/*!
 * @brief Saves the int value to user preferences.
 *
 * @param value The value to set
 * @param key The key for the key/value pair
 */
- (void)saveInt:(int)value key:(NSString *)key;
/*!
 * @brief Saves the string value to user preferences.
 *
 * @param value The value to set
 * @param key The key for the key/value pair
 */
- (void)saveString:(NSString *)value key:(NSString *)key;

/*!
 * @brief Returns the value at the specified key
 *
 * @return The value at the specified key
 */
- (bool)getBool:(NSString *)key;
/*!
 * @brief Returns the value at the specified key
 *
 * @return The value at the specified key
 */
- (float)getFloat:(NSString *)key;
/*!
 * @brief Returns the value at the specified key
 *
 * @return The value at the specified key
 */
- (int)getInt:(NSString *)key;
/*!
 * @brief Returns the value at the specified key
 *
 * @return The value at the specified key
 */
- (NSString *)getString:(NSString *)key;

/*!
 * @brief Return a random int between a lower and upper bound.
 * @author Henry Loo
 *
 * @param min The lower bound.
 * @param max The upper bound.
 *
 * @return The random number.
 */
- (int)random:(int)min withMax:(int)max;

@end

NS_ASSUME_NONNULL_END
