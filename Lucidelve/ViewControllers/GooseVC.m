//
//  GooseVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-22.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "GooseVC.h"
#import "GooseView.h"
#import "Game.h"
#import "Player.h"
#import "Renderer.h"
#import "Constants.h"
#import "Primitives.h"

@interface GooseVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to UI elements
    UILabel *goldLabel;
    UILabel *goldRateLabel;
    UIButton *upgradeButton;
    
    // The next upgrade's gold price.
    int upgradePrice;
    
    // TODO: replace placeholder mesh
    Mesh *mesh;
}
@end

@implementation GooseVC

- (void)loadView
{
    GooseView *view = [[GooseView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Set UI element pointers
    goldLabel = ((GooseView*) self.view).goldLabel;
    goldRateLabel = ((GooseView*) self.view).goldRateLabel;
    upgradeButton = ((GooseView*) self.view).upgradeButton;
    
    // Attach selector to the upgrade button
    [upgradeButton addTarget:self action:@selector(onUpgradeButtonPress:)
            forControlEvents:UIControlEventTouchDown];
    
    upgradePrice = [self getUpgradePrice];
    [self updateGoldRateLabel];
    
    // TODO: replace placeholder art
    Texture *texture = [[Texture alloc] initWithFilename:"placeholder_goose.png"];
    mesh = [[Primitives getInstance] square];
    mesh._scale = GLKVector3Make(1.5f, 1.5f, 1);
    [mesh addTexture:texture];
    [self.renderer addSprite:mesh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [super update];
    
    [self updateGoldLabel];
    [self updateUpgradeButton];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer render:self.game.deltaTime drawInRect:rect];
}

/*!
* @brief Update the gold label's values.
* @author Henry Loo
*/
- (void)updateGoldLabel
{
    int gold = [player getGold];
    NSString *labelText = [NSString stringWithFormat:@"Gold: %i G", gold];
    goldLabel.text = labelText;
}

/*!
 * @brief Update the gold rate label's values.
 * @author Henry Loo
 */
- (void)updateGoldRateLabel
{
    // Format the delay string
    const int SECONDS_PER_MINUTE = 60;
    const int SECONDS_PER_HOUR = SECONDS_PER_MINUTE * 60;
    const int SECONDS_PER_DAY = SECONDS_PER_HOUR * 24;
    
    int delay = self.game.gooseDelay;
    NSString *delayStr;
    if (delay >= SECONDS_PER_DAY)
    {
        delay /= SECONDS_PER_DAY;
        delayStr = @"day(s)";
    }
    else if (delay >= SECONDS_PER_HOUR)
    {
        delay /= SECONDS_PER_HOUR;
        delayStr = @"hr(s)";
    }
    else if (delay >= SECONDS_PER_MINUTE)
    {
        delay /= SECONDS_PER_MINUTE;
        delayStr = @"min(s)";
    }
    else
    {
        delayStr = @"s";
    }
    
    NSString *labelText = [NSString stringWithFormat:@"Rate: %i G per %i %@",
                           self.game.gooseAmount, delay, delayStr];
    goldRateLabel.text = labelText;
}

/*!
 * @brief Update the upgrade button's title.
 * @author Henry Loo
 */
- (void)updateUpgradeButton
{
    // Maximum number of upgrades reached, don't allow any more
    if (self.game.numGooseUpgrades >= MAX_GOOSE_UPGRADES)
    {
        [upgradeButton setTitle:@"FULLY UPGRADED" forState:UIControlStateDisabled];
        [upgradeButton setEnabled:false];
    }
    // Update the button's label to show the price of the next upgrade
    else
    {
        int price = upgradePrice;
        NSString *title = [NSString stringWithFormat:@"FEED (%i G)", price];
        [upgradeButton setTitle:title forState:UIControlStateNormal];
        [upgradeButton setTitle:title forState:UIControlStateDisabled];
        
        // Disable the button if the player doesn't have enough gold
        [upgradeButton setEnabled:([player getGold] >= price)];
    }
}

/*!
 * @brief Handle the upgrade button's action.
 * This should increase the rate of gold generation if the player
 * has enough gold to invest.
 * If the player purchases the final upgrade, they are given a
 * Golden Egg item.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onUpgradeButtonPress:(id)sender
{
    if ([player getGold] >= upgradePrice)
    {
        [player addGold:-upgradePrice];
        self.game.numGooseUpgrades++;
        upgradePrice = [self getUpgradePrice];
        [self.game updateGooseRate];
        
        // Update UI elements
        [self updateGoldRateLabel];
        
        // Give the Golden Egg item if this is the final upgrade
        if (self.game.numGooseUpgrades >= MAX_GOOSE_UPGRADES)
        {
            [player addItem:ITEMS[ITEM_GOLDEN_EGG]];
        }
    }
}

/*!
 * @brief Get the cost for the next upgrade.
 * @author Henry Loo
 *
 * @return The next upgrade's gold price
 */
- (int)getUpgradePrice
{
    return GOOSE_BASE_PRICE * pow(GOOSE_PRICE_MULTIPLIER, self.game.numGooseUpgrades);
}

@end
