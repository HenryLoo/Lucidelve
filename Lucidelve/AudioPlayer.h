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

extern NSString *KEY_SOUND_BLOCK;
extern NSString *KEY_SOUND_BOMB;
extern NSString *KEY_SOUND_BUY;
extern NSString *KEY_SOUND_COMBAT_WIN;
extern NSString *KEY_SOUND_DEAD;
extern NSString *KEY_SOUND_DODGE;
extern NSString *KEY_SOUND_ENEMY_HURT;
extern NSString *KEY_SOUND_GOLD;
extern NSString *KEY_SOUND_HEALING_POTION;
extern NSString *KEY_SOUND_PLAYER_HURT;
extern NSString *KEY_SOUND_BLACKSMITH_UPGRADE;
extern NSString *KEY_SOUND_GOOSE_UPGRADE;
extern NSString *KEY_SOUND_SELECT;
extern NSString *KEY_SOUND_ITEM_EQUIP;
extern NSString *KEY_SOUND_ITEM_UNEQUIP;
extern NSString *KEY_SOUND_DUNGEON_ENTER;

@end

NS_ASSUME_NONNULL_END
