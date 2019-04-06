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
#import "../Renderer/Assets.h"
#import "AudioPlayer.h"

@interface BlacksmithVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to UI elements
    UILabel *goldLabel;
    UILabel *infoLabel;
    UILabel *swordLabel;
    UIButton *upgradeButton;
    
    // The next upgrade's gold price.
    int upgradePrice;
    
    Mesh *bgMesh;
    Mesh *anvil;
    
    float anvilRotation;
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
    infoLabel = ((BlacksmithView*) self.view).infoLabel;
    swordLabel = ((BlacksmithView*) self.view).swordLabel;
    upgradeButton = ((BlacksmithView*) self.view).upgradeButton;
    
    // Attach selector to the upgrade button
    [upgradeButton addTarget:self action:@selector(onUpgradeButtonPress:)
            forControlEvents:UIControlEventTouchDown];
    
    upgradePrice = [self getUpgradePrice];
    [self updateSwordLabel];
    
    bgMesh = [Primitives square];
    [bgMesh setScale:GLKVector3Make(2.5f, 4.0f, 1)];
    [bgMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_BLACKSMITH_BG]];
    
    anvil = [[Assets getInstance] getMesh:KEY_MESH_ANVIL];
    [anvil setScale:GLKVector3Make(0.3f, 0.3f, 0.3f)];
    [anvil setPosition:GLKVector3Make(0, -0.1, 1.0f)];
    [anvil addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_ANVIL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [super update];
    
    [self updateGoldLabel];
    [self updateInfoLabel];
    [self updateUpgradeButton];
    
    [anvil setRotation:GLKVector3Make(M_PI / 6, anvilRotation, 0)];
    anvilRotation += (self.game.deltaTime * M_PI / 6);
    if (anvilRotation < 0)
    {
        anvilRotation = 2 * M_PI - anvilRotation;
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    
    [self.renderer renderMesh:bgMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
    [self.renderer renderMesh:anvil program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
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
 * @brief Update the info label's values.
 * @author Henry Loo
 */
- (void)updateInfoLabel
{
    // If there are still upgrades available
    if (self.game.numBlacksmithUpgrades < MAX_BLACKSMITH_UPGRADES)
    {
        infoLabel.text = @"\"Got some gold?\nLet me sharpen that sword for you!\"";
    }
    // All upgrades have been purchased and the player owns the Golden Egg
    else if ([player hasItem:ITEMS[ITEM_GOLDEN_EGG]])
    {
        infoLabel.text =  @"\"Hold on! Is that a Golden Egg?\nI can melt that down to enchant \nyour sword!\"";
    }
    // All upgrades have been purchased and the player doesn't own the Golden Egg
    else
    {
        infoLabel.text = @"\"That's all I can do for you.\nThat sword is already as sharp as \nI can make it!\"";
    }
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
    // If there are still upgrades available
    if (self.game.numBlacksmithUpgrades < MAX_BLACKSMITH_UPGRADES)
    {
        int price = upgradePrice;
        NSString *title = [NSString stringWithFormat:@"UPGRADE (%i G)", price];
        [upgradeButton setTitle:title forState:UIControlStateNormal];
        [upgradeButton setTitle:title forState:UIControlStateDisabled];
        
        // Disable the button if the player doesn't have enough gold
        [upgradeButton setEnabled:([player getGold] >= price)];
    }
    // All upgrades have been purchased and the player owns the Golden Egg
    else if ([player hasItem:ITEMS[ITEM_GOLDEN_EGG]])
    {
        NSString *title = [NSString stringWithFormat:@"UPGRADE (1 Golden Egg)"];
        [upgradeButton setTitle:title forState:UIControlStateNormal];
        [upgradeButton setEnabled:TRUE];
    }
    // All upgrades have been purchased and the player doesn't own the Golden Egg
    else
    {
        [upgradeButton setTitle:@"FULLY UPGRADED" forState:UIControlStateDisabled];
        [upgradeButton setEnabled:false];
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
        
        Item currentSword = ITEMS[SWORD_UPGRADES[self.game.numBlacksmithUpgrades]];
        self.game.numBlacksmithUpgrades++;
        Item newSword = ITEMS[SWORD_UPGRADES[self.game.numBlacksmithUpgrades]];
        
        // Replace the old sword with the next upgrade
        [player removeItem:currentSword];
        [player addItem:newSword];
        
        upgradePrice = [self getUpgradePrice];
        [self updateSwordLabel];
        
        // If purchasing the upgrade for Magic Goose Sword, pay with the Golden Egg
        if (SWORD_UPGRADES[self.game.numBlacksmithUpgrades] == ITEM_MAGIC_GOOSE_SWORD)
        {
            [player removeItem:ITEMS[ITEM_GOLDEN_EGG]];
        }
        
        [[AudioPlayer getInstance] play:KEY_SOUND_BLACKSMITH_UPGRADE];
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
    if (self.game.numBlacksmithUpgrades < MAX_BLACKSMITH_UPGRADES)
    {
        return BLACKSMITH_BASE_PRICE * pow(BLACKSMITH_PRICE_MULTIPLIER, self.game.numBlacksmithUpgrades);
    }
    else
    {
        // The Magic Goose Sword doesn't cost gold
        return 0;
    }
}

@end
