//
//  ShopVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "ShopVC.h"
#import "ShopView.h"
#import "HubVC.h"
#import "Game.h"
#import "Player.h"
#import "Constants.h"
#import "Item.h"

@interface ShopVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's back button
    UIButton *backButton;
    
    // Pointer to the view's gold label
    UILabel *goldLabel;
    
    // Pointer to the view's sword button
    UIButton *swordButton;
}
@end

@implementation ShopVC

- (void)loadView
{
    ShopView *view = [[ShopView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Set UI element pointers
    backButton = ((ShopView*) self.view).backButton;
    goldLabel = ((ShopView*) self.view).goldLabel;
    swordButton = ((ShopView*) self.view).swordButton;
    
    // Attach selector to the back button
    [backButton addTarget:self action:@selector(onBackButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the sword button
    [swordButton addTarget:self action:@selector(onSwordButtonPress:)
         forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [self updateGoldLabel];
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
 * Handle the back button's action.
 * This should redirect the player to The Hub.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onBackButtonPress:(id)sender
{
    HubVC *vc = [[HubVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * Handle the sword button's action.
 * If the player has enough gold, this should give the player a
 * Rusty Sword item and decrease the player's gold by the price.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onSwordButtonPress:(id)sender
{
    Item sword = ITEMS[RUSTY_SWORD];
    if ([player getGold] >= sword.shopPrice)
    {
        [player addItem:sword];
        [player addGold:(-sword.shopPrice)];
        
        // The sword can only be bought once
        [swordButton setEnabled:NO];
    }
}

@end
