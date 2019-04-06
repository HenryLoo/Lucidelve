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
NSString *KEY_SOUND_PLAYER_BLOCK = @"player_block";
NSString *KEY_SOUND_PLAYER_HURT = @"player_hurt";
NSString *KEY_SOUND_PLAYER_DEAD = @"player_dead";
NSString *KEY_SOUND_DODGE = @"dodge";
NSString *KEY_SOUND_GOLD = @"gold";
NSString *KEY_SOUND_HEALING_POTION = @"healing_potion";
NSString *KEY_SOUND_BLACKSMITH_UPGRADE = @"blacksmith_upgrade";
NSString *KEY_SOUND_GOOSE_UPGRADE = @"goose_upgrade";
NSString *KEY_SOUND_SELECT = @"select";
NSString *KEY_SOUND_ITEM_EQUIP = @"item_equip";
NSString *KEY_SOUND_ITEM_UNEQUIP = @"item_unequip";
NSString *KEY_SOUND_DUNGEON_ENTER = @"dungeon_enter";
NSString *KEY_SOUND_ENEMY_BLOCK = @"enemy_block";
NSString *KEY_SOUND_ENEMY_HURT = @"enemy_hurt";
NSString *KEY_SOUND_ENEMY_STUN_HURT = @"enemy_stun_hurt";
NSString *KEY_SOUND_ENEMY_DEAD = @"enemy_dead";

NSString *KEY_BGM_HUB = @"hub";
NSString *KEY_BGM_FOREST = @"forest";
NSString *KEY_BGM_CAVES = @"caves";
NSString *KEY_BGM_DEPTHS = @"depths";

static AudioPlayer *INSTANCE = nil;

@interface AudioPlayer() {
	// A Dictionary of preloaded audio files
    NSMutableDictionary<NSString *, NSData *> *audioFiles;
	// An array of currently playing sound sources
    NSMutableArray<AVAudioPlayer *> *soundSources;
    AVAudioPlayer *musicSource;
    
    // The key of the music being played
    NSString *currentMusic;
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

- (void)addSoundFile:(NSString *)filename key:(NSString *)key {
    [self addAudioFile:filename key:key type:@"sfx"];
}

- (void)addMusicFile:(NSString *)filename key:(NSString *)key {
    [self addAudioFile:filename key:key type:@"bgm"];
}

- (void)addAudioFile:(NSString *)filename key:(NSString *)key type:(NSString *)type {
    NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:type];
    NSData *audioFile = [[Utility getInstance] loadResource:filePath];
    [audioFiles setValue:audioFile forKey:key];
}

- (void)play:(NSString *)key {
    [self play:key loop:false isMusic:false];
}

- (void)playMusic:(NSString *)key
{
    // Already playing this music, so don't restart it
    if (currentMusic == key) return;
    
    currentMusic = key;
    [self play:key loop:true isMusic:true];
    musicSource.volume = 0.05;
}

- (void)play:(NSString *)key loop:(bool)loop isMusic:(bool)isMusic {
    if ([audioFiles objectForKey:key]) {
        NSError *error;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:[audioFiles objectForKey:key] error:&error];
        player.delegate = self;
        if (loop)
            player.numberOfLoops = -1;
        
        if (isMusic) musicSource = player;
        else [soundSources addObject:player];
        
        [player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [soundSources removeObject:player];
    }
}

@end
