//
//  HubVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-01.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HubVC.h"
#import "HubView.h"
#import "ShopVC.h"
#import "Game.h"
#import "Player.h"
#import "Constants.h"

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
    
    // Pointer to the view's shop button
    UIButton *shopButton;
}

@end

@implementation HubVC

- (void)loadView
{
    HubView *view = [[HubView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lastTime = [NSDate date];
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Set UI element pointers
    goldButton = ((HubView*) self.view).goldButton;
    goldLabel = ((HubView*) self.view).goldLabel;
    shopButton = ((HubView*) self.view).shopButton;
    
    // Attach selector to the gold button
    [goldButton addTarget:self action:@selector(onGoldButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the shop button
    [shopButton addTarget:self action:@selector(onShopButtonPress:)
         forControlEvents:UIControlEventTouchDown];
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
    
    [self updateGoldLabel];
    [self updateGoldCooldown];
    [self updateUnlockables];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
}

/*!
 * Update the gold label's values.
 * @author Henry Loo
 */
- (void)updateGoldLabel
{
    int gold = [player getGold];
    NSString *labelText = [NSString stringWithFormat:@"Gold: %i G", gold];
    goldLabel.text = labelText;
}

/*!
 * Update the gold button's cooldown by decrementing it by delta time.
 * If the cooldown timer reaches 0, then re-enable the gold button.
 * @author Henry Loo
 */
- (void)updateGoldCooldown
{
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

/*!
 * Check if the player has satisfied any conditions to unlock
 * a new menu element.
 * @author Henry Loo
 */
- (void)updateUnlockables
{
    // Unlock the shop
    if ([player getGold] >= 10)
    {
        [shopButton setEnabled:YES];
    }
}

/*!
 * Handle the gold button's action.
 * This should increment the player's gold and disable the button.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onGoldButtonPress:(id)sender
{
    // Increment the player's gold
    [player addGold:GOLD_EARN_AMOUNT];
    
    // Disable the button and put gold generation on cooldown
    [goldButton setEnabled:NO];
    goldCooldownTimer = GOLD_COOLDOWN;
    
}

/*!
 * Handle the shop button's action.
 * This should redirect the player to the shop view.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onShopButtonPress:(id)sender
{
    ShopVC *vc = [[ShopVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

@end
