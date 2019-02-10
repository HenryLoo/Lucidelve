//
//  Uniform.m
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Uniform.h"

@implementation Uniform

- (const NSString *)getName {
    return _name;
}

- (GLint)getLocation {
    return _location;
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (void)setLocation:(GLint)location {
    _location = location;
}

@end
