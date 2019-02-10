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

- (void)onBackButtonPress:(id)sender
{
    [super onBackButtonPress:sender];
}

@end
