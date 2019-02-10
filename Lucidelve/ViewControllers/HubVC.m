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
#import "InventoryVC.h"
#import "Game.h"
#import "Player.h"
#import "Constants.h"

@interface HubVC ()
{
    // Pointer to the glES renderer
    Renderer *renderer;
    
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's gold button
    UIButton *goldButton;
    
    // Pointer to the view's gold label
    UILabel *goldLabel;
    
    // Pointer to the view's shop button
    UIButton *shopButton;
    
    // Pointer to the view's inventory button
    UIButton *inventoryButton;
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
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    renderer = [[Renderer alloc] init];
    GLKView *view = (GLKView *)self.view;
    [renderer init:view];
    
    // Set UI element pointers
    goldButton = ((HubView*) self.view).goldButton;
    goldLabel = ((HubView*) self.view).goldLabel;
    shopButton = ((HubView*) self.view).shopButton;
    inventoryButton = ((HubView*) self.view).inventoryButton;
    
    // Attach selector to the gold button
    [goldButton addTarget:self action:@selector(onGoldButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Shop button
    [shopButton addTarget:self action:@selector(onShopButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Inventory button
    [inventoryButton addTarget:self action:@selector(onInventoryButtonPress:)
         forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // Calculate deltaTime for this frame
    self.game.deltaTime = [self.game.lastTime timeIntervalSinceNow];
    self.game.lastTime = [NSDate date];
    
    [self updateGoldLabel];
    [self updateGoldCooldown];
    [self updateUnlockables];
    
    [renderer update:self.game.deltaTime];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [renderer render:self.game.deltaTime drawRect:rect];
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
    if (self.game.goldCooldownTimer > 0)
    {
        // Disable the button
        [goldButton setEnabled:NO];
        
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        self.game.goldCooldownTimer += self.game.deltaTime;
        self.game.goldCooldownTimer = MAX(0, self.game.goldCooldownTimer);
        
        // Update the button's text to show the remaining
        // cooldown (can't show animations or the text will keep
        // fading to white)
        NSString *cooldown = [NSString stringWithFormat:@"%.02f",
                              self.game.goldCooldownTimer];
        [GLKView performWithoutAnimation:^{
            [self->goldButton setTitle:cooldown forState:UIControlStateDisabled];
            [self->goldButton layoutIfNeeded];
        }];
    }
    else
    {
        // Cooldown is over, so re-enable the gold button
        self.game.goldCooldownTimer = 0;
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
    // Unlock the Shop
    if (self.game.isShopUnlocked || [player getGold] >= 10)
    {
        [shopButton setEnabled:YES];
        self.game.isShopUnlocked = true;
    }
    
    // Unlock Inventory
    if (self.game.isInventoryUnlocked || [player.items count] > 0)
    {
        [inventoryButton setEnabled:YES];
        self.game.isInventoryUnlocked = true;
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
    
    // Put the button on cooldown
    self.game.goldCooldownTimer = GOLD_COOLDOWN;
    
}

/*!
 * Handle the Shop button's action.
 * This should redirect the player to the Shop view.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onShopButtonPress:(id)sender
{
    ShopVC *vc = [[ShopVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * Handle the Inventory button's action.
 * This should redirect the player to the Inventory view.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onInventoryButtonPress:(id)sender
{
    InventoryVC *vc = [[InventoryVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

@end
