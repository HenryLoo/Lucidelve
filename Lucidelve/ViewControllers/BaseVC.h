//
//  BaseVC.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class Game;
@class Renderer;
@class Camera;
@class Mesh;

/*!
 * @brief A base class implemented by all view controllers
 * to ensure that the game data is passed between them.
 */
@interface BaseVC : GLKViewController

// Pointer to the Game instance, which holds all persistent data
@property Game *game;

// Pointer to the glES renderer
@property Renderer *renderer;

// Pointer to the Camera that every VC will view from
@property Camera *camera;

/*!
 * @brief The update loop.
 * Subclasses should call this every frame.
 * @author Henry Loo
 */
- (void)update;

/*!
 * @brief Handle the back button's action.
 * This should redirect the player to The Hub.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onBackButtonPress:(id)sender;

/*!
 * @brief Jiggles a Mesh left and right
 * @author Jason Chung
 *
 * @param mesh The Mesh to jiggle
 * @param forward If the Mesh is moving forward or backwards
 */
- (void)jiggleMesh:(Mesh *)mesh forward:(bool *)forward;

@end
