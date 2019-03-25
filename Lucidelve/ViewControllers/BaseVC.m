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
    // Initialize renderer
    GLKView *view = (GLKView *)self.view;
    self.renderer = [[Renderer alloc] initWithView:view];
    
    [[Assets getInstance] loadResources];
    
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
        mesh._rotation = GLKVector3Make(mesh._rotation.x, mesh._rotation.y - 0.05f, mesh._rotation.z);
    } else {
        mesh._rotation = GLKVector3Make(mesh._rotation.x, mesh._rotation.y + 0.05f, mesh._rotation.z);
    }
    
    if (mesh._rotation.y > M_PI / 4) {
        mesh._rotation = GLKVector3Make(mesh._rotation.x, M_PI / 4 - 0.05f, mesh._rotation.z);
        *forward = !*forward;
    } else if (mesh._rotation.y < -M_PI / 4) {
        mesh._rotation = GLKVector3Make(mesh._rotation.x, -M_PI / 4 + 0.05f, mesh._rotation.z);
        *forward = !*forward;
    }
}

- (void)onBackButtonPress:(id)sender
{
    HubVC *vc = [[HubVC alloc] init];
    [_game changeScene:self newVC:vc];
}

@end
