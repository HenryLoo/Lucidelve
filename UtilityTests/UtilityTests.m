//
//  UtilityTests.m
//  UtilityTests
//
//  Created by Choy on 2019-02-05.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utility.h"

@interface UtilityTests : XCTestCase

@property NSBundle *bundle;

@end

@implementation UtilityTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    
    _bundle = [NSBundle bundleForClass:[self class]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

/*!
 * If a resource doesn't exist, raises a file not found exception.
 */
- (void)testLoadResourceDoesNotExist {
    XCTAssertThrows([[Utility getInstance] loadResource:[_bundle pathForResource:@"doesnotexist" ofType:@"jpg"]], @"File not found");
}

/*!
 * If trying to load a nil file path, raises a null pointer exception.
 */
- (void)testLoadResourceNullPointer {
    NSString *nilStr = nil;
    XCTAssertThrows([[Utility getInstance] loadResource:nilStr], @"Null pointer");
}

/*!
 * If a resource is valid.
 */
- (void)testLoadResourceValid {
    NSData *data = [[Utility getInstance] loadResource:[_bundle pathForResource:@"thinking.jpg" ofType:nil inDirectory:@"Assets/thinking.imageset"]];
    XCTAssertNotNil(data);
}

- (void)testLoadJSONMalformed {
    NSData *data = [[Utility getInstance] loadResource:[_bundle pathForResource:@"malformed.json" ofType:nil inDirectory:@"Assets/json"]];
    XCTAssertThrows([[Utility getInstance] decodeJSON:data], @"JSON error");
}

- (void)testLoadJSONInvalid {
    NSData *data = [[Utility getInstance] loadResource:[_bundle pathForResource:@"invalid.json" ofType:nil inDirectory:@"Assets/json"]];
    XCTAssertThrows([[Utility getInstance] decodeJSON:data], @"JSON error");
}

- (void)testLoadJSONValid {
    NSData *data = [[Utility getInstance] loadResource:[_bundle pathForResource:@"valid.json" ofType:nil inDirectory:@"Assets/json"]];
    NSDictionary *json = [[Utility getInstance] decodeJSON:data];
    XCTAssertNotNil(json);
    XCTAssertTrue([json[@"valid"] isEqualToString:@"json"], "Strings are not equal %@ %@", json[@"valid"], @"json");
}

@end
