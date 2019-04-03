//
//  DungeonsVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-13.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "HighscoreVC.h"
#import "Game.h"
#import "../Views/HighscoreView.h"
#import "Renderer.h"
#import "Primitives.h"
#import "AudioPlayer.h"
#import "../Renderer/Primitives.h"
#import "../Renderer/Assets.h"

@interface HighscoreVC ()
{
    // Pointer to the view's dungeons tableview
    UITableView *scores;
    
    Mesh *bgMesh;
}
@end

@implementation HighscoreVC

- (void)loadView
{
    HighscoreView *view = [[HighscoreView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Initialize items list
    scores = ((HighscoreView*) self.view).scores;
    scores.delegate = self;
    scores.dataSource = self;
    [scores registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    bgMesh = [Primitives square];
    [bgMesh setScale:GLKVector3Make(2.5f, 4.0f, 1)];
    [bgMesh setPosition:GLKVector3Make(0, 0, -0.1)];
    [bgMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_HUB_BG]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    [super update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    [self.renderer renderMesh:bgMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_PASSTHROUGH]];
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
    cell.textLabel.text = @"0";
    
    return cell;
}

@end
