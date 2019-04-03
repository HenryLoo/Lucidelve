//
//  DirectionalLight.m
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "DirectionalLight.h"

@implementation DirectionalLight

-  (id)init {
    if (self == [super init]) {
        _direction = GLKVector3Make(-0.2f, -1.0f, -0.3f);
        _ambient = GLKVector3Make(0.4f, 0.4f, 0.4f);
        _diffuse = GLKVector3Make(0.5f, 0.5f, 0.5f);
        _specular = GLKVector3Make(0.5f, 0.5f, 0.5f);
    }
    return self;
}

- (void)draw:(GLProgram *)program {
    [program set3fv:_direction.v uniformName:@"dirLight.direction"];
    [program set3fv:_ambient.v uniformName:@"dirLight.ambient"];
    [program set3fv:_diffuse.v uniformName:@"dirLight.diffuse"];
    [program set3fv:_specular.v uniformName:@"dirLight.specular"];
}


- (GLKVector3)direction {
	return _direction;
}

- (void)setDirection:(GLKVector3)direction {
	_direction = direction;
}

@end
