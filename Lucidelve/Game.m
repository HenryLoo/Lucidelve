//
//  Game.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "Game.h"
#import "BaseVC.h"
#import "Player.h"

@interface Game ()
{
    Player *player;
}

@end

@implementation Game

- (id)init
{
    if (self = [super init]) {
        player = [[Player alloc] init];
    }
    return self;
}

- (Player*)getPlayer
{
    return player;
}

- (void)changeScene:(BaseVC*)currentVC newVC:(BaseVC*)newVC
{
    // Pass the Game's data before switching scenes
    newVC.game = self;
    [currentVC presentViewController:newVC animated:NO completion:nil];
}

@end
