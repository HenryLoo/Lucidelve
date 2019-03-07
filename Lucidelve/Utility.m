//
//  Utility.m
//  Lucidelve
//
//  Created by Choy on 2019-02-05.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (id)getInstance {
    static Utility *INSTANCE = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[self alloc] init];
    });
    return INSTANCE;
}

- (id)init {
    if (self = [super init]) {
        // Instantiate variables here if needed
    }
    return self;
}

- (NSData *)loadResource:(NSString *)filePath {
    if (filePath == nil) {
        [NSException raise:@"Null pointer" format:@"The file path was null"];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [NSException raise:@"File not found" format:@"The resource does not exist at path: %@", filePath];
    }
    
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    return [NSData dataWithContentsOfURL:fileUrl];
}

- (NSDictionary *)decodeJSON:(NSData *)jsonData {
    NSDictionary *results = nil;
    
    if (NSClassFromString(@"NSJSONSerialization")) {
        // Validate the JSON
        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            // Malformed data
            [NSException raise:@"JSON error" format:@"The JSON is malformed."];
        }
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            results = object;
        } else {
            [NSException raise:@"JSON error" format:@"The resulting data was not a NSDictionary"];
        }
    } else {
        // The user is using some a version of iOS older than 4
        // Use a third-party solution
    }
    
    return results;
}

- (void)log:(const char *)str {
    NSLog(@"%s", str);
}

- (NSString *)getFilepath:(const char *)filename fileType:(const char *)fileType {
    return [self getFilepath:filename fileType:fileType bundle:[NSBundle mainBundle]];
}

- (NSString *)getFilepath:(const char *)filename fileType:(const char *)fileType bundle:(NSBundle *)bundle {
    return [bundle pathForResource:[NSString stringWithUTF8String:filename] ofType:nil inDirectory:[NSString stringWithFormat:@"Assets/%s/", fileType]];
}

- (void)saveBool:(bool)value key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

- (void)saveFloat:(float)value key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setFloat:value forKey:key];
    [userDefaults synchronize];
}

- (void)saveInt:(int)value key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:value forKey:key];
    [userDefaults synchronize];
}

- (void)saveString:(NSString *)value key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

- (bool)getBool:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (float)getFloat:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

- (int)getInt:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (NSString *)getString:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end
