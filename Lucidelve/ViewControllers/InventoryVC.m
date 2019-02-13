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

@interface InventoryVC ()
{
    // Pointer to the player object
    Player *player;
    
    // Pointer to the view's item scrollview
    UITableView *items;
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
//
    // Set the player pointer
    player = [self.game getPlayer];
    
    // Initialize items list
    items = ((InventoryView*) self.view).items;
    items.delegate = self;
    items.dataSource = self;
    [items registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return player.items.count;
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

@end
