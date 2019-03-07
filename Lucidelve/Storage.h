//
//  Storage.h
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Player.h"
#import "Item.h"
#import "Constants.h"
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A generic Singleton class containing
 * generic functions.
 */
@interface Storage : NSObject

/*!
 * Returns a static instance of the Storage
 * Singleton class.
 * @author Jason Chung
 *
 * @return A reference to the Objective-C object for
 * this class.
 */
+ (id)getInstance;

- (void)clearData;
- (void)saveData;
- (void)loadData;
- (void)loadPlayer:(Player *)player;
- (void)loadGameData:(Game *)game;
- (void)setGameData:(Game *)game;
- (NSObject *)getObject:(NSString *)key;
- (NSObject *)getObjectC:(const char *)key;
- (NSString *)getString:(NSString *)key;
- (NSString *)getStringC:(const char *)key;
- (int)getInt:(NSString *)key;
- (int)getIntC:(const char *)key;
- (float)getFloat:(NSString *)key;
- (float)getFloatC:(const char *)key;
- (NSMutableArray *)getMutableArray:(NSString *)key;
- (NSMutableArray *)getMutableArrayC:(const char *)key;
- (void)setValue:(NSObject *)value key:(NSString *)key;
- (void)setValueC:(NSObject *)value key:(const char *)key;
- (void)addInventoryItem:(Item)item;
- (void)removeInventoryItem:(Item)item;

@end

extern const char *KEY_SAVE_FILE;

extern const char *KEY_PLAYER_GOLD;
extern const char *KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT;
extern const char *KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT;
extern const char *KEY_PLAYER_INVENTORY_BOMB_COUNT;
extern const char *KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT;
extern const char *KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT;
extern const char *KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT;
extern const char *KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT;
extern const char *KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT;
extern const char *KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT;
extern const char *KEY_PLAYER_INVENTORY_SHIELD_COUNT;

extern const char *KEY_GAME_IS_SHOP_UNLOCKED;
extern const char *KEY_GAME_IS_SWORD_BOUGHT;
extern const char *KEY_GAME_IS_INVENTORY_UNLOCKED;
extern const char *KEY_GAME_IS_DUNGEONS_UNLOCKED;
extern const char *KEY_GAME_IS_GOOSE_UNLOCKED;
extern const char *KEY_GAME_NUM_GOOSE_UPGRADES;
extern const char *KEY_GAME_IS_BLACKSMITH_UNLOCKED;
extern const char *KEY_GAME_NUM_BLACKSMITH_UPGRADES;
extern const char *KEY_GAME_NUM_LIFE_UPGRADES;

NS_ASSUME_NONNULL_END
