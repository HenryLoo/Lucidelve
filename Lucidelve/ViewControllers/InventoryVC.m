//
//  InventoryVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "InventoryVC.h"
#import "Player.h"
#import "Game.h"
#import "InventoryView.h"
#import "Renderer.h"
#import "Constants.h"

@interface InventoryVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's items tableview
    UITableView *items;
    
    // Pointer to UI elements
    UILabel *item1Label;
    UILabel *item2Label;
    UIButton *item1Button;
    UIButton *item2Button;
    
    // The index of the selected item
    int selectedItem;
}
@end

@implementation InventoryVC

- (void)loadView
{
    InventoryView *view = [[InventoryView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Initialize items list
    items = ((InventoryView*) self.view).items;
    items.delegate = self;
    items.dataSource = self;
    [items registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    // Set the UI element pointers
    item1Label = ((InventoryView*) self.view).item1Label;
    item2Label = ((InventoryView*) self.view).item2Label;
    item1Button = ((InventoryView*) self.view).item1Button;
    item2Button = ((InventoryView*) self.view).item2Button;
    
    // Initialize UI elements
    [item1Button addTarget:self action:@selector(onItem1ButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    [item2Button addTarget:self action:@selector(onItem2ButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    
    // Start with no item selected
    selectedItem = NO_SELECTED_ITEM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [super update];
    [self updateSelectedItem];
    [self updateItemLabels];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer render:self.game.deltaTime drawInRect:rect];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [player getNumItems];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Show the item's name for this row
    cell.textLabel.text = [player getItem:indexPath.row].name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect the item if the same row has been selected, otherwise set the selected item
    selectedItem = (selectedItem == indexPath.row) ? NO_SELECTED_ITEM : indexPath.row;
    
    if (![self isItemSelected])
    {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    }
}

/*!
 * @brief Handle the item 1 button's action.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onItem1ButtonPress:(id)sender
{
    [self onItemButtonPress:0];
}

/*!
 * @brief Handle the item 2 button's action.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onItem2ButtonPress:(id)sender
{
    [self onItemButtonPress:1];
}

- (void)onItemButtonPress:(int)itemSlot
{
    // If an item has been selected
    if ([self isItemSelected])
    {
        // If the selected item is equippable
        Item item = [player getItem:selectedItem];
        if (item.isEquippable)
        {
            // Equip the item
            [player equipItem:selectedItem withItemSlot:itemSlot];
        }
    }
    // Otherwise, unequip the equipped item
    else
    {
        [player unequipItem:itemSlot];
    }
    
    // Reload the table to reflect the changes
    [items reloadData];
    
    // Deselect the item
    selectedItem = NO_SELECTED_ITEM;
}

/*!
 * @brief Check if an item has been selected.
 * @author Henry Loo
 *
 * @return Whether an item has been selected or not.
 */
- (bool)isItemSelected
{
    return selectedItem != NO_SELECTED_ITEM;
}

/*!
 * @brief Update the colour of item 1 and item 2 slots based on whether an
 * item has been selected.
 * @author Henry Loo
 */
- (void)updateSelectedItem
{
    UIColor *colour = [self isItemSelected] ? UIColor.blueColor : UIColor.darkGrayColor;
    item1Button.backgroundColor = item2Button.backgroundColor = colour;
}

/*!
 * @brief Update the labels for item 1 and item 2.
 * @author Henry Loo
 */
- (void)updateItemLabels
{
    item1Label.text = [player getEquippedItem:0].name;
    item2Label.text = [player getEquippedItem:1].name;
}

@end
