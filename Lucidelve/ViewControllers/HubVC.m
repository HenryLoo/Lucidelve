//
//  HubVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-01.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HubVC.h"
#import "../Views/HubView.h"
#import "ShopVC.h"
#import "InventoryVC.h"
#import "DungeonsVC.h"
#import "GooseVC.h"
#import "BlacksmithVC.h"
#import "../Game.h"
#import "../Player.h"
#import "../Constants.h"
#import "../Renderer/Mesh.h"
#import "../Renderer/Primitives.h"
#import "../Renderer/Assets.h"

@interface HubVC ()
{
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
    
    // Pointer to the view's dungeons button
    UIButton *dungeonsButton;
    
    // Pointer to the view's Golden Goose button
    UIButton *gooseButton;
    
    // Pointer to the view's Blacksmith button
    UIButton *blacksmithButton;
    
    // TODO: replace placeholder mesh
    Mesh *mesh;
    
    Mesh *anvil, *money, *door, *bag, *goldenGoose;
    bool jiggleAnvil, jiggleMoney, jiggleDoor, jiggleBag, jiggleGoose;
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
    
    // Set UI element pointers
    goldButton = ((HubView*) self.view).goldButton;
    goldLabel = ((HubView*) self.view).goldLabel;
    shopButton = ((HubView*) self.view).shopButton;
    inventoryButton = ((HubView*) self.view).inventoryButton;
    dungeonsButton = ((HubView*) self.view).dungeonsButton;
    gooseButton = ((HubView*) self.view).gooseButton;
    blacksmithButton = ((HubView*) self.view).blacksmithButton;
    
    // Attach selector to the gold button
    [goldButton addTarget:self action:@selector(onGoldButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Shop button
    [shopButton addTarget:self action:@selector(onShopButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Inventory button
    [inventoryButton addTarget:self action:@selector(onInventoryButtonPress:)
              forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Dungeons button
    [dungeonsButton addTarget:self action:@selector(onDungeonsButtonPress:)
             forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Golden Goose button
    [gooseButton addTarget:self action:@selector(onGooseButtonPress:)
             forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the Blacksmith button
    [blacksmithButton addTarget:self action:@selector(onBlacksmithButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    
    // TODO: replace placeholder art
    mesh = [[Primitives getInstance] square];
    mesh._scale = GLKVector3Make(2.5f, 4.0f, 1);
    [mesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_PLACEHOLDER_HUB]];
    
    anvil = [[Assets getInstance] getMesh:KEY_MESH_ANVIL];
    anvil._scale = GLKVector3Make(0.2f, 0.2f, 0.2f);
    anvil._position = GLKVector3Make(0.4f, 0.8f, 1.0f);
    anvil._rotation = GLKVector3Make(M_PI / 6, -M_PI / 4, 0);
    [anvil addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_ANVIL]];
    money = [[Assets getInstance] getMesh:KEY_MESH_MONEY];
    money._scale = GLKVector3Make(0.2f, 0.2f, 0.2f);
    money._position = GLKVector3Make(-0.4f, 0.8f, 1.0f);
    money._rotation = GLKVector3Make(M_PI / 6, -M_PI / 4, 0);
	[money addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_MONEY]];
    door = [[Assets getInstance] getMesh:KEY_MESH_DOOR];
    door._scale = GLKVector3Make(0.2f, 0.2f, 0.2f);
    door._position = GLKVector3Make(0, 0.5f, 1.0f);
    door._rotation = GLKVector3Make(M_PI / 6, -M_PI / 4, 0);
	[door addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_DOOR]];
    bag = [[Assets getInstance] getMesh:KEY_MESH_BACKPACK];
    bag._scale = GLKVector3Make(0.1f, 0.1f, 0.1f);
    bag._position = GLKVector3Make(-0.4f, 0.2f, 1.0f);
    bag._rotation = GLKVector3Make(M_PI / 6, -M_PI / 4, 0);
    [bag addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_BACKPACK]];
    goldenGoose = [[Assets getInstance] getMesh:KEY_MESH_GOLDEN_GOOSE];
    goldenGoose._scale = GLKVector3Make(0.08f, 0.08f, 0.08f);
    goldenGoose._position = GLKVector3Make(0.4f, 0.2f, 1.0f);
    goldenGoose._rotation = GLKVector3Make(M_PI / 6, -M_PI / 4, 0);
	[goldenGoose addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_GOLDEN_GOOSE]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [super update];
    
    // Update UI elements
    [self updateGoldLabel];
    [self updateGoldCooldown];
    [self updateUnlockables];
    
    [self jiggleMesh:anvil forward:&jiggleAnvil];
    [self jiggleMesh:money forward:&jiggleMoney];
    [self jiggleMesh:door forward:&jiggleDoor];
    [self jiggleMesh:bag forward:&jiggleBag];
    [self jiggleMesh:goldenGoose forward:&jiggleGoose];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    [self.renderer renderMesh:mesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
    
    [self.renderer renderMesh:anvil program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:money program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:door program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:bag program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    [self.renderer renderMesh:goldenGoose program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
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
 * @brief Update the gold button's cooldown by decrementing it by delta time.
 * If the cooldown timer reaches 0, then re-enable the gold button.
 * @author Henry Loo
 */
- (void)updateGoldCooldown
{
    if (self.game.goldCooldownTimer > 0)
    {
        // Disable the button
        [goldButton setEnabled:NO];
        
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
        [goldButton setEnabled:YES];
    }
}

/*!
 * @brief Check if the player has satisfied any conditions to unlock a new menu element.
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
    if (self.game.isInventoryUnlocked || [player getNumItems] > 0)
    {
        [inventoryButton setEnabled:YES];
        self.game.isInventoryUnlocked = true;
    }
    
    // Unlock Dungeons
    if (self.game.isDungeonsUnlocked || self.game.isSwordBought)
    {
        [dungeonsButton setEnabled:YES];
        self.game.isDungeonsUnlocked = true;
    }
    
    // Unlock the Golden Goose
    if (self.game.isGooseUnlocked || [player getGold] >= 100)
    {
        [gooseButton setEnabled:YES];
        self.game.isGooseUnlocked = true;
    }
    
    // Unlock the Blacksmith
    if (self.game.isBlacksmithUnlocked ||
        (self.game.isSwordBought && [player getGold] >= 150))
    {
        [blacksmithButton setEnabled:YES];
        self.game.isBlacksmithUnlocked = true;
    }
}

/*!
 * @brief Handle the gold button's action.
 * This should increment the player's gold and disable the button.
 * @author Henry Loo
 *
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
 * @brief Handle the Shop button's action.
 * This should redirect the player to the Shop view.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onShopButtonPress:(id)sender
{
    ShopVC *vc = [[ShopVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * @brief Handle the Inventory button's action.
 * This should redirect the player to the Inventory view.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onInventoryButtonPress:(id)sender
{
    InventoryVC *vc = [[InventoryVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * @brief Handle the Dungeons button's action.
 * This should redirect the player to the Dungeon view.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onDungeonsButtonPress:(id)sender
{
    DungeonsVC *vc = [[DungeonsVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * @brief Handle the Golden Goose button's action.
 * This should redirect the player to the Golden Goose view.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onGooseButtonPress:(id)sender
{
    GooseVC *vc = [[GooseVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

/*!
 * @brief Handle the Blacksmith button's action.
 * This should redirect the player to the Blacksmith view.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onBlacksmithButtonPress:(id)sender
{
    BlacksmithVC *vc = [[BlacksmithVC alloc] init];
    [self.game changeScene:self newVC:vc];
}

@end
