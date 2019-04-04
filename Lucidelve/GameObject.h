//
//  GameObject.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-04-03.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "GameCharacter.h"

@interface GameObject : NSObject

@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 rotation;
@property (nonatomic) GLKVector3 velocity;
@property (nonatomic) GLKVector3 acceleration;
@property (nonatomic) GLKVector3 angularVelocity;
@property (nonatomic) GLKVector3 scale;

/*!
 * @brief Update the throwable's values.
 * This should be called each frame in the update loop.
 * @author Henry Loo
 *
 * @param deltaTime The amount of time passed for the current loop.
 */
- (void)update:(float)deltaTime;

/*!
 * @brief Check for collisions against a GameCharacter.
 * @author Henry Loo
 *
 * @param other The GameCharacter to test collisions against.
 */
- (bool)isColliding:(GameCharacter *)other;

@end
