//
//  DungeonsVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "DungeonsVC.h"
#import "Player.h"
#import "Game.h"
#import "DungeonsView.h"
#import "Dungeon.h"

@interface DungeonsVC ()
{
    // Pointer to the view's dungeons tableview
    UITableView *dungeons;
}
@end

@implementation DungeonsVC
    
- (void)loadView
{
    DungeonsView *view = [[DungeonsView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Initialize items list
    dungeons = ((DungeonsView*) self.view).dungeons;
    dungeons.delegate = self;
    dungeons.dataSource = self;
    [dungeons registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
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
    return [self.game getNumDungeons];
}
    
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // TODO: replace hard-coded dungeon name
    Dungeon *dungeon = [self.game getDungeon:indexPath.row];
    cell.textLabel.text = dungeon.name;
    
    return cell;
}

@end
