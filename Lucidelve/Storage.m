//
//  Storage.m
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Storage.h"
#import "Utility.h"

const char *KEY_SAVE_FILE = "SAVE";

const char *KEY_PLAYER_GOLD = "PLAYER_GOLD";
const char *KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT = "KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT";
const char *KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT = "KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT";
const char *KEY_PLAYER_INVENTORY_BOMB_COUNT = "KEY_PLAYER_INVENTORY_BOMB_COUNT";
const char *KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT = "KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT";
const char *KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT = "KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT";
const char *KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT = "KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT";
const char *KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT = "KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT";
const char *KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT = "KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT";
const char *KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT = "KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT";
const char *KEY_PLAYER_INVENTORY_SHIELD_COUNT = "KEY_PLAYER_INVENTORY_SHIELD_COUNT";

const char *KEY_GAME_IS_SHOP_UNLOCKED = "KEY_GAME_IS_SHOP_UNLOCKED";
const char *KEY_GAME_IS_SWORD_BOUGHT = "KEY_GAME_IS_SWORD_BOUGHT";
const char *KEY_GAME_IS_INVENTORY_UNLOCKED = "KEY_GAME_IS_INVENTORY_UNLOCKED";
const char *KEY_GAME_IS_DUNGEONS_UNLOCKED = "KEY_GAME_IS_DUNGEONS_UNLOCKED";
const char *KEY_GAME_IS_GOOSE_UNLOCKED = "KEY_GAME_IS_GOOSE_UNLOCKED";
const char *KEY_GAME_NUM_GOOSE_UPGRADES = "KEY_GAME_NUM_GOOSE_UPGRADES";
const char *KEY_GAME_IS_BLACKSMITH_UNLOCKED = "KEY_GAME_IS_BLACKSMITH_UNLOCKED";
const char *KEY_GAME_NUM_BLACKSMITH_UPGRADES = "KEY_GAME_NUM_BLACKSMITH_UPGRADES";
const char *KEY_GAME_NUM_LIFE_UPGRADES = "KEY_GAME_NUM_LIFE_UPGRADES";

@interface Storage() {
    NSMutableDictionary<NSString *, NSObject *> *data;
}
@end

@implementation Storage

+ (id)getInstance {
    static Storage *INSTANCE = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[self alloc] init];
    });
    return INSTANCE;
}

- (id)init {
    if (self = [super init]) {
        // Instantiate variables here if needed
        [self clearData];
    }
    return self;
}

- (void)clearData {
    if (data == nil) {
        data = [NSMutableDictionary dictionary];
    }
    data[[NSString stringWithUTF8String:KEY_PLAYER_GOLD]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]] = [NSNumber numberWithInt:0];
    
    
    data[[NSString stringWithUTF8String:KEY_GAME_IS_SHOP_UNLOCKED]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_SWORD_BOUGHT]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_INVENTORY_UNLOCKED]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_DUNGEONS_UNLOCKED]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_GOOSE_UNLOCKED]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_GOOSE_UPGRADES]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_BLACKSMITH_UNLOCKED]] = [NSNumber numberWithBool:false];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_BLACKSMITH_UPGRADES]] = [NSNumber numberWithInt:0];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_LIFE_UPGRADES]] = [NSNumber numberWithInt:0];
}

- (void)saveData {
    // we can save all the variables
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        [[Utility getInstance] log:"Unable to convert the dictionary to JSON"];
    } else {
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"Saving %@", json);
        [[Utility getInstance] saveString:json key:[NSString stringWithUTF8String:KEY_SAVE_FILE]];
    }
}

- (void)loadData {
    NSError *error;
    NSString *json = [[Utility getInstance] getString:[NSString stringWithUTF8String:KEY_SAVE_FILE]];
    if ([json length] > 0) {
        NSLog(@"Loaded %@", json);
        NSData *jsonData =[json dataUsingEncoding:NSUTF8StringEncoding];
        data = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF8StringEncoding error:&error] mutableCopy];
    }
}

- (void)loadPlayer:(Player *)player {
    int goldCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_GOLD]]).intValue;
    int rustySwordCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]]).intValue;
    int healingPotionCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]]).intValue;
    int bombCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]]).intValue;
    int heartCookieCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]]).intValue;
    int polishedSwordCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]]).intValue;
    int sharpSwordCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]]).intValue;
    int tooSharpSwordCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]]).intValue;
    int magicGooseSwordCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]]).intValue;
    int goldenEggCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]]).intValue;
    int shieldCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]]).intValue;
    
    [player addGold:goldCount];
    int i = 0;
    for (i = 0; i < rustySwordCount; i++) {
        [player addItem:ITEMS[ITEM_RUSTY_SWORD]];
    }
    for (i = 0; i < healingPotionCount; i++) {
        [player addItem:ITEMS[ITEM_HEALING_POTION]];
    }
    for (i = 0; i < bombCount; i++) {
        [player addItem:ITEMS[ITEM_BOMB]];
    }
    for (i = 0; i < heartCookieCount; i++) {
        [player addItem:ITEMS[ITEM_HEART_COOKIE]];
    }
    for (i = 0; i < polishedSwordCount; i++) {
        [player addItem:ITEMS[ITEM_POLISHED_SWORD]];
    }
    for (i = 0; i < sharpSwordCount; i++) {
        [player addItem:ITEMS[ITEM_SHARP_SWORD]];
    }
    for (i = 0; i < tooSharpSwordCount; i++) {
        [player addItem:ITEMS[ITEM_TOO_SHARP_SWORD]];
    }
    for (i = 0; i < magicGooseSwordCount; i++) {
        [player addItem:ITEMS[ITEM_MAGIC_GOOSE_SWORD]];
    }
    for (i = 0; i < goldenEggCount; i++) {
        [player addItem:ITEMS[ITEM_GOLDEN_EGG]];
    }
    for (i = 0; i < shieldCount; i++) {
        [player addItem:ITEMS[ITEM_SHIELD]];
    }
}

- (void)loadGameData:(Game *)game {
    game.isShopUnlocked = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_SHOP_UNLOCKED]]).boolValue;
    game.isSwordBought = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_SWORD_BOUGHT]]).boolValue;
    game.isInventoryUnlocked = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_INVENTORY_UNLOCKED]]).boolValue;
    game.isDungeonsUnlocked = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_DUNGEONS_UNLOCKED]]).boolValue;
    game.isGooseUnlocked = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_GOOSE_UNLOCKED]]).boolValue;
    game.numGooseUpgrades = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_NUM_GOOSE_UPGRADES]]).intValue;
    game.isBlacksmithUnlocked = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_IS_BLACKSMITH_UNLOCKED]]).boolValue;
    game.numBlacksmithUpgrades = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_NUM_BLACKSMITH_UPGRADES]]).intValue;
    game.numLifeUpgrades = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_GAME_NUM_LIFE_UPGRADES]]).intValue;
}

- (void)setGameData:(Game *)game {
    data[[NSString stringWithUTF8String:KEY_GAME_IS_SHOP_UNLOCKED]] = [NSNumber numberWithBool:game.isShopUnlocked];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_SWORD_BOUGHT]] = [NSNumber numberWithBool:game.isSwordBought];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_INVENTORY_UNLOCKED]] = [NSNumber numberWithBool:game.isInventoryUnlocked];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_DUNGEONS_UNLOCKED]] = [NSNumber numberWithBool:game.isDungeonsUnlocked];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_GOOSE_UNLOCKED]] = [NSNumber numberWithBool:game.isGooseUnlocked];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_GOOSE_UPGRADES]] = [NSNumber numberWithInt:game.numGooseUpgrades];
    data[[NSString stringWithUTF8String:KEY_GAME_IS_BLACKSMITH_UNLOCKED]] = [NSNumber numberWithBool:game.isBlacksmithUnlocked];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_BLACKSMITH_UPGRADES]] = [NSNumber numberWithInt:game.numBlacksmithUpgrades];
    data[[NSString stringWithUTF8String:KEY_GAME_NUM_LIFE_UPGRADES]] = [NSNumber numberWithInt:game.numLifeUpgrades];
}

- (NSObject *)getObject:(NSString *)key {
    NSObject *value = [data objectForKey:key];
    if (value) {
        return value;
    }
    [[Utility getInstance] log:[[NSString stringWithFormat:@"No object exists for key \"%@\"", key] UTF8String]];
    return nil;
}

- (NSObject *)getObjectC:(const char *)key {
    return [self getObject:[NSString stringWithUTF8String:key]];
}

- (void)setValue:(NSObject *)value key:(NSString *)key {
    NSObject *oldValue = [data objectForKey:key];
    if (oldValue) {
        [[Utility getInstance] log:[[NSString stringWithFormat:@"Replacing object at key \"%@\"", key] UTF8String]];
    }
    [data setObject:value forKey:key];
}

- (void)setValueC:(NSObject *)value key:(const char *)key {
    [self setValue:value key:[NSString stringWithUTF8String:key]];
}

- (void)addInventoryItem:(Item)item {
    int itemCount = 0;
    if ([item.name isEqualToString:ITEMS[ITEM_RUSTY_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEALING_POTION].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_BOMB].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEART_COOKIE].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_POLISHED_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_TOO_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_MAGIC_GOOSE_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_GOLDEN_EGG].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHIELD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]]).intValue;
        itemCount++;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]] = [NSNumber numberWithInt:itemCount];
    }
}

- (void)removeInventoryItem:(Item)item {
    int itemCount = 0;
    if ([item.name isEqualToString:ITEMS[ITEM_RUSTY_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEALING_POTION].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_BOMB].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_BOMB_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEART_COOKIE].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_POLISHED_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_TOO_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_MAGIC_GOOSE_SWORD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_GOLDEN_EGG].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHIELD].name]) {
        itemCount = ((NSNumber *)data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]]).intValue;
        itemCount--;
        data[[NSString stringWithUTF8String:KEY_PLAYER_INVENTORY_SHIELD_COUNT]] = [NSNumber numberWithInt:itemCount];
    }
}

- (NSString *)getString:(NSString *)key {
    NSObject *object = [self getObject:key];
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)data[key];
    }
    return nil;
}

- (NSString *)getStringC:(const char *)key {
    return [self getString:[NSString stringWithUTF8String:key]];
}

- (int)getInt:(NSString *)key {
    NSObject *object = [self getObject:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)data[key]).intValue;
    }
    return 0;
}

- (int)getIntC:(const char *)key {
    return [self getInt:[NSString stringWithUTF8String:key]];
}

- (float)getFloat:(NSString *)key {
    NSObject *object = [self getObject:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)data[key]).floatValue;
    }
    return 0.0f;
}

- (float)getFloatC:(const char *)key {
    return [self getFloat:[NSString stringWithUTF8String:key]];
}

- (NSMutableArray *)getMutableArray:(NSString *)key {
    NSObject *object = [self getObject:key];
    if ([object isKindOfClass:[NSMutableArray class]]) {
        return (NSMutableArray *)data[key];
    }
    return nil;
}

- (NSMutableArray *)getMutableArrayC:(const char *)key {
    return [self getMutableArray:[NSString stringWithUTF8String:key]];
}

@end
