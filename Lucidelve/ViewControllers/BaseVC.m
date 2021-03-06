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
#import "../Renderer/Renderer.h"
#import "../Renderer/Camera.h"
#import "../Renderer/Assets.h"
#import "../Renderer/Mesh.h"
#import "AudioPlayer.h"

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
    
    // Instantiate renderer if it doesn't exist yet
    GLKView *view = (GLKView *)self.view;
    if (!_renderer)
    {
        _renderer = [[Renderer alloc] initWithView:view];
        
        // Only load all the resources once
        [[Assets getInstance] loadResources];
    }
    else
    {
        // Just set this view's context if the renderer already exists
        [_renderer initViewValues:view];
        
        // Need to reload shaders
        [[Assets getInstance] loadShaders];
    }
    
    self.camera = [[Camera alloc] initWithPosition:GLKVector3Make(0, 0, 3)];
    
    [self.renderer setCamera:_camera];
    
    // Set UI element pointers
    backButton = ((BaseView*) self.view).backButton;
    
    // Attach selector to the back button
    if (backButton)
    {
        [backButton addTarget:self action:@selector(onBackButtonPress:)
             forControlEvents:UIControlEventTouchDown];
    }
    
    // Instantiate the Game instance if it doesn't exist yet
    if (!_game)
    {
        _game = [[Game alloc] init];
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
}

- (void)jiggleMesh:(Mesh *)mesh forward:(bool *)forward {
    if (*forward) {
        [mesh setRotation:GLKVector3Make([mesh rotation].x, [mesh rotation].y - 0.05f, [mesh rotation].z)];
    } else {
        [mesh setRotation:GLKVector3Make([mesh rotation].x, [mesh rotation].y + 0.05f, [mesh rotation].z)];
    }
    
    if (mesh.rotation.y > M_PI / 4) {
        [mesh setRotation:GLKVector3Make([mesh rotation].x,  M_PI / 4 - 0.05f, [mesh rotation].z)];
        *forward = !*forward;
    } else if (mesh.rotation.y < -M_PI / 4) {
        [mesh setRotation:GLKVector3Make([mesh rotation].x, -M_PI / 4 + 0.05f, [mesh rotation].z)];
        *forward = !*forward;
    }
}

- (void)onBackButtonPress:(id)sender
{
    [[AudioPlayer getInstance] play:KEY_SOUND_SELECT];
    
    HubVC *vc = [[HubVC alloc] init];
    [_game changeScene:self newVC:vc];
}

@end
