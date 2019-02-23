//
//  BaseVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BaseVC.h"
#import "Game.h"
#import "HubVC.h"
#import "BaseView.h"
#import "Renderer.h"

@interface BaseVC ()
{
    // Pointer to the view's back button
    UIButton *backButton;
}
@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Instantiate the Game instance if it doesn't exist yet
    if (!_game)
    {
        _game = [[Game alloc] init];
    }
    
    // Initialize renderer
    GLKView *view = (GLKView *)self.view;
    _renderer = [[Renderer alloc] initWithView:view];
    
    // Set UI element pointers
    backButton = ((BaseView*) self.view).backButton;
    
    // Attach selector to the back button
    if (backButton)
    {
        [backButton addTarget:self action:@selector(onBackButtonPress:)
             forControlEvents:UIControlEventTouchDown];
    }
}

- (void)update
{
    // Calculate deltaTime for this frame
    _game.deltaTime = [_game.lastTime timeIntervalSinceNow];
    _game.lastTime = [NSDate date];
    
    // Decrement cooldown timer and make sure it doesn't
    // drop lower than 0
    _game.goldCooldownTimer += _game.deltaTime;
    _game.goldCooldownTimer = MAX(0, _game.goldCooldownTimer);
    
    // Update the Golden Goose timer if it has been unlocked
    if (_game.isGooseUnlocked)
    {
        [_game updateGooseGold];
    }
    
    [_renderer update:self.game.deltaTime];
}

- (void)onBackButtonPress:(id)sender
{
    HubVC *vc = [[HubVC alloc] init];
    [_game changeScene:self newVC:vc];
}

@end
