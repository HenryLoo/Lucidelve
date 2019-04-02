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
#import "CombatVC.h"
#import "Renderer.h"
#import "Primitives.h"
#import "AudioPlayer.h"
#import "../Renderer/Primitives.h"
#import "../Renderer/Assets.h"

@interface DungeonsVC ()
{
    // Pointer to the view's dungeons tableview
    UITableView *dungeons;
    
    Mesh *bgMesh;
    Mesh *door;
    bool jiggleDoor;
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
    
    bgMesh = [Primitives square];
    [bgMesh setScale:GLKVector3Make(2.5f, 4.0f, 1)];
    [bgMesh setPosition:GLKVector3Make(0, 0, -0.1)];
    [bgMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_HUB_BG]];
    
    door = [[Assets getInstance] getMesh:KEY_MESH_DOOR];
    [door setScale:GLKVector3Make(0.3, 0.3, 0.3)];
    [door setPosition:GLKVector3Make(0, 0, 1.0f)];
    //[door setRotation:GLKVector3Make(M_PI / 6, -M_PI / 4, 0)];
    [door addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_DOOR]];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)update
{
    [super update];
    
    [self jiggleMesh:door forward:&jiggleDoor];
}
    
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    [self.renderer renderMesh:bgMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
    [self.renderer renderMesh:door program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.game.numDungeonsCleared + 1;
}
    
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Populate the dungeons list with available dungeons
    Dungeon *dungeon = [self.game getDungeon:indexPath.row];
    cell.textLabel.text = dungeon.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[AudioPlayer getInstance] play:KEY_SOUND_DUNGEON_ENTER];
    
    // Move to the Combat scene
    CombatVC *vc = [[CombatVC alloc] init];
    
    // Set the current dungeon to the selected one
    Dungeon *dungeon = [self.game getDungeon:indexPath.row];
    vc.currentDungeon = dungeon;
    vc.dungeonNumber = indexPath.row + 1;
    
    [self.game changeScene:self newVC:vc];
}

@end
