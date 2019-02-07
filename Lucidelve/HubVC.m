//
//  HubVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-01.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HubVC.h"
#import "HubView.h"
#import "Player.h"

@interface HubVC ()
{
    // The time for the previous frame
    NSDate *lastTime;
    
    // The time between each frame in seconds
    NSTimeInterval deltaTime;
    
    // Pointer to the player object
    Player *player;
    
    // The current value of the gold button's cooldown.
    // This value should be decremented every frame by deltaTime
    // starting until it reaches 0.
    float goldCooldownTimer;
    
    // Pointer to the view's gold button
    UIButton *goldButton;
    
    // Pointer to the view's gold label
    UILabel *goldLabel;
}

@end

@implementation HubVC

// The cooldown on gold button press, in seconds
const float GOLD_COOLDOWN = 5.f;

// The amount of gold to earn per button press
const int GOLD_EARN_AMOUNT = 5;

- (void)loadView
{
    HubView *view = [[HubView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lastTime = [NSDate date];
    
    // Initialize the player
    player = [[Player alloc] init];
    
    // Attach selector to the gold button
    goldButton = ((HubView*) self.view).goldButton;
    [goldButton addTarget:self action:@selector(onGoldButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    goldLabel = ((HubView*) self.view).goldLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // Calculate deltaTime for this frame
    deltaTime = [lastTime timeIntervalSinceNow];
    lastTime = [NSDate date];
    
    // Update the gold label's values
    int gold = [player getGold];
    NSString *labelText = [NSString stringWithFormat:@"Gold: %i G", gold];
    goldLabel.text = labelText;
    
    // Update the gold button's cooldown
    if (goldCooldownTimer > 0)
    {
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        goldCooldownTimer += deltaTime;
        goldCooldownTimer = MAX(0, goldCooldownTimer);
        
        // Update the button's text to show the remaining
        // cooldown (can't show animations or the text will keep
        // fading to white)
        NSString *cooldown = [NSString stringWithFormat:@"%.02f", goldCooldownTimer];
        [GLKView performWithoutAnimation:^{
            [self->goldButton setTitle:cooldown forState:UIControlStateDisabled];
            [self->goldButton layoutIfNeeded];
        }];
    }
    else
    {
        // Cooldown is over, so re-enable the gold button
        goldCooldownTimer = 0;
        [goldButton setEnabled:YES];
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
}

- (void)onGoldButtonPress:(id)sender
{
    // Increment the player's gold
    [player addGold:GOLD_EARN_AMOUNT];
    
    // Disable the button and put gold generation on cooldown
    [goldButton setEnabled:NO];
    goldCooldownTimer = GOLD_COOLDOWN;
    
}

@end
