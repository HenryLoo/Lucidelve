//
//  BlacksmithVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-24.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "BlacksmithVC.h"
#import "BlacksmithView.h"
#import "Game.h"
#import "Player.h"
#import "Renderer.h"
#import "Constants.h"
#import "Primitives.h"

@interface BlacksmithVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to UI elements
    UILabel *goldLabel;
    UILabel *swordLabel;
    UIButton *upgradeButton;
    
    // The next upgrade's gold price.
    int upgradePrice;
    
    // TODO: replace placeholder mesh
    Mesh *mesh;
}
@end

@implementation BlacksmithVC

- (void)loadView
{
    BlacksmithView *view = [[BlacksmithView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Set UI element pointers
    goldLabel = ((BlacksmithView*) self.view).goldLabel;
    swordLabel = ((BlacksmithView*) self.view).swordLabel;
    upgradeButton = ((BlacksmithView*) self.view).upgradeButton;
    
    // Attach selector to the upgrade button
    [upgradeButton addTarget:self action:@selector(onUpgradeButtonPress:)
            forControlEvents:UIControlEventTouchDown];
    
    upgradePrice = [self getUpgradePrice];
    [self updateSwordLabel];
    
    // TODO: replace placeholder art
    Texture *texture = [[Texture alloc] initWithFilename:"placeholder_blacksmith.png"];
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
 * @brief Update the sword label's values.
 * @author Henry Loo
 */
- (void)updateSwordLabel
{
    NSString *labelText = [NSString stringWithFormat:@"%@ (ATK: %i)",
                           ITEMS[SWORD_UPGRADES[self.game.numBlacksmithUpgrades]].name,
                           [self.game getSwordDamage]];
    swordLabel.text = labelText;
}

/*!
 * @brief Update the upgrade button's title.
 * @author Henry Loo
 */
- (void)updateUpgradeButton
{
    // Maximum number of upgrades reached, don't allow any more
    if (self.game.numBlacksmithUpgrades >= MAX_BLACKSMITH_UPGRADES)
    {
        [upgradeButton setTitle:@"FULLY UPGRADED" forState:UIControlStateDisabled];
        [upgradeButton setEnabled:false];
    }
    // Update the button's label to show the price of the next upgrade
    else
    {
        int price = upgradePrice;
        NSString *title = [NSString stringWithFormat:@"UPGRADE (%i G)", price];
        [upgradeButton setTitle:title forState:UIControlStateNormal];
        [upgradeButton setTitle:title forState:UIControlStateDisabled];
        
        // Disable the button if the player doesn't have enough gold
        [upgradeButton setEnabled:([player getGold] >= price)];
    }
}

/*!
 * @brief Handle the upgrade button's action.
 * This should replace the player's sword if they have enough gold to invest.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onUpgradeButtonPress:(id)sender
{
    if ([player getGold] >= upgradePrice)
    {
        [player addGold:-upgradePrice];
        self.game.numBlacksmithUpgrades++;
        [player setSwordLevel:self.game.numBlacksmithUpgrades];
        upgradePrice = [self getUpgradePrice];
        [self updateSwordLabel];
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
    return BLACKSMITH_BASE_PRICE * pow(BLACKSMITH_PRICE_MULTIPLIER, self.game.numBlacksmithUpgrades);
}

@end
