//
//  PointLight.m
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "PointLight.h"

@implementation PointLight

-  (id)init {
    if (self == [super init]) {
        _position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _ambient = GLKVector3Make(0.05f, 0.05f, 0.05f);
        _diffuse = GLKVector3Make(0.8f, 0.8f, 0.8f);
        _specular = GLKVector3Make(1.0f, 1.0f, 1.0f);
        _constant = 1.0f;
        _linear = 0.09f;
        _quadratic = 0.032f;
    }
    return self;
}

- (void)draw:(GLProgram *)program {
    [program set3fv:_position.v uniformName:@"pointLight.position"];
    [program set3fv:_ambient.v uniformName:@"pointLight.ambient"];
    [program set3fv:_diffuse.v uniformName:@"pointLight.diffuse"];
    [program set3fv:_specular.v uniformName:@"pointLight.specular"];
    [program set1f:_constant uniformName:@"pointLight.constant"];
    [program set1f:_linear uniformName:@"pointLight.linear"];
    [program set1f:_quadratic uniformName:@"pointLight.quadratic"];
}

- (GLKVector3)position {
	return _position;
}

- (GLfloat)constant {
	return _constant;
}

- (GLfloat)linear {
	return _linear;
}

- (GLfloat)quadratic {
	return _quadratic;
}

- (void)setPosition:(GLKVector3)position {
	_position = position;
}

- (void)setConstant:(GLfloat)constant {
	_constant = constant;
}

- (void)setLinear:(GLfloat)linear {
	_linear = linear;
}

- (void)setQuadratic:(GLfloat)quadratic {
	_quadratic = quadratic;
}

@end
