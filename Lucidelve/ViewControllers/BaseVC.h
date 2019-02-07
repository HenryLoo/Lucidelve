//
//  IGameVC.h
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class Game;

/*!
 * @brief A base class implemented by all view controllers
 * to ensure that the game data is passed between them.
 */
@interface BaseVC : GLKViewController

@property Game *game;

@end
