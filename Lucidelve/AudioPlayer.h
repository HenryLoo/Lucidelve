//
//  AudioPlayer.h
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A generic Singleton class containing
 * generic functions.
 */
@interface AudioPlayer : NSObject<AVAudioPlayerDelegate>

/*!
 * Returns a static instance of the AudioPlayer
 * Singleton class.
 * @author Jason Chung
 *
 * @return A reference to the Objective-C object for
 * this class.
 */
+ (id)getInstance;

/*!
 * Finds an audio file from the given path and adds it to the array of
 * loaded audio files that can be played.
 * @author Jason Chung
 *
 * @param filename The absolute path to the file
 * @param key The key to access the audio file after loading
 */
- (void)addAudioFile:(NSString *)filename key:(NSString *)key;
/*!
 * Plays a sound from the array of loaded audio files.
 * @author Jason Chung
 *
 * @param key The key of the preloaded audio file
 */
- (void)play:(NSString *)key;

extern NSString *KEY_SERVICE_BELL;

@end

NS_ASSUME_NONNULL_END
