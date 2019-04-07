//
//  Storage.m
//  Lucidelve
//
//  Created by Jason Chung on 2019-03-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Storage.h"
#import "Utility.h"

NSString *KEY_SAVE_FILE = @"SAVE";

NSString *KEY_PLAYER_GOLD = @"PLAYER_GOLD";
NSString *KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT = @"KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT";
NSString *KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT = @"KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT";
NSString *KEY_PLAYER_INVENTORY_BOMB_COUNT = @"KEY_PLAYER_INVENTORY_BOMB_COUNT";
NSString *KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT = @"KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT";
NSString *KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT = @"KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT";
NSString *KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT = @"KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT";
NSString *KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT = @"KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT";
NSString *KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT = @"KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT";
NSString *KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT = @"KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT";
NSString *KEY_PLAYER_INVENTORY_SHIELD_COUNT = @"KEY_PLAYER_INVENTORY_SHIELD_COUNT";

NSString *KEY_PLAYER_EQUIPPED_ITEM_1 = @"KEY_PLAYER_EQUIPPED_ITEM_1";
NSString *KEY_PLAYER_EQUIPPED_ITEM_2 = @"KEY_PLAYER_EQUIPPED_ITEM_2";

NSString *KEY_GAME_IS_SHOP_UNLOCKED = @"KEY_GAME_IS_SHOP_UNLOCKED";
NSString *KEY_GAME_IS_SWORD_BOUGHT = @"KEY_GAME_IS_SWORD_BOUGHT";
NSString *KEY_GAME_IS_INVENTORY_UNLOCKED = @"KEY_GAME_IS_INVENTORY_UNLOCKED";
NSString *KEY_GAME_IS_DUNGEONS_UNLOCKED = @"KEY_GAME_IS_DUNGEONS_UNLOCKED";
NSString *KEY_GAME_IS_GOOSE_UNLOCKED = @"KEY_GAME_IS_GOOSE_UNLOCKED";
NSString *KEY_GAME_NUM_GOOSE_UPGRADES = @"KEY_GAME_NUM_GOOSE_UPGRADES";
NSString *KEY_GAME_IS_BLACKSMITH_UNLOCKED = @"KEY_GAME_IS_BLACKSMITH_UNLOCKED";
NSString *KEY_GAME_NUM_BLACKSMITH_UPGRADES = @"KEY_GAME_NUM_BLACKSMITH_UPGRADES";
NSString *KEY_GAME_NUM_LIFE_UPGRADES = @"KEY_GAME_NUM_LIFE_UPGRADES";
NSString *KEY_GAME_NUM_DUNGEONS_CLEARED = @"KEY_GAME_NUM_DUNGEONS_CLEARED";
NSString *KEY_GAME_HIGHSCORES = @"KEY_GAME_HIGHSCORES";

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
    data[KEY_PLAYER_GOLD] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_BOMB_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT] = [NSNumber numberWithInt:0];
    data[KEY_PLAYER_INVENTORY_SHIELD_COUNT] = [NSNumber numberWithInt:0];
    
    data[KEY_PLAYER_EQUIPPED_ITEM_1] = ITEMS[ITEM_NONE].name;
    data[KEY_PLAYER_EQUIPPED_ITEM_2] = ITEMS[ITEM_NONE].name;
    
    data[KEY_GAME_IS_SHOP_UNLOCKED] = [NSNumber numberWithBool:false];
    data[KEY_GAME_IS_SWORD_BOUGHT] = [NSNumber numberWithBool:false];
    data[KEY_GAME_IS_INVENTORY_UNLOCKED] = [NSNumber numberWithBool:false];
    data[KEY_GAME_IS_DUNGEONS_UNLOCKED] = [NSNumber numberWithBool:false];
    data[KEY_GAME_IS_GOOSE_UNLOCKED] = [NSNumber numberWithBool:false];
    data[KEY_GAME_NUM_GOOSE_UPGRADES] = [NSNumber numberWithInt:0];
    data[KEY_GAME_IS_BLACKSMITH_UNLOCKED] = [NSNumber numberWithBool:false];
    data[KEY_GAME_NUM_BLACKSMITH_UPGRADES] = [NSNumber numberWithInt:0];
    data[KEY_GAME_NUM_LIFE_UPGRADES] = [NSNumber numberWithInt:0];
    data[KEY_GAME_NUM_DUNGEONS_CLEARED] = [NSNumber numberWithInt:0];
    
    [((NSMutableArray *)data[KEY_GAME_HIGHSCORES]) removeAllObjects];
}

- (void)saveData {
    // we can save all the variables
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        [[Utility getInstance] log:@"Unable to convert the dictionary to JSON"];
    } else {
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[Utility getInstance] saveString:json key:KEY_SAVE_FILE];
    }
}

- (void)loadData {
    NSError *error;
    NSString *json = [[Utility getInstance] getString:KEY_SAVE_FILE];
    if ([json length] > 0) {
        NSData *jsonData =[json dataUsingEncoding:NSUTF8StringEncoding];
        data = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF8StringEncoding error:&error] mutableCopy];
    }
}

- (void)loadPlayer:(Player *)player {
    int goldCount = ((NSNumber *)data[KEY_PLAYER_GOLD]).intValue;
    int rustySwordCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]).intValue;
    int healingPotionCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]).intValue;
    int bombCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_BOMB_COUNT]).intValue;
    int heartCookieCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]).intValue;
    int polishedSwordCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]).intValue;
    int sharpSwordCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]).intValue;
    int tooSharpSwordCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]).intValue;
    int magicGooseSwordCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]).intValue;
    int goldenEggCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]).intValue;
    int shieldCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHIELD_COUNT]).intValue;
    
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
    
    // NSString *equippedItem1 = ((NSString *) data[KEY_PLAYER_EQUIPPED_ITEM_1]);
    // NSString *equippedItem2 = ((NSString *) data[KEY_PLAYER_EQUIPPED_ITEM_2]);
    
    Item item1 = [self getEquippableItem:((NSString *) data[KEY_PLAYER_EQUIPPED_ITEM_1])];
    Item item2 = [self getEquippableItem:((NSString *) data[KEY_PLAYER_EQUIPPED_ITEM_2])];
    
    [player addItem:item1];
    [player addItem:item2];
    
    [player equipItem:([player getNumItems] - 2) withItemSlot:0];
    [player equipItem:([player getNumItems] - 1) withItemSlot:1];
}

- (void)setPlayer:(Player *)player {
    [self setValue:[NSNumber numberWithInt:[player getGold]] key:KEY_PLAYER_GOLD];
    NSUInteger numItems = [player getNumItems];
    for(NSUInteger i = 0; i < numItems; i++) {
        Item item = [player getItem:i];
        [self addInventoryItem:item];
    }
    [self setValue:[player getEquippedItem:0].name key:KEY_PLAYER_EQUIPPED_ITEM_1];
    [self setValue:[player getEquippedItem:1].name key:KEY_PLAYER_EQUIPPED_ITEM_2];
}

- (void)loadGameData:(Game *)game {
    game.isShopUnlocked = ((NSNumber *)data[KEY_GAME_IS_SHOP_UNLOCKED]).boolValue;
    game.isSwordBought = ((NSNumber *)data[KEY_GAME_IS_SWORD_BOUGHT]).boolValue;
    game.isInventoryUnlocked = ((NSNumber *)data[KEY_GAME_IS_INVENTORY_UNLOCKED]).boolValue;
    game.isDungeonsUnlocked = ((NSNumber *)data[KEY_GAME_IS_DUNGEONS_UNLOCKED]).boolValue;
    game.isGooseUnlocked = ((NSNumber *)data[KEY_GAME_IS_GOOSE_UNLOCKED]).boolValue;
    game.numGooseUpgrades = ((NSNumber *)data[KEY_GAME_NUM_GOOSE_UPGRADES]).intValue;
    game.isBlacksmithUnlocked = ((NSNumber *)data[KEY_GAME_IS_BLACKSMITH_UNLOCKED]).boolValue;
    game.numBlacksmithUpgrades = ((NSNumber *)data[KEY_GAME_NUM_BLACKSMITH_UPGRADES]).intValue;
    game.numLifeUpgrades = ((NSNumber *)data[KEY_GAME_NUM_LIFE_UPGRADES]).intValue;
    game.numDungeonsCleared = ((NSNumber *)data[KEY_GAME_NUM_DUNGEONS_CLEARED]).intValue;
    
    for (int i = 0; i < [game getNumDungeons]; ++i)
    {
        NSNumber *score = ((NSMutableArray *)data[KEY_GAME_HIGHSCORES])[i];
        if (!score) continue;
        
        [game.highscores replaceObjectAtIndex:i withObject:score];
    }
}

- (void)setGameData:(Game *)game {
    data[KEY_GAME_IS_SHOP_UNLOCKED] = [NSNumber numberWithBool:game.isShopUnlocked];
    data[KEY_GAME_IS_SWORD_BOUGHT] = [NSNumber numberWithBool:game.isSwordBought];
    data[KEY_GAME_IS_INVENTORY_UNLOCKED] = [NSNumber numberWithBool:game.isInventoryUnlocked];
    data[KEY_GAME_IS_DUNGEONS_UNLOCKED] = [NSNumber numberWithBool:game.isDungeonsUnlocked];
    data[KEY_GAME_IS_GOOSE_UNLOCKED] = [NSNumber numberWithBool:game.isGooseUnlocked];
    data[KEY_GAME_NUM_GOOSE_UPGRADES] = [NSNumber numberWithInt:game.numGooseUpgrades];
    data[KEY_GAME_IS_BLACKSMITH_UNLOCKED] = [NSNumber numberWithBool:game.isBlacksmithUnlocked];
    data[KEY_GAME_NUM_BLACKSMITH_UPGRADES] = [NSNumber numberWithInt:game.numBlacksmithUpgrades];
    data[KEY_GAME_NUM_LIFE_UPGRADES] = [NSNumber numberWithInt:game.numLifeUpgrades];
    data[KEY_GAME_NUM_DUNGEONS_CLEARED] = [NSNumber numberWithInteger:game.numDungeonsCleared];
    data[KEY_GAME_HIGHSCORES] = game.highscores;
}

- (NSObject *)getObject:(NSString *)key {
    NSObject *value = [data objectForKey:key];
    if (value) {
        return value;
    }
    [[Utility getInstance] log:[NSString stringWithFormat:@"No object exists for key \"%@\"", key]];
    return nil;
}

- (NSObject *)getObjectC:(const char *)key {
    return [self getObject:[NSString stringWithUTF8String:key]];
}

- (void)setValue:(NSObject *)value key:(NSString *)key {
    NSObject *oldValue = [data objectForKey:key];
    if (oldValue) {
        // [[Utility getInstance] log:[[NSString stringWithFormat:@"Replacing object at key \"%@\"", key] UTF8String]];
    }
    [data setObject:value forKey:key];
}

- (void)setValueC:(NSObject *)value key:(const char *)key {
    [self setValue:value key:[NSString stringWithUTF8String:key]];
}

- (Item)getEquippableItem:(NSString *)itemName {
    if ([itemName isEqualToString:ITEMS[ITEM_HEALING_POTION].name]) {
        return ITEMS[ITEM_HEALING_POTION];
    } else if ([itemName isEqualToString:ITEMS[ITEM_BOMB].name]) {
        return ITEMS[ITEM_BOMB];
    } else if ([itemName isEqualToString:ITEMS[ITEM_SHIELD].name]) {
        return ITEMS[ITEM_SHIELD];
    }
    return ITEMS[ITEM_NONE];
}

- (void)addInventoryItem:(Item)item {
    int itemCount = 0;
    if ([item.name isEqualToString:ITEMS[ITEM_RUSTY_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEALING_POTION].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_BOMB].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_BOMB_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_BOMB_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEART_COOKIE].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_POLISHED_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_TOO_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_MAGIC_GOOSE_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_GOLDEN_EGG].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHIELD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHIELD_COUNT]).intValue;
        itemCount++;
        data[KEY_PLAYER_INVENTORY_SHIELD_COUNT] = [NSNumber numberWithInt:itemCount];
    }
}

- (void)removeInventoryItem:(Item)item {
    int itemCount = 0;
    if ([item.name isEqualToString:ITEMS[ITEM_RUSTY_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_RUSTY_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEALING_POTION].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_HEALING_POTION_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_BOMB].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_BOMB_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_BOMB_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_HEART_COOKIE].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_HEART_COOKIE_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_POLISHED_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_POLISHED_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_TOO_SHARP_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_TOO_SHARP_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_MAGIC_GOOSE_SWORD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_MAGIC_GOOSE_SWORD_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_GOLDEN_EGG].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_GOLDEN_EGG_COUNT] = [NSNumber numberWithInt:itemCount];
    } else if ([item.name isEqualToString:ITEMS[ITEM_SHIELD].name]) {
        itemCount = ((NSNumber *)data[KEY_PLAYER_INVENTORY_SHIELD_COUNT]).intValue;
        itemCount--;
        data[KEY_PLAYER_INVENTORY_SHIELD_COUNT] = [NSNumber numberWithInt:itemCount];
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
