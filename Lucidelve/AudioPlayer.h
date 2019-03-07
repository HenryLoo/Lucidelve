//
//  AudioPlayer.h
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A generic Singleton class containing
 * generic functions.
 */
@interface AudioPlayer : NSObject

/*!
 * Returns a static instance of the AudioPlayer
 * Singleton class.
 * @author Jason Chung
 *
 * @return A reference to the Objective-C object for
 * this class.
 */
+ (id)getInstance;

- (void)addAudioFile:(NSString *)filename key:(NSString *)key;
- (void)play:(NSString *)key;

extern NSString *KEY_SERVICE_BELL;

@end

NS_ASSUME_NONNULL_END
