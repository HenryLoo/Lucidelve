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
    XCTAssertThrows([[Utility getInstance] loadResource:[_bundle pathForResource:@"doesnotexist" ofType:@"jpg"] error:NULL], @"File not found");
}

/*!
 * If trying to load a nil file path, raises a null pointer exception.
 */
- (void)testLoadResourceNullPointer {
    XCTAssertThrows([[Utility getInstance] loadResource:nil error:NULL], @"Null pointer");
}

/*!
 * If a resource is valid.
 */
- (void)testLoadResourceValid {
    NSData *data = [[Utility getInstance] loadResource:[_bundle pathForResource:@"thinking.jpg" ofType:nil inDirectory:@"Assets/thinking.imageset"] error:NULL];
    XCTAssertNotNil(data);
}

@end
