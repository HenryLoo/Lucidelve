//
//  SpotLight.m
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "SpotLight.h"

@implementation SpotLight

-  (id)init {
    if (self == [super init]) {
        _position = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _direction = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _ambient = GLKVector3Make(0.0f, 0.0f, 0.0f);
        _diffuse = GLKVector3Make(1.0f, 1.0f, 1.0f);
        _specular = GLKVector3Make(1.0f, 1.0f, 1.0f);
        _constant = 1.0f;
        _linear = 0.09f;
        _quadratic = 0.032f;
        _cutOff = 0.9763f;
        _outerCutOff = 0.966f;
    }
    return self;
}

- (void)draw:(GLProgram *)program {
    [program set3fv:_position.v uniformName:@"spotLight.position"];
    [program set3fv:_direction.v uniformName:@"spotLight.direction"];
    [program set3fv:_ambient.v uniformName:@"spotLight.ambient"];
    [program set3fv:_diffuse.v uniformName:@"spotLight.diffuse"];
    [program set3fv:_specular.v uniformName:@"spotLight.specular"];
    [program set1f:_constant uniformName:@"spotLight.constant"];
    [program set1f:_linear uniformName:@"spotLight.linear"];
    [program set1f:_quadratic uniformName:@"spotLight.quadratic"];
    [program set1f:_cutOff uniformName:@"spotLight.cutOff"];
    [program set1f:_outerCutOff uniformName:@"spotLight.outerCutOff"];
}

- (GLKVector3)position {
	return _position;
}

- (GLKVector3)direction {
	return _direction;
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

- (GLfloat)cutOff {
    return _cutOff;
}

- (GLfloat)outerCutOff {
    return _outerCutOff;
}

- (void)setPosition:(GLKVector3)position {
	_position = position;
}

- (void)setDirection:(GLKVector3)direction {
	_direction = direction;
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

- (void)setCutOff:(GLfloat)cutOff {
    _cutOff = cutOff;
}

- (void)setOuterCutOff:(GLfloat)outerCutOff {
    _outerCutOff = outerCutOff;
}

@end
