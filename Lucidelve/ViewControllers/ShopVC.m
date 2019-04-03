//
//  ShopVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-06.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "ShopVC.h"
#import "ShopView.h"
#import "Game.h"
#import "Player.h"
#import "Constants.h"
#import "Item.h"
#import "Renderer.h"
#import "Primitives.h"
#import "../Renderer/Assets.h"
#import "AudioPlayer.h"

@interface ShopVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's UI elements
    UILabel *goldLabel;
    UIButton *swordButton;
    UIButton *potionButton;
    UIButton *heartButton;
    UIButton *bombButton;
    UIButton *shieldButton;
    
    Mesh *bgMesh;
    Mesh *swordMesh, *potionMesh, *heartMesh, *bombMesh, *shieldMesh;
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
    goldLabel = ((ShopView*) self.view).goldLabel;
    swordButton = ((ShopView*) self.view).swordButton;
    potionButton = ((ShopView*) self.view).potionButton;
    heartButton = ((ShopView*) self.view).heartButton;
    bombButton = ((ShopView*) self.view).bombButton;
    shieldButton = ((ShopView*) self.view).shieldButton;
    
    // Initialize UI elements
    [swordButton addTarget:self action:@selector(onSwordButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    [potionButton addTarget:self action:@selector(onPotionButtonPress:)
           forControlEvents:UIControlEventTouchDown];
    [heartButton addTarget:self action:@selector(onHeartButtonPress:)
           forControlEvents:UIControlEventTouchDown];
    [bombButton addTarget:self action:@selector(onBombButtonPress:)
           forControlEvents:UIControlEventTouchDown];
    [shieldButton addTarget:self action:@selector(onShieldButtonPress:)
           forControlEvents:UIControlEventTouchDown];
    
    bgMesh = [Primitives square];
    [bgMesh setScale:GLKVector3Make(2.5f, 4.0f, 1)];
    [bgMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_SHOP_BG]];
    
    shieldMesh = [[Assets getInstance] getMesh:KEY_MESH_SHIELD];
    [shieldMesh setScale:GLKVector3Make(0.10f, 0.10f, 0.10f)];
    [shieldMesh setPosition:GLKVector3Make(0.4f, -0.3f, 1.0f)];
    [shieldMesh setRotation:GLKVector3Make(0, -M_PI / 4, 0)];
	[shieldMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_SHIELD]];
    swordMesh = [[Assets getInstance] getMesh:KEY_MESH_SWORD];
    [swordMesh setScale:GLKVector3Make(0.15f, 0.15f, 0.15f)];
    [swordMesh setPosition:GLKVector3Make(-0.4f, -0.2, 1.0f)];
    [swordMesh setRotation:GLKVector3Make(M_PI / 4, M_PI, -M_PI / 6)];
	[swordMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_SWORD]];
    heartMesh = [[Assets getInstance] getMesh:KEY_MESH_HEART];
    [heartMesh setScale:GLKVector3Make(0.2f, 0.2f, 0.2f)];
    [heartMesh setPosition:GLKVector3Make(0, -0.5f, 1.0f)];
    [heartMesh setRotation:GLKVector3Make(0, -M_PI / 4, 0)];
	[heartMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_HEART]];
    bombMesh = [[Assets getInstance] getMesh:KEY_MESH_BOMB];
    [bombMesh setScale:GLKVector3Make(0.1f, 0.1f, 0.1f)];
    [bombMesh setPosition:GLKVector3Make(-0.4f, -0.9f, 1.0f)];
    [bombMesh setRotation:GLKVector3Make(0, -M_PI / 4, 0)];
	[bombMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_BOMB]];
    potionMesh = [[Assets getInstance] getMesh:KEY_MESH_POTION];
    [potionMesh setScale:GLKVector3Make(0.08f, 0.08f, 0.08f)];
    [potionMesh setPosition:GLKVector3Make(0.4f, -0.9f, 1.0f)];
    [potionMesh setRotation:GLKVector3Make(0, -M_PI / 4, 0)];
	[potionMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_POTION]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [self updateGoldLabel];
    
    // The sword can only be bought once
    if (self.game.isSwordBought)
    {
        [swordButton setEnabled:NO];
    }
    
    // If all the heart cookies have been purchased, disable the button
    if (self.game.numLifeUpgrades >= MAX_LIFE_UPGRADES)
    {
        [heartButton setEnabled:NO];
    }
    
    [super update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    
    [self.renderer renderMesh:bgMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
    
    [self.renderer renderMesh:shieldMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:bombMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:potionMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    
    if (!self.game.isSwordBought)
    {
        [self.renderer renderMesh:swordMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    }
    
    if (self.game.numLifeUpgrades < MAX_LIFE_UPGRADES)
    {
        [self.renderer renderMesh:heartMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    }
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
 * @brief Buy an item, given its type.
 * If the player has enough gold, this should give the player a
 * specified item and decrease the player's gold by the price.
 * @author Henry Loo
 *
 * @param itemType The type of item to buy
 */
- (void)buyItem:(ItemType)itemType
{
    Item item = ITEMS[itemType];
    if ([player getGold] >= item.shopPrice)
    {
        [player addItem:item];
        [player addGold:(-item.shopPrice)];
        
        if (itemType == ITEM_RUSTY_SWORD)
        {
            self.game.isSwordBought = true;
        }
        
        [[AudioPlayer getInstance] play:KEY_SOUND_BUY];
    }
}

/*!
 * @brief Handle the sword button's action.
 * This should give the player a Rusty Sword if they
 * have enough gold.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onSwordButtonPress:(id)sender
{
    [self buyItem:ITEM_RUSTY_SWORD];
}

/*!
 * @brief Handle the healing potion button's action.
 * This should give the player a Healing Potion if they
 * have enough gold.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onPotionButtonPress:(id)sender
{
    [self buyItem:ITEM_HEALING_POTION];
}

/*!
 * @brief Handle the heart cookie button's action.
 * This should increase the player's max life by 1 if they
 * have enough gold and there are still available upgrades.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onHeartButtonPress:(id)sender
{
    Item item = ITEMS[ITEM_HEART_COOKIE];
    if ([player getGold] >= item.shopPrice)
    {
        [player addGold:(-item.shopPrice)];
        self.game.numLifeUpgrades++;
        
        // Increment the player's max life and then heal them to full
        [player addMaxLife:1];
        [player reset:true];
        
        [[AudioPlayer getInstance] play:KEY_SOUND_BUY];
    }
}

/*!
 * @brief Handle the bomb button's action.
 * This should give the player a Bomb if they
 * have enough gold.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onBombButtonPress:(id)sender
{
    [self buyItem:ITEM_BOMB];
}

/*!
 * @brief Handle the shield button's action.
 * This should give the player a Shield if they
 * have enough gold.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onShieldButtonPress:(id)sender
{
    [self buyItem:ITEM_SHIELD];
}

@end
