//
//  Camera.m
//  Adapted from Joey DeVries LearnOpenGL tutorials found at
//  https://learnopengl.com/
//  ass_2
//
//  Created by Choy on 2019-02-17.
//

#import "Camera.h"

#define YAW -90.0f
#define PITCH 0.0f
#define ZOOM 45.0f

@implementation Camera

- (id)init {
    return [self initWithPosition:GLKVector3Make(0.0f, 0.0f, 0.0f) up:GLKVector3Make(0.0f, 1.0f, 0.0f) yaw:YAW pitch:PITCH];
}

- (id)initWithPosition:(GLKVector3)position {
    return [self initWithPosition:position up:GLKVector3Make(0.0f, 1.0f, 0.0f) yaw:YAW pitch:PITCH];
}

- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up {
    return [self initWithPosition:position up:up yaw:YAW pitch:PITCH];
}

- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up yaw:(GLfloat)yaw {
    return [self initWithPosition:position up:up yaw:yaw pitch:PITCH];
}

- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up yaw:(GLfloat)yaw pitch:(GLfloat)pitch {
    return [self initWithPosition:position.x posY:position.y posZ:position.z upX:up.x upY:up.y upZ:up.z yaw:yaw pitch:pitch];
}

- (id)initWithPosition:(GLfloat)posX posY:(GLfloat)posY posZ:(GLfloat)posZ upX:(GLfloat)upX upY:(GLfloat)upY upZ:(GLfloat)upZ yaw:(GLfloat)yaw pitch:(GLfloat)pitch {
    if (self == [super init]) {
        _position = GLKVector3Make(posX, posY, posZ);
        _up = GLKVector3Make(upX, upY, upZ);
        _worldUp = _up;
        _yaw = yaw;
        _pitch = pitch;
        _zoom = ZOOM;
        
        [self update];
    }
    return self;
}

- (void)update {
    // Calculate the new Front vector
    GLKVector3 front;
    front.x = cosf(GLKMathDegreesToRadians(_yaw)) * cosf(GLKMathDegreesToRadians(_pitch));
    front.y = sinf(GLKMathDegreesToRadians(_pitch));
    front.z = sinf(GLKMathDegreesToRadians(_yaw)) * cosf(GLKMathDegreesToRadians(_pitch));
    _front = GLKVector3Normalize(front);
    // Also re-calculate the Right and Up vector
    // normalize their vectors, because their length gets closer to 0 the more you look up or down which results in slower movement
    _right = GLKVector3Normalize(GLKVector3CrossProduct(_front, _worldUp));
    _up = GLKVector3Normalize(GLKVector3CrossProduct(_right, _front));
}

- (GLKMatrix4)getViewMatrix {
    return GLKMatrix4MakeLookAt(_position.x, _position.y, _position.z, _position.x + _front.x, _position.y + _front.y, _position.z + _front.z, _up.x, _up.y, _up.z);
}


- (GLKVector3)position {
	return _position;
}

- (GLKVector3)front {
	return _front;
}

- (GLKVector3)up {
	return _up;
}

- (GLKVector3)right {
	return _right;
}

- (GLKVector3)worldUp {
	return _worldUp;
}

- (GLfloat)yaw {
	return _yaw;
}

- (GLfloat)pitch {
	return _pitch;
}

- (GLfloat)zoom {
	return _zoom;
}

- (void)setPosition:(GLKVector3)position {
	_position = position;
}

- (void)setUp:(GLKVector3)up {
	_up = up;
}

- (void)setYaw:(GLfloat)yaw {
	_yaw = yaw;
}

- (void)setPitch:(GLfloat)pitch {
	_pitch = pitch;
}

- (void)setZoom:(GLfloat)zoom {
	_zoom = zoom;
}

@end
