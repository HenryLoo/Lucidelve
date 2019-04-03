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
NSString *KEY_SOUND_BLACKSMITH_UPGRADE = @"blacksmith_upgrade";
NSString *KEY_SOUND_GOOSE_UPGRADE = @"goose_upgrade";
NSString *KEY_SOUND_SELECT = @"select";
NSString *KEY_SOUND_ITEM_EQUIP = @"item_equip";
NSString *KEY_SOUND_ITEM_UNEQUIP = @"item_unequip";
NSString *KEY_SOUND_DUNGEON_ENTER = @"dungeon_enter";

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

- (void)stopAllSounds {
    if (soundSources != nil) {
        [soundSources removeAllObjects];
    }
}

- (void)addAudioFile:(NSString *)filename key:(NSString *)key {
    NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:@"sfx"];
    NSData *audioFile = [[Utility getInstance] loadResource:filePath];
    [audioFiles setValue:audioFile forKey:key];
}

- (void)play:(NSString *)key {
    [self play:key loop:false];
}

- (void)play:(NSString *)key loop:(bool)loop {
    if ([audioFiles objectForKey:key]) {
        NSError *error;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:[audioFiles objectForKey:key] error:&error];
        player.delegate = self;
        if (loop)
            player.numberOfLoops = -1;
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
