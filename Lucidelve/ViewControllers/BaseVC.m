//
//  IGameVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseVC.h"
#import "Game.h"

@implementation BaseVC

@synthesize game = _game;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Instantiate the Game instance if it doesn't exist yet
    if (!self.game)
    {
        self.game = [[Game alloc] init];
    }
}

@end
