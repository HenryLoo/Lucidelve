//
//  CombatVC.m
//  Lucidelve
//
//  Created by Henry Loo on 2019-02-16.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import "CombatVC.h"
#import "Player.h"
#import "Game.h"
#import "CombatView.h"
#import "Renderer.h"
#import "Constants.h"
#import "Dungeon.h"
#import "DungeonNode.h"
#import "HubVC.h"
#import "Utility.h"
#import "Primitives.h"
#import "Assets.h"
#import "AudioPlayer.h"
#import "GameObject.h"
#import "Constants.h"

@interface CombatVC ()
{
    // Pointer to the player instance.
    Player *player;
    
    // Pointer to the current dungeon node.
    DungeonNode *currentNode;
    
    // Pointer to the current enemy.
    Enemy *currentEnemy;
    
    // Flag for if the current node has been cleared.
    bool isNodeCleared;
    
    // Flag for if the player is returning to The Hub.
    bool isReturningToHub;
    
    // The total number of nodes in the current dungeon run.
    int numNodes;
    
    // The number of remaining nodes in the current dungeon run.
    int remainingNodes;
    
    // The total amount of gold earned so far.
    int totalRewardGold;
    
    // The total time that the player has played for during
    // this dungeon run.
    float totalTime;
    
    // Gesture pointers
    UITapGestureRecognizer *tapGesture;
    UISwipeGestureRecognizer *swipeUpGesture;
    UISwipeGestureRecognizer *swipeDownGesture;
    UISwipeGestureRecognizer *swipeLeftGesture;
    UISwipeGestureRecognizer *swipeRightGesture;
    
    // Pointer to UI elements
    UILabel *remainingNodesLabel;
    UILabel *playerLifeLabel;
    UILabel *playerStaminaLabel;
    UILabel *enemyNameLabel;
    UILabel *combatStatusLabel;
    UIButton *item1Button;
    UIButton *item2Button;
    
    Mesh *playerMesh;
    Mesh *enemyMesh;
    Mesh *floorMesh;
    Mesh *leftWallMesh;
    Mesh *rightWallMesh;
    Mesh *backWallMesh;
    Mesh *itemMesh[2];
    
    NSString *itemNames[2];
    GameObject *itemObjects[2];
    GameCharacter *itemTargets[2];
    
    // Position of each character at neutral position
    GLKVector3 playerNeutralPos;
    GLKVector3 enemyNeutralPos;
    
    // Player colour values
    GLKVector4 playerColour;
    float playerColourCurrentTime;
    float playerColourTime;
    
    // Enemy colour values
    GLKVector4 enemyColour;
    float enemyColourCurrentTime;
    float enemyColourTime;
    
    // Flag for if the shield item was used
    // This should be reset after each fight
    bool usedShield;
    
    // Flag for if the intro has been shown yet
    bool hasShownIntro;
}
@end

@implementation CombatVC

- (void)loadView
{
    CombatView *view = [[CombatView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the player pointer
    player = [self.game getPlayer];
    [player reset:true];
    
    isNodeCleared = true;
    
    // Randomize the number of nodes, bounded by the the min and max values.
    numNodes = [[Utility getInstance] random:_currentDungeon.minNumNodes withMax:_currentDungeon.maxNumNodes];
    remainingNodes = numNodes;
    
    // Initialize gestures
    UIView *body = ((BaseView*)self.view).bodyArea;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [body addGestureRecognizer:tapGesture];
    
    swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [body addGestureRecognizer:swipeUpGesture];
    
    swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [body addGestureRecognizer:swipeDownGesture];
    
    swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [body addGestureRecognizer:swipeLeftGesture];
    
    swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [body addGestureRecognizer:swipeRightGesture];
    
    // Set up UI element pointers
    remainingNodesLabel = ((CombatView*) self.view).remainingNodesLabel;
    playerLifeLabel = ((CombatView*) self.view).playerLifeLabel;
    playerStaminaLabel = ((CombatView*) self.view).playerStaminaLabel;
    item1Button = ((CombatView*) self.view).item1Button;
    item2Button = ((CombatView*) self.view).item2Button;
    
    // Initialize UI elements
    [item1Button addTarget:self action:@selector(onItem1ButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    [item2Button addTarget:self action:@selector(onItem2ButtonPress:)
          forControlEvents:UIControlEventTouchDown];
    
    enemyNameLabel = ((CombatView*) self.view).enemyNameLabel;
    combatStatusLabel = ((CombatView*) self.view).combatStatusLabel;
    
    playerMesh = [Primitives square];
    [playerMesh setScale:GLKVector3Make(1, 1, 1)];
    [playerMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_PLAYER_COMBAT]];
    
    floorMesh = [Primitives square];
    [floorMesh setScale:GLKVector3Make(3, 30, 1)];
    [floorMesh setPosition:GLKVector3Make(0, -2, 2)];
    [floorMesh setRotation:GLKVector3Make(-FLOOR_ANGLE, 0, 0)];
    [floorMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.floorTexture]];
    
    leftWallMesh = [Primitives square];
    [leftWallMesh setScale:GLKVector3Make(30, 18, 1)];
    [leftWallMesh setPosition:GLKVector3Make(-2, 6, -5)];
    [leftWallMesh setRotation:GLKVector3Make(0, M_PI / 2, 0)];
    [leftWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
    
    rightWallMesh = [Primitives square];
    [rightWallMesh setScale:GLKVector3Make(30, 18, 1)];
    [rightWallMesh setPosition:GLKVector3Make(2, 6, -5)];
    [rightWallMesh setRotation:GLKVector3Make(0, -M_PI / 2, 0)];
    [rightWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
    
    backWallMesh = [Primitives square];
    [backWallMesh setScale:GLKVector3Make(4, 16, 1)];
    [backWallMesh setPosition:GLKVector3Make(0, 7, -20)];
    [backWallMesh setRotation:GLKVector3Make(0, 0, 0)];
    [backWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
    
    // Initialize character variables
    playerNeutralPos = [self getPositionOnFloor:2.5 scaleY:playerMesh.scale.y];
    player.neutralPos = playerNeutralPos;
    
    // Initialize throwables
    [self initializeItem:0];
    [self initializeItem:1];
    
    // Play the dungeon's music if this isn't the final dungeon
    if (_dungeonNumber < [self.game getNumDungeons])
    {
        [[AudioPlayer getInstance] playMusic:_currentDungeon.music];
    }
    else
    {
        [[AudioPlayer getInstance] stopMusic];
    }
    
    // Initialize intro
    NSString *introStr = [NSString stringWithFormat:@"%@\n- %@ -",
                          _currentDungeon.name, _currentDungeon.intro];
    [self updateCombatStatusLabel:introStr];
    [player reset:false];
    [self updateEnemyLabels];
    [self updatePlayerLabels];
    [self updateRemainingNodes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // If current node is cleared and the dungeon run is not over,
    // then process the next node
    if (isNodeCleared && remainingNodes > 0 && hasShownIntro)
    {
        currentNode = [_currentDungeon getDungeonNode];
        
        NSString *enemyType = [currentNode getEnemyType];
        if (enemyType == nil)
        {
            // No enemy in this node
            currentEnemy = nil;
        }
        else
        {
            // Initialize the enemy
            currentEnemy = [self.game getEnemy:enemyType];
            
            enemyMesh = [Primitives square];
            [enemyMesh setScale:GLKVector3Make(1.5, 1.5, 1.5)];
            [enemyMesh addTexture:[[Assets getInstance] getTexture:currentEnemy.texture]];
            
            enemyNeutralPos = [self getPositionOnFloor:4 scaleY:enemyMesh.scale.y];
            currentEnemy.neutralPos = enemyNeutralPos;
            [currentEnemy reset:true];
            
            [player reset:false];
            usedShield = false;
        }
        
        [self updateCombatStatusLabel:@""];
        isNodeCleared = false;
        remainingNodes--;
        [self updateRemainingNodes];
    }
    // Otherwise, continue performing updates for this node
    else
    {
        [player update:self.game.deltaTime];
        [self updatePlayerLabels];
        
        if (currentEnemy)
        {
            [self processItem:0];
            [self processItem:1];
            
            // The enemy won't block if the player has no stamina
            [currentEnemy update:self.game.deltaTime isAggressive:([player getCurrentStamina] == 0)];
            
            [self processEnemyAttack];
            [self updateEnemyLabels];
        }
    }
    
    [super update];
    
    // Update meshes
    [self updateEquippedMesh:0];
    [self updateEquippedMesh:1];
    
    [playerMesh setPosition:player.position];
    
    if (currentEnemy)
    {
        [enemyMesh setPosition:currentEnemy.position];
    }
    
    // Update colour mixes
    [self updatePlayerColour];
    [self updateEnemyColour];
    
    // Update the total time played while in combat
    if (!isNodeCleared)
    {
        totalTime -= self.game.deltaTime;
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    
    [self.renderer renderWithFog:floorMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:leftWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:rightWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:backWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    
    if (currentEnemy != nil)
    {
        float amount = (enemyColourTime > 0) ? enemyColourCurrentTime / enemyColourTime : 0;
        [self.renderer renderSprite:enemyMesh spriteIndex:currentEnemy.spriteIndex fogColour:_currentDungeon.fogColour textureColour:enemyColour textureColourAmount:amount];
    }
    
    float amount = 0;
    if (playerColourTime == 0)
    {
        if ([player getCurrentStamina] == 0)
        {
            // No stamina, blend black colour with player
            playerColour = GLKVector4Make(0, 0, 0, 1);
            amount = 0.6;
        }
        else if (usedShield)
        {
            // Shield item was used, blend blue colour with player
            playerColour = GLKVector4Make(0.1, 0.1, 1, 1);
            amount = 0.6;
        }
    }
    else
    {
        // Flashing colour, so we determine the amount to mix based on time
        amount = (playerColourTime > 0) ? playerColourCurrentTime / playerColourTime : 0;
    }
    [self.renderer renderSprite:playerMesh spriteIndex:player.spriteIndex fogColour:_currentDungeon.fogColour textureColour:playerColour
            textureColourAmount:amount];
    
    // Render the equipped items
    if (itemMesh[0])
    {
        [self.renderer renderMesh:itemMesh[0] program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    }
    
    if (itemMesh[1])
    {
        [self.renderer renderMesh:itemMesh[1] program:[[Assets getInstance] getProgram:KEY_PROGRAM_BASIC]];
    }
}

- (void)onTap:(UITapGestureRecognizer *)recognizer
{
    if (currentEnemy != nil)
    {
        // If the enemy is dead, clear the node and add reward gold
        // onto the total amount of reward gold.
        if ([currentEnemy getCombatState] == COMBAT_DEAD)
        {
            [[AudioPlayer getInstance] play:KEY_SOUND_SELECT];
            
            isNodeCleared = true;
            totalRewardGold += [currentNode getGoldReward];
            
            // Last enemy was defeated
            if (remainingNodes == 0)
            {
                currentEnemy = nil;
            }
        }
        // Otherwise, perform an attack
        else
        {
            [self performAttack];
        }
    }
    
    // Tap to progress through intro
    if (!hasShownIntro)
    {
        [[AudioPlayer getInstance] play:KEY_SOUND_SELECT];
        hasShownIntro = true;
        [self updateCombatStatusLabel:@""];
        
        // Play the dungeon's music if this the final dungeon
        if (_dungeonNumber == [self.game getNumDungeons])
        {
            [[AudioPlayer getInstance] playMusic:_currentDungeon.music];
        }
    }
    // Show the end message if dungeon run is over
    else if (isNodeCleared && remainingNodes == 0 && currentEnemy == nil
             && !isReturningToHub)
    {
        NSString *stateString;
        if (_dungeonNumber == [self.game getNumDungeons])
        {
            // All dungeons cleared
            stateString = [NSString stringWithFormat:@"With the final dungeon cleared, \nyou can finally escape this dream...\n\nThanks for playing!\n\n<Tap to continue - Total Earned: %i G>", totalRewardGold];
        }
        else
        {
            // Show the end message
            stateString = [NSString stringWithFormat:@"DUNGEON CLEARED!\n<Tap to continue - Total Earned: %i G>",
                           totalRewardGold];
            [self updateCombatStatusLabel:stateString];
        }
        [self updateCombatStatusLabel:stateString];
        
        [[AudioPlayer getInstance] play:KEY_SOUND_COMBAT_WIN];
        isReturningToHub = true;
        
        // Update to match the highest dungeon level cleared
        if (self.game.numDungeonsCleared < _dungeonNumber)
        {
            self.game.numDungeonsCleared = _dungeonNumber;
        }
    }
    // Second tap when dungeon run is over
    else if (isReturningToHub || [player getCurrentLife] == 0)
    {
        [[AudioPlayer getInstance] play:KEY_SOUND_SELECT];
        
        // Set the high score if applicable
        [self setHighScore];
        
        // Return to The Hub with all gold earned
        [player addGold:totalRewardGold];
        HubVC *vc = [[HubVC alloc] init];
        [self.game changeScene:self newVC:vc];
    }
}

- (void)onSwipe:(UISwipeGestureRecognizer *)recognizer
{
    // Must be in combat with an enemy
    if (!currentEnemy || [currentEnemy getCurrentLife] == 0) return;
    
    switch(recognizer.direction)
    {
        case UISwipeGestureRecognizerDirectionUp:
            // Nothing
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            // Block
            [self performBlock];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            // Dodge left
            [self performDodgeLeft];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            // Dodge right
            [self performDodgeRight];
            break;
    }
}

/*!
 * @brief Perform the player's attack.
 * @author Henry Loo
 */
- (void)performAttack
{
    // Can only attack from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        if ([player getCurrentStamina] > 0)
        {
            [player setCombatState:COMBAT_ATTACKING duration:COMBAT_COOLDOWN];
            [self dealSwordDamageToEnemy];
        }
        // Not enough stamina
        else
        {
            [[AudioPlayer getInstance] play:KEY_SOUND_PLAYER_HURT];
        }
    }
}

/*!
 * @brief Inflict damage on the enemy depending on the player's sword.
 * @author Henry Loo
 */
- (void)dealSwordDamageToEnemy
{
    // If the attack is not interruptable or the enemy can block the attack,
    // then don't deal any damage
    bool isInterruptable = currentEnemy.currentAttack.isInterruptable;
    
    // If the enemy blocked the attack, the player loses stamina
    CombatState state = [currentEnemy getCombatState];
    if (state == COMBAT_BLOCKING)
    {
        [player addStamina:-1];
        [[AudioPlayer getInstance] play:KEY_SOUND_ENEMY_BLOCK];
        [self setEnemyColour:GLKVector4Make(1, 1, 1, 1) time:0.2];
    }
    
    if ((state == COMBAT_ALERT && !isInterruptable) ||
        state == COMBAT_BLOCKING)
    {
        return;
    }
    
    // Deal damage depending on the number of sword upgrades
    int damage = -[self.game getSwordDamage];
    
    // If the enemy was stunned, deal double damage
    bool isHurt = (state == COMBAT_HURT);
    NSString *soundKey;
    if (isHurt) damage *= 2;
    
    // If the enemy was attacking, stun it
    bool wasAttacking = (state == COMBAT_ATTACKING);
    [currentEnemy addLife:damage isHurt:wasAttacking];
    if (wasAttacking)
    {
        currentEnemy.actionTimer = ENEMY_STUN_DURATION;
        
        // Reset enemy position
        currentEnemy.position = enemyNeutralPos;
    }
    
    // Play a different sound depending on if the enemy was stunned/dead
    if ([currentEnemy getCombatState] == COMBAT_DEAD)
    {
        soundKey = KEY_SOUND_ENEMY_DEAD;
    }
    else if (isHurt)
    {
        soundKey = KEY_SOUND_ENEMY_STUN_HURT;
    }
    else
    {
        soundKey = KEY_SOUND_ENEMY_HURT;
    }
    [[AudioPlayer getInstance] play:soundKey];
    
    // Set a different colour depending on if the enemy was stunned
    GLKVector4 colour;
    if (isHurt)
    {
        colour = GLKVector4Make(0, 0, 0, 1);
    }
    else
    {
        colour = GLKVector4Make(0, 0, 0, 0.5);
    }
    [self setEnemyColour:colour time:0.2];
}

/*!
 * @brief Inflict damage on the player depending on the enemy's attack.
 * @author Henry Loo
 */
- (void)dealEnemyDamageToPlayer
{
    [player addLife:-currentEnemy.currentAttack.damage isHurt:true];
    player.actionTimer = currentEnemy.currentAttack.attackDelay;
    player.position = playerNeutralPos;
}


/*!
 * @brief Perform the player's blocking action.
 * @author Henry Loo
 */
- (void)performBlock
{
    // Can only block from Neutral or Attacking state
    CombatState state = [player getCombatState];
    bool isNeutral = (state == COMBAT_NEUTRAL && player.actionTimer == 0);
    bool isAttacking = (state == COMBAT_ATTACKING);
    if (isNeutral || isAttacking)
    {
        // Reset player position
        player.position = playerNeutralPos;
        
        [[AudioPlayer getInstance] play:KEY_SOUND_BLOCK];
        [player setCombatState:COMBAT_BLOCKING duration:BLOCK_DURATION];
    }
}

/*!
 * @brief Perform the player's dodge left action.
 * @author Henry Loo
 */
- (void)performDodgeLeft
{
    [self performDodge:true];
}

/*!
 * @brief Perform the player's dodge right action.
 * @author Henry Loo
 */
- (void)performDodgeRight
{
    [self performDodge:false];
}

- (void)performDodge:(bool)isLeft
{
    CombatState dodgeState = isLeft ? COMBAT_DODGING_LEFT : COMBAT_DODGING_RIGHT;
    
    // Can only dodge from Neutral or Attacking state
    CombatState state = [player getCombatState];
    bool isNeutral = (state == COMBAT_NEUTRAL && player.actionTimer == 0);
    bool isAttacking = (state == COMBAT_ATTACKING);
    if (isNeutral || isAttacking)
    {
        // Reset player position
        player.position = playerNeutralPos;
        
        [player setCombatState:dodgeState duration:DODGE_DURATION];
        [self setPlayerColour:GLKVector4Make(1, 1, 1, 0.6) time:0.3];
    }
}

/*!
 * @brief Check to see if the enemy is attacking and whether or
 * not that attack hit the player.
 * @author Henry Loo
 */
- (void)processEnemyAttack
{
    CombatState playerState = [player getCombatState];
    if (playerState == COMBAT_DEAD) return;
    
    // If the enemy is attacking and the player is not blocking a blockable attack or
    // dodging a dodgeable attack
    bool isBlockable = (playerState == COMBAT_BLOCKING && currentEnemy.currentAttack.isBlockable);
    bool isDodgable = ((playerState == COMBAT_DODGING_LEFT || playerState == COMBAT_DODGING_RIGHT)
                       && currentEnemy.currentAttack.isDodgeable);
    if (currentEnemy.isAttacking)
    {
        if (!(isBlockable|| isDodgable) && [player getCombatState] != COMBAT_DEAD)
        {
            // 50% to auto-block if the shield item was used
            if (usedShield)
            {
                int rollBlockChance = [[Utility getInstance] random:1 withMax:100];
                if (rollBlockChance <= 50)
                {
                    [self performBlock];
                    [self performSuccessfulBlock];
                    return;
                }
            }
            
            // Reset player position
            player.position = playerNeutralPos;
            
            [self dealEnemyDamageToPlayer];
            
            // If dead, next tap should return player to The Hub with no rewards
            if ([player getCurrentLife] == 0)
            {
                isReturningToHub = true;
                totalRewardGold = 0;
            }
        }
        else if(isBlockable)
        {
            [self performSuccessfulBlock];
        }
    }
    
    // Just changed to alert state
    if ([currentEnemy getCombatState] == COMBAT_ALERT &&
        [currentEnemy getPrevCombatState] != COMBAT_ALERT)
    {
        // Enemy sprite should flash red when preparing to attack
        [self setEnemyColour:GLKVector4Make(1, 0, 0, 0.8) time:currentEnemy.currentAttack.alertDelay / 2];
    }
}

- (void)performSuccessfulBlock
{
    [[AudioPlayer getInstance] play:KEY_SOUND_PLAYER_BLOCK];
    [self setPlayerColour:GLKVector4Make(1, 1, 1, 1) time:0.3];
    
    // Instantly reset player to neutral if block was successful
    [player setCombatState:COMBAT_NEUTRAL duration:0];
}

- (void)updatePlayerLabels
{
    int currentLife = [player getCurrentLife];
    int maxLife = [player getMaxLife];
    playerLifeLabel.text = [NSString stringWithFormat:@"LIFE: [%i / %i]",
                            currentLife, maxLife];
    
    int currentStamina = [player getCurrentStamina];
    int maxStamina = [player getMaxStamina];
    playerStaminaLabel.text = [NSString stringWithFormat:@"STAM: [%i / %i]",
                               currentStamina, maxStamina];
    
    if ([player getCombatState] == COMBAT_DEAD)
    {
        NSString *text = [NSString stringWithFormat:@"You died!\n<Tap to return to The Hub>"];
        [self updateCombatStatusLabel:text];
    }
}

- (void)updateEnemyLabels
{
    if (!currentEnemy)
    {
        enemyNameLabel.text = @"";
        enemyNameLabel.backgroundColor = UIColor.clearColor;
        return;
    }
    
    NSString *name = [currentEnemy getName];
    int currentLife = [currentEnemy getCurrentLife];
    int maxLife = [currentEnemy getMaxLife];
    enemyNameLabel.text = [NSString stringWithFormat:@"%@ [%i / %i]", name,
                           currentLife, maxLife];
    enemyNameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    if ([currentEnemy getCombatState] == COMBAT_DEAD)
    {
        NSString *text = [NSString stringWithFormat:@"<Tap to continue - Reward: %i G>",
                          [currentNode getGoldReward]];
        [self updateCombatStatusLabel:text];
    }
}

/*!
 * @brief Update the remaining nodes label.
 * @author Henry Loo
 */
- (void)updateRemainingNodes
{
    remainingNodesLabel.text = [NSString stringWithFormat:@"Room: %i/%i",
                                numNodes - remainingNodes, numNodes];
}

/*!
 * @brief Update the combat status label with some text.
 * @author Henry Loo
 *
 * @param text The text to display in the label.
 */
- (void)updateCombatStatusLabel:(NSString *)text
{
    combatStatusLabel.text = text;
    float alpha = (text.length == 0) ? 0 : 0.5;
    combatStatusLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
}

/*!
 * @brief Update the models for the equipped items.
 * @author Henry Loo
 *
 * @param itemSlot The equipped item slot.
 */
- (void)updateEquippedMesh:(int)itemSlot
{
    // Bounds checking
    if (itemSlot < 0 || itemSlot >= MAX_EQUIPPED_ITEMS) return;
    
    if (!itemMesh[itemSlot]) return;
    
    // Don't compare with player's equipped items array, because
    // we want to update even after the item has been consumed
    NSString *itemName = itemNames[itemSlot];
    
    if (itemName == ITEMS[ITEM_HEALING_POTION].name ||
        itemName == ITEMS[ITEM_BOMB].name ||
        itemName == ITEMS[ITEM_SHIELD].name)
    {
        [itemMesh[itemSlot] setScale:itemObjects[itemSlot].scale];
        [itemMesh[itemSlot] setPosition:itemObjects[itemSlot].position];
        [itemMesh[itemSlot] setRotation:itemObjects[itemSlot].rotation];
    }
    else
    {
        itemMesh[itemSlot] = nil;
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
    // Must be in combat with an enemy
    if (!currentEnemy || [currentEnemy getCurrentLife] == 0) return;
    
    // Bounds checking
    if (itemSlot < 0 || itemSlot >= MAX_EQUIPPED_ITEMS) return;
    
    Item item = [player getEquippedItem:itemSlot];
    if (item.name != ITEMS[ITEM_NONE].name && currentEnemy)
    {
        GLKVector3 subPos = GLKVector3MultiplyScalar(itemObjects[itemSlot].position, -1);
        GLKVector3 dist;
        
        if (item.name == ITEMS[ITEM_HEALING_POTION].name ||
            item.name == ITEMS[ITEM_SHIELD].name)
        {
            dist = GLKVector3Add(playerNeutralPos, subPos);
            itemTargets[itemSlot] = player;
        }
        else
        {
            dist = GLKVector3Add(enemyNeutralPos, subPos);
            itemTargets[itemSlot] = currentEnemy;
        }
        
        // Constant horizontal velocities
        float velX = dist.x / THROW_TIME;
        float velZ = dist.z / THROW_TIME;
        
        // Solve for kinematics equations to get initial velocity
        // d = v_i * t + 0.5 * a * t^2
        float velY = dist.y / THROW_TIME - 0.5 * GRAVITY * THROW_TIME;
        
        // Apply velocity and gravity
        itemObjects[itemSlot].velocity = GLKVector3Make(velX, velY, velZ);
        itemObjects[itemSlot].acceleration = GLKVector3Make(0, GRAVITY, 0);
        itemObjects[itemSlot].angularVelocity = GLKVector3Make(0, 0, M_PI / 2);
        
        itemObjects[itemSlot].isThrown = true;
        [player removeEquippedItem:itemSlot];
    }
}

/*!
 * @brief Initialize values for the GameObject corresponding to
 * an equipped item.
 * @author Henry Loo
 *
 * @param itemSlot The equipped item slot.
 */
- (void)initializeItem:(int)itemSlot
{
    // Bounds checking
    if (itemSlot < 0 || itemSlot >= MAX_EQUIPPED_ITEMS) return;
    
    int direction = (itemSlot == 0) ? -1 : 1;
    
    itemObjects[itemSlot] = [[GameObject alloc] init];
    itemObjects[itemSlot].position = GLKVector3Make(0.3 + direction * 0.2, -1.1, 1);
    
    Item item = [player getEquippedItem:itemSlot];
    itemNames[itemSlot] = item.name;
    
    if (item.name == ITEMS[ITEM_HEALING_POTION].name)
    {
        itemObjects[itemSlot].scale = GLKVector3Make(0.08f, 0.08f, 0.08f);
        itemMesh[itemSlot] = [[Assets getInstance] getMesh:KEY_MESH_POTION];
        [itemMesh[itemSlot] addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_POTION]];
    }
    else if(item.name == ITEMS[ITEM_BOMB].name)
    {
        itemObjects[itemSlot].scale = GLKVector3Make(0.1f, 0.1f, 0.1f);
        itemMesh[itemSlot] = [[Assets getInstance] getMesh:KEY_MESH_BOMB];
        [itemMesh[itemSlot] addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_BOMB]];
    }
    else if(item.name == ITEMS[ITEM_SHIELD].name)
    {
        itemObjects[itemSlot].scale = GLKVector3Make(0.05f, 0.05f, 0.05f);
        itemMesh[itemSlot] = [[Assets getInstance] getMesh:KEY_MESH_SHIELD];
        [itemMesh[itemSlot] addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_SHIELD]];
    }
}

/*!
 * @brief Return a position on the dungeon floor for an object.
 * @author Henry Loo
 *
 * @param offset The offset of the position along the floor.
 * @param scaleY The height of the object at the position.
 */
- (GLKVector3)getPositionOnFloor:(float)offset scaleY:(float)scaleY
{
    return GLKVector3Make(0, sinf(M_PI / 2 - FLOOR_ANGLE) * offset + scaleY / 2 + floorMesh.position.y,
                          -cosf(M_PI / 2 - FLOOR_ANGLE) * offset + floorMesh.position.z);
}

/*!
 * @brief Process an equipped item's behaviour.
 * @author Henry Loo
 *
 * @param itemSlot The equipped item slot.
 */
- (void)processItem:(int)itemSlot
{
    if (itemObjects[itemSlot] && itemObjects[itemSlot].isThrown)
    {
       [itemObjects[itemSlot] update:self.game.deltaTime];
    }
    
    // Check for collisions if the item is thrown
    if (itemObjects[itemSlot].isThrown && [itemObjects[itemSlot] isColliding:itemTargets[itemSlot]])
    {
        NSString *soundKey;
        if (itemNames[itemSlot] == ITEMS[ITEM_HEALING_POTION].name)
        {
            soundKey = KEY_SOUND_HEALING_POTION;
            [player addLife:[player getMaxLife] isHurt:false];
            [player addStamina:[player getMaxStamina]];
            [self setPlayerColour:GLKVector4Make(0, 1, 0.25, 1) time:0.5];
        }
        else if (itemNames[itemSlot] == ITEMS[ITEM_BOMB].name)
        {
            soundKey = KEY_SOUND_BOMB;
            [currentEnemy addLife:-BOMB_DAMAGE isHurt:true];
            currentEnemy.actionTimer = ENEMY_STUN_DURATION;
            [self setEnemyColour:GLKVector4Make(1, 0.5, 0, 1) time:0.5];
        }
        else
        {
            soundKey = KEY_SOUND_BLACKSMITH_UPGRADE;
            [self setPlayerColour:GLKVector4Make(0, 0.25, 1, 1) time:0.5];
            usedShield = true;
        }
        
        [[AudioPlayer getInstance] play:soundKey];
        
        // Clear the item's associated elements
        itemObjects[itemSlot] = nil;
        itemMesh[itemSlot] = nil;
    }
}

/*!
 * @brief Set the player's colour with a given duration.
 * This is used to make the player's sprite flash a certain colour.
 * @author Henry Loo
 *
 * @param colour The colour to mix with the player's sprite.
 * @param time The duration in seconds to flash for.
 */
- (void)setPlayerColour:(GLKVector4)colour time:(float)time
{
    playerColour = colour;
    playerColourTime = time;
    playerColourCurrentTime = time;
}

/*!
 * @brief Update the player's colour.
 * This should be called once each iteration in the update loop.
 * @author Henry Loo
 */
- (void)updatePlayerColour
{
    if (playerColourTime > 0)
    {
        playerColourCurrentTime += self.game.deltaTime;
    }
    
    if (playerColourCurrentTime <= 0)
    {
        playerColourCurrentTime = 0;
        playerColourTime = 0;
    }
}

/*!
 * @brief Set the enemy's colour with a given duration.
 * This is used to make the enemy's sprite flash a certain colour.
 * @author Henry Loo
 *
 * @param colour The colour to mix with the enemy's sprite.
 * @param time The duration in seconds to flash for.
 */
- (void)setEnemyColour:(GLKVector4)colour time:(float)time
{
    enemyColour = colour;
    enemyColourTime = time;
    enemyColourCurrentTime = time;
}

/*!
 * @brief Update the enemy's colour.
 * This should be called once each iteration in the update loop.
 * @author Henry Loo
 */
- (void)updateEnemyColour
{
    if (enemyColourTime > 0)
    {
        enemyColourCurrentTime += self.game.deltaTime;
    }
    
    if (enemyColourCurrentTime <= 0)
    {
        enemyColourCurrentTime = 0;
        enemyColourTime = 0;
    }
}

/*!
 * @brief Set the high score for this dungeon if the playtime
 * is less than the previous high score.
 * @author Henry Loo
 */
- (void)setHighScore
{
    int dungeonIndex = _dungeonNumber - 1;
    NSNumber *scoreNum = [NSNumber numberWithFloat:totalTime];
    float currentHighScore = self.game.highscores[dungeonIndex].floatValue;
    if (currentHighScore == 0 || scoreNum.floatValue < currentHighScore)
    {
        [self.game.highscores replaceObjectAtIndex:dungeonIndex withObject:scoreNum];
    }
}

@end
