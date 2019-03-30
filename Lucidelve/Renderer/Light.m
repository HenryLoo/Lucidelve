//
//  Light.m
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Light.h"

@implementation Light

-  (id)init {
    if (self == [super init]) {
        _ambient = GLKVector3Make(0.05f, 0.05f, 0.05f);
        _diffuse = GLKVector3Make(0.5f, 0.5f, 0.5f);
        _specular = GLKVector3Make(0.5f, 0.5f, 0.5f);
    }
    return self;
}

- (void)draw:(GLProgram *)program {
    [program set3fv:_ambient.v uniformName:@"light.ambient"];
    [program set3fv:_diffuse.v uniformName:@"light.diffuse"];
    [program set3fv:_specular.v uniformName:@"light.specular"];
}


- (GLKVector3)ambient {
	return _ambient;
}

- (GLKVector3)diffuse {
	return _diffuse;
}

- (GLKVector3)specular {
	return _specular;
}

- (void)setAmbient:(GLKVector3)ambient {
	_ambient = ambient;
}

- (void)setDiffuse:(GLKVector3)diffuse {
	_diffuse = diffuse;
}

- (void)setSpecular:(GLKVector3)specular {
	_specular = specular;
}

@end
