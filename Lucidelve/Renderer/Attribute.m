//
//  Attribute.m
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Attribute.h"

@implementation Attribute

- (id)initWithName:(NSString *)name attributeId:(GLuint)attributeId {
    if (self == [super init]) {
        _name = name;
        _attributeId = attributeId;
    }
    return self;
}

- (NSString *)name {
	return _name;
}

- (GLuint)attributeId {
	return _attributeId;
}

@end
