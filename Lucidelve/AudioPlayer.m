//
//  AudioPlayer.m
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "AudioPlayer.h"
#import "Utility.h"

NSString *KEY_SOUND_BLOCK = @"block";
NSString *KEY_SOUND_BOMB = @"bomb";
NSString *KEY_SOUND_BUY = @"buy";
NSString *KEY_SOUND_COMBAT_WIN = @"combat_win";
NSString *KEY_SOUND_DEAD = @"dead";
NSString *KEY_SOUND_DODGE = @"dodge";
NSString *KEY_SOUND_ENEMY_HURT = @"enemy_hurt";
NSString *KEY_SOUND_GOLD = @"gold";
NSString *KEY_SOUND_HEALING_POTION = @"healing_potion";
NSString *KEY_SOUND_PLAYER_HURT = @"player_hurt";
static AudioPlayer *INSTANCE = nil;

@interface AudioPlayer() {
	// A Dictionary of preloaded audio files
    NSMutableDictionary<NSString *, NSData *> *audioFiles;
	// An array of currently playing sound sources
    NSMutableArray<AVAudioPlayer *> *soundSources;
}

@end

@implementation AudioPlayer

+ (id)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[self alloc] init];
    });
    return INSTANCE;
}

- (id)init {
    if (self = [super init]) {
        // Instantiate variables here if needed
        audioFiles = [NSMutableDictionary dictionary];
        soundSources = [NSMutableArray array];
    }
    return self;
}

- (void)addAudioFile:(NSString *)filename key:(NSString *)key {
    NSString *filePath = [[Utility getInstance] getFilepath:filename.UTF8String fileType:"sfx"];
    NSData *audioFile = [[Utility getInstance] loadResource:filePath];
    [audioFiles setValue:audioFile forKey:key];
}

- (void)play:(NSString *)key {
    if ([audioFiles objectForKey:key]) {
        NSError *error;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:[audioFiles objectForKey:key] error:&error];
        player.delegate = self;
        [soundSources addObject:player];
        [player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [soundSources removeObject:player];
    }
}

@end
