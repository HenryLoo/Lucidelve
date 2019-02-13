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

@interface ShopVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's gold label
    UILabel *goldLabel;
    
    // Pointer to the view's sword button
    UIButton *swordButton;
    
    // Pointer to the view's healing potion button
    UIButton *potionButton;
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
    
    // Attach selector to the sword button
    [swordButton addTarget:self action:@selector(onSwordButtonPress:)
         forControlEvents:UIControlEventTouchDown];
    
    // Attach selector to the healing potion button
    [potionButton addTarget:self action:@selector(onPotionButtonPress:)
          forControlEvents:UIControlEventTouchDown];
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
 * Buy an item, given its type.
 * If the player has enough gold, this should give the player a
 * specified item and decrease the player's gold by the price.
 * @author Henry Loo
 * @param itemType The type of item to buy
 */
- (void)buyItem:(ItemType)itemType
{
    Item item = ITEMS[itemType];
    if ([player getGold] >= item.shopPrice)
    {
        [player addItem:item];
        [player addGold:(-item.shopPrice)];
        
        if (itemType == RUSTY_SWORD)
        {
            self.game.isSwordBought = true;
        }
    }
}

/*!
 * Handle the sword button's action.
 * This should give the player a Rusty Sword if they
 * have enough gold.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onSwordButtonPress:(id)sender
{
    [self buyItem:RUSTY_SWORD];
}

/*!
 * Handle the healing potion button's action.
 * This should give the player a Healing Potion if they
 * have enough gold.
 * @author Henry Loo
 * @param sender The pressed button
 */
- (void)onPotionButtonPress:(id)sender
{
    [self buyItem:HEALING_POTION];
}

@end
