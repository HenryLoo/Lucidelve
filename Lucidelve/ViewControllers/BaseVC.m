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
    _renderer = [[Renderer alloc] init];
    GLKView *view = (GLKView *)self.view;
    [_renderer init:view];
    
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
    [_renderer update:self.game.deltaTime];
}

- (void)onBackButtonPress:(id)sender
{
    HubVC *vc = [[HubVC alloc] init];
    [_game changeScene:self newVC:vc];
}

@end
