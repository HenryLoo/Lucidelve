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
 * Stops all playing sound sources.
 * @author Jason Chung
 */
- (void)stopAllSounds;

/*!
 * Finds an audio file from the given path and adds it to the array of
 * loaded audio files that can be played.
 * @author Jason Chung
 *
 * @param filename The absolute path to the file
 * @param key The key to access the audio file after loading
 */
- (void)addSoundFile:(NSString *)filename key:(NSString *)key;
- (void)addMusicFile:(NSString *)filename key:(NSString *)key;


/*!
 * Plays a sound from the array of loaded audio files.
 * @author Jason Chung
 *
 * @param key The key of the preloaded audio file
 */
- (void)play:(NSString *)key;
- (void)playMusic:(NSString *)key;

/*!
 * Stop playing the current music.
 * @author Henry Loo
 */
- (void)stopMusic;

/*!
 * Plays a sound from the array of loaded audio files.
 * @author Jason Chung
 *
 * @param key The key of the preloaded audio file
 * @param loop True to loop the audio file and false otherwise
 */
- (void)play:(NSString *)key loop:(bool)loop isMusic:(bool)isMusic ;

extern NSString *KEY_SOUND_BLOCK;
extern NSString *KEY_SOUND_BOMB;
extern NSString *KEY_SOUND_BUY;
extern NSString *KEY_SOUND_COMBAT_WIN;
extern NSString *KEY_SOUND_PLAYER_BLOCK;
extern NSString *KEY_SOUND_PLAYER_HURT;
extern NSString *KEY_SOUND_PLAYER_DEAD;
extern NSString *KEY_SOUND_DODGE;
extern NSString *KEY_SOUND_GOLD;
extern NSString *KEY_SOUND_HEALING_POTION;
extern NSString *KEY_SOUND_BLACKSMITH_UPGRADE;
extern NSString *KEY_SOUND_GOOSE_UPGRADE;
extern NSString *KEY_SOUND_SELECT;
extern NSString *KEY_SOUND_ITEM_EQUIP;
extern NSString *KEY_SOUND_ITEM_UNEQUIP;
extern NSString *KEY_SOUND_DUNGEON_ENTER;
extern NSString *KEY_SOUND_ENEMY_BLOCK;
extern NSString *KEY_SOUND_ENEMY_HURT;
extern NSString *KEY_SOUND_ENEMY_STUN_HURT;
extern NSString *KEY_SOUND_ENEMY_DEAD;
extern NSString *KEY_SOUND_GAME_CLEAR;

extern NSString *KEY_BGM_HUB;
extern NSString *KEY_BGM_FOREST;
extern NSString *KEY_BGM_CAVES;
extern NSString *KEY_BGM_DEPTHS;
extern NSString *KEY_BGM_RUINS;

@end

NS_ASSUME_NONNULL_END
