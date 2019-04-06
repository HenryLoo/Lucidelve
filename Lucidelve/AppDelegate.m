//
//  AppDelegate.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-01.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "AppDelegate.h"
#import "HubVC.h"
#import "Game.h"
#import "Storage.h"
#import "Constants.h"
#import "AudioPlayer.h"
#import "Renderer/Assets.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Load audio files
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"block.wav"] key:KEY_SOUND_BLOCK];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"bomb.wav"] key:KEY_SOUND_BOMB];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"buy.wav"] key:KEY_SOUND_BUY];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"combat_win.wav"] key:KEY_SOUND_COMBAT_WIN];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"player_block.wav"] key:KEY_SOUND_PLAYER_BLOCK];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"player_hurt.wav"] key:KEY_SOUND_PLAYER_HURT];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"player_dead.wav"] key:KEY_SOUND_PLAYER_DEAD];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"dodge.wav"] key:KEY_SOUND_DODGE];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"gold.wav"] key:KEY_SOUND_GOLD];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"healing_potion.wav"] key:KEY_SOUND_HEALING_POTION];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"blacksmith_upgrade.wav"] key:KEY_SOUND_BLACKSMITH_UPGRADE];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"goose_upgrade.wav"] key:KEY_SOUND_GOOSE_UPGRADE];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"select.wav"] key:KEY_SOUND_SELECT];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"item_equip.wav"] key:KEY_SOUND_ITEM_EQUIP];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"item_unequip.wav"] key:KEY_SOUND_ITEM_UNEQUIP];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"dungeon_enter.wav"] key:KEY_SOUND_DUNGEON_ENTER];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"enemy_block.wav"] key:KEY_SOUND_ENEMY_BLOCK];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"enemy_hurt.wav"] key:KEY_SOUND_ENEMY_HURT];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"enemy_stun_hurt.wav"] key:KEY_SOUND_ENEMY_STUN_HURT];
    [[AudioPlayer getInstance] addSoundFile:[NSString stringWithUTF8String:"enemy_dead.wav"] key:KEY_SOUND_ENEMY_DEAD];
    
    [[AudioPlayer getInstance] addMusicFile:[NSString stringWithUTF8String:"hub.mp3"] key:KEY_BGM_HUB];
    [[AudioPlayer getInstance] addMusicFile:[NSString stringWithUTF8String:"forest.mp3"] key:KEY_BGM_FOREST];
    [[AudioPlayer getInstance] addMusicFile:[NSString stringWithUTF8String:"caves.mp3"] key:KEY_BGM_CAVES];
    [[AudioPlayer getInstance] addMusicFile:[NSString stringWithUTF8String:"depths.mp3"] key:KEY_BGM_DEPTHS];
    
    // Load save data
    [[Storage getInstance] loadData];
    
    // Start application with The Hub.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [[HubVC alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    Game *game = [(BaseVC *)self.window.rootViewController game];
    Player *player = [game getPlayer];
    [[Storage getInstance] clearData];
    [[Storage getInstance] setPlayer:player];
    [[Storage getInstance] setGameData:game];
    [[Storage getInstance] saveData];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[Assets getInstance] cleanUp];
}


@end
