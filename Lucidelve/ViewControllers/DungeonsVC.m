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
#import "Constants.h"

@interface DungeonsVC ()
{
    // Pointer to the view's dungeons tableview
    UITableView *dungeons;
    
    // UI element pointers
    UILabel *descriptionLabel;
    UIButton *startButton;
    
    Mesh *bgMesh;
    Mesh *door;
    bool jiggleDoor;
    
    // The index of the selected dungeon
    int selectedDungeon;
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
    
    // Set UI element pointers
    descriptionLabel = ((DungeonsView*) self.view).descriptionLabel;
    startButton = ((DungeonsView*) self.view).startButton;
    [startButton addTarget:self action:@selector(onStartButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    
    bgMesh = [Primitives square];
    [bgMesh setScale:GLKVector3Make(2.5f, 4.0f, 1)];
    [bgMesh setPosition:GLKVector3Make(0, 0, -0.1)];
    [bgMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_HUB_BG]];
    
    door = [[Assets getInstance] getMesh:KEY_MESH_DOOR];
    [door setScale:GLKVector3Make(0.25, 0.25, 0.25)];
    [door setPosition:GLKVector3Make(0, 0.1, 1.0f)];
    //[door setRotation:GLKVector3Make(M_PI / 6, -M_PI / 4, 0)];
    [door addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_DOOR]];
    
    // Start with no dungeon selected
    selectedDungeon = NO_SELECTED_DUNGEON;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)update
{
    [super update];
    
    [self updateDescriptionLabel];
    [self updateStartButton];
    
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
    return MIN(self.game.numDungeonsCleared + 1, [self.game getNumDungeons]);
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
    // Deselect the dungeon if the same row has been selected, otherwise set the selected dungeon
    selectedDungeon = (selectedDungeon == indexPath.row) ? NO_SELECTED_DUNGEON : indexPath.row;
    
    if (![self isDungeonSelected])
    {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    }
    else
    {
        // Selected a dungeon
        [[AudioPlayer getInstance] play:KEY_SOUND_SELECT];
    }
}

/*!
 * @brief Check if a dungeon has been selected.
 * @author Henry Loo
 *
 * @return Whether an dungeon has been selected or not.
 */
- (bool)isDungeonSelected
{
    return selectedDungeon != NO_SELECTED_DUNGEON;
}

/*!
 * @brief Update the description label's text.
 * @author Henry Loo
 */
- (void)updateDescriptionLabel
{
    if (![self isDungeonSelected])
    {
        descriptionLabel.text = @"Select your adventure...";
    }
    else
    {
        // Show the high score for the currently selected dungeon
        float score = self.game.highscores[selectedDungeon].floatValue;
        if (score == 0)
        {
            descriptionLabel.text = [NSString stringWithFormat:@"Best time - NOT CLEARED"];
        }
        else
        {
            int minutes = (int) (score / 60) % 60;
            int seconds = (int) score % 60;
            int milliseconds = (int) ((score - floor(score)) * 1000);

            descriptionLabel.text = [NSString stringWithFormat:@"Best time - %02i:%02i:%03i",
                                     minutes, seconds, milliseconds];
        }
    }
}

/*!
 * @brief Update the start button's visuals.
 * @author Henry Loo
 */
- (void)updateStartButton
{
    if ([self isDungeonSelected])
    {
        startButton.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0 alpha:0.8];
        startButton.layer.borderWidth = 1;
        [startButton setEnabled:true];
    }
    else
    {
        startButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        startButton.layer.borderWidth = 0;
        [startButton setEnabled:false];
    }
}

/*!
 * @brief Handle the start button's action.
 * Start the dungeon run with the currently selected dungeon.
 * @author Henry Loo
 *
 * @param sender The pressed button
 */
- (void)onStartButtonPress:(id)sender
{
    // No dungeon selected, so just return
    if (![self isDungeonSelected]) return;
    
    [[AudioPlayer getInstance] play:KEY_SOUND_DUNGEON_ENTER];
    
    // Move to the Combat scene
    CombatVC *vc = [[CombatVC alloc] init];
    
    // Set the current dungeon to the selected one
    Dungeon *dungeon = [self.game getDungeon:selectedDungeon];
    vc.currentDungeon = dungeon;
    vc.dungeonNumber = selectedDungeon + 1;
    
    [self.game changeScene:self newVC:vc];
}

@end
