//
//  Uniform].m
//  ABC
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Uniform.h"

@implementation Uniform

- (id)initWithName:(NSString *)name uniformId:(GLuint)uniformId {
    if (self == [super init]) {
        _name = name;
        _uniformId = uniformId;
    }
    return self;
}

- (NSString *)name {
	return _name;
}

- (GLuint)uniformId {
	return _uniformId;
}

@end
