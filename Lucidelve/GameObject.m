//
//  GameObject.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-04-03.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface GameObject ()
{
    
}

@end

@implementation GameObject

- (void)update:(float)deltaTime
{
    float delta = ABS(deltaTime);
    _position = GLKVector3Add(_position, GLKVector3MultiplyScalar(_velocity, delta));
    _velocity = GLKVector3Add(_velocity, GLKVector3MultiplyScalar(_acceleration, delta));
    
    _rotation = GLKVector3Add(_position, GLKVector3MultiplyScalar(_angularVelocity, delta));
}

- (bool)isColliding:(GameCharacter *)other
{
    // Simple collisions, since we're always throwing the item from bottom to top
    float halfZ = _scale.z / 2;
    return other.position.z > _position.z + halfZ;
}

@end
