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
    
    // TODO: replace placeholder mesh
    Mesh *mesh;
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
    
    // TODO: replace placeholder art
    /*
    mesh = [[Primitives getInstance] square];
    mesh._scale = GLKVector3Make(1.5f, 1.5f, 1);
    [mesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_PLACEHOLDER_SHOP]];
     */
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
    /*
    [self.renderer setupRender:rect];
    
    [self.renderer renderMesh:mesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
     */
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
        [player addMaxLife];
        [player reset:true];
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
