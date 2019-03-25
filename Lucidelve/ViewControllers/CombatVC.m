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
    
    // TODO: pointer to temporary label elements, remove this later
    UILabel *enemyNameLabel;
    UILabel *enemyStateLabel;
    UILabel *playerStateLabel;
    UILabel *combatStatusLabel;
    
    Mesh *playerMesh;
    Mesh *enemyMesh;
    Mesh *floorMesh;
    Mesh *leftWallMesh;
    Mesh *rightWallMesh;
    Mesh *backWallMesh;
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
    
    // TODO: set up pointers to temporary labels, remove this later
    enemyNameLabel = ((CombatView*) self.view).enemyNameLabel;
    enemyStateLabel = ((CombatView*) self.view).enemyStateLabel;
    playerStateLabel = ((CombatView*) self.view).playerStateLabel;
    combatStatusLabel = ((CombatView*) self.view).combatStatusLabel;
    
    playerMesh = [[Primitives getInstance] square];
    playerMesh._scale = GLKVector3Make(1, 1, 1);
    playerMesh._position = GLKVector3Make(0, -0.5, 0);
    [playerMesh addTexture:[[Assets getInstance] getTexture:KEY_TEXTURE_PLAYER_COMBAT]];
    
    floorMesh = [[Primitives getInstance] square];
    floorMesh._scale = GLKVector3Make(3, 30, 1);
    floorMesh._position = GLKVector3Make(0, -1, 0);
    floorMesh._rotation = GLKVector3Make(-M_PI / 2.5, 0, 0);
    [floorMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.floorTexture]];
    
    leftWallMesh = [[Primitives getInstance] square];
    leftWallMesh._scale = GLKVector3Make(30, 18, 1);
    leftWallMesh._position = GLKVector3Make(-2, 8, -5);
    leftWallMesh._rotation = GLKVector3Make(0, M_PI / 2, 0);
    [leftWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
    
    rightWallMesh = [[Primitives getInstance] square];
    rightWallMesh._scale = GLKVector3Make(30, 18, 1);
    rightWallMesh._position = GLKVector3Make(2, 8, -5);
    rightWallMesh._rotation = GLKVector3Make(0, -M_PI / 2, 0);
    [rightWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
    
    backWallMesh = [[Primitives getInstance] square];
    backWallMesh._scale = GLKVector3Make(4, 16, 1);
    backWallMesh._position = GLKVector3Make(0, 9, -20);
    backWallMesh._rotation = GLKVector3Make(0, 0, 0);
    [backWallMesh addTexture:[[Assets getInstance] getTexture:_currentDungeon.wallTexture]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // If current node is cleared and the dungeon run is not over,
    // then process the next node
    if (isNodeCleared && remainingNodes > 0)
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
            [currentEnemy reset:true];
            
            enemyMesh = [[Primitives getInstance] square];
            enemyMesh._scale = GLKVector3Make(1, 1, 1);
            enemyMesh._position = GLKVector3Make(0, 0.5, 0);
            [enemyMesh addTexture:[[Assets getInstance] getTexture:currentEnemy.texture]];
            
            [player reset:false];
        }
        
        combatStatusLabel.text = @"";
        isNodeCleared = false;
        remainingNodes--;
        [self updateRemainingNodes];
    }
    // Otherwise, continue performing updates for this node
    else
    {
        [player update:self.game.deltaTime];
        [self updatePlayerLabels];
        
        if (currentEnemy != nil)
        {
            [currentEnemy update:self.game.deltaTime];
            [self processEnemyAttack];
            [self updateEnemyLabels];
        }
    }
    
    [super update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer setupRender:rect];
    
    [self.renderer renderWithFog:floorMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:leftWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:rightWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderWithFog:backWallMesh program:[[Assets getInstance] getProgram:KEY_PROGRAM_DUNGEON] fogColour:_currentDungeon.fogColour];
    [self.renderer renderSprite:playerMesh spriteIndex:player.spriteIndex fogColour:_currentDungeon.fogColour];
    
    if (currentEnemy != nil)
    {
        [self.renderer renderSprite:enemyMesh spriteIndex:currentEnemy.spriteIndex fogColour:_currentDungeon.fogColour];
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
            isNodeCleared = true;
            totalRewardGold += [currentNode getGoldReward];
            
            // Last enemy was defeated
            if (remainingNodes == 0)
            {
                currentEnemy = nil;
            }
        }
        // Otherwise, perform a regular attack
        else
        {
            [self performRegularAttack];
        }
    }
    
    // Show the end message if dungeon run is over
    if (isNodeCleared && remainingNodes == 0 && currentEnemy == nil
        && !isReturningToHub)
    {
        // Show the end message
        NSString *stateString = [NSString stringWithFormat:@"DUNGEON CLEARED!\n<Tap to continue - Total Earned: %i G>",
                                 totalRewardGold];
        combatStatusLabel.text = stateString;
        
        isReturningToHub = true;
    }
    // Second tap when dungeon run is over
    else if (isReturningToHub || [player getCurrentLife] == 0)
    {
        // Return to The Hub with all gold earned
        [player addGold:totalRewardGold];
        HubVC *vc = [[HubVC alloc] init];
        [self.game changeScene:self newVC:vc];
    }
}

- (void)onSwipe:(UISwipeGestureRecognizer *)recognizer
{
    if (currentEnemy != nil)
    {
        switch(recognizer.direction)
        {
            case UISwipeGestureRecognizerDirectionUp:
                // High attack
                [self performHighAttack];
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
}

/*!
 * @brief Perform the player's regular attack.
 * @author Henry Loo
 */
- (void)performRegularAttack
{
    // Can only attack from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL && [player getCurrentStamina] > 0)
    {
        [player setCombatState:COMBAT_ATTACKING];
        [self dealSwordDamageToEnemy];
        [player addStamina:-1];
    }
}

/*!
 * @brief Perform the player's high attack.
 * @author Henry Loo
 */
- (void)performHighAttack
{
    // Can only attack from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL && [player getCurrentStamina] > 0)
    {
        [player setCombatState:COMBAT_ATTACKING2];
        [self dealSwordDamageToEnemy];
        [player addStamina:-1];
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
    if (([currentEnemy getCombatState] == COMBAT_ALERT && !isInterruptable) ||
        ([currentEnemy getCombatState] == COMBAT_NEUTRAL && [currentEnemy tryBlockingAttack]))
    {
        return;
    }
    
    // Deal damage depending on the number of sword upgrades
    [currentEnemy addLife:-[self.game getSwordDamage]];
}

/*!
 * @brief Inflict damage on the player depending on the enemy's attack.
 * @author Henry Loo
 */
- (void)dealEnemyDamageToPlayer
{
    [player addLife:-currentEnemy.currentAttack.damage];
}


/*!
 * @brief Perform the player's blocking action.
 * @author Henry Loo
 */
- (void)performBlock
{
    // Can only block from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        [player setCombatState:COMBAT_BLOCKING];
    }
}

/*!
 * @brief Perform the player's dodge left action.
 * @author Henry Loo
 */
- (void)performDodgeLeft
{
    // Can only dodge from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        [player setCombatState:COMBAT_DODGING_LEFT];
    }
}

/*!
 * @brief Perform the player's dodge right action.
 * @author Henry Loo
 */
- (void)performDodgeRight
{
    // Can only dodge from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        [player setCombatState:COMBAT_DODGING_RIGHT];
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
    
    // If the enemy is attacking and the player is not blocking a blockable attack or
    // dodging a dodgeable attack
    if (currentEnemy.isAttacking &&
        !((playerState == COMBAT_BLOCKING && currentEnemy.currentAttack.isBlockable) ||
            ((playerState == COMBAT_DODGING_LEFT || playerState == COMBAT_DODGING_RIGHT) && currentEnemy.currentAttack.isDodgeable)))
    {
        [self dealEnemyDamageToPlayer];
        
        // If dead, next tap should return player to The Hub with no rewards
        if ([player getCurrentLife] == 0)
        {
            isReturningToHub = true;
            totalRewardGold = 0;
        }
    }
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
        combatStatusLabel.text = [NSString stringWithFormat:@"<Tap to return to The Hub>"];
    }
    
//    NSString *stateString;
//    switch ([player getCombatState])
//    {
//        case COMBAT_NEUTRAL:
//            stateString = @"NEUTRAL";
//            break;
//
//        case COMBAT_DODGING_LEFT:
//            stateString = @"DODGING LEFT";
//            break;
//
//        case COMBAT_DODGING_RIGHT:
//            stateString = @"DODGING RIGHT";
//            break;
//
//        case COMBAT_BLOCKING:
//            stateString = @"BLOCKING";
//            break;
//
//        case COMBAT_ATTACKING:
//            stateString = @"REGULAR ATTACKING";
//            break;
//
//        case COMBAT_DEAD:
//            stateString = @"DEAD";
//            combatStatusLabel.text = @"<Tap to return to The Hub>";
//            break;
//
//        case COMBAT_HURT:
//            stateString = @"HURT";
//            break;
//
//        case COMBAT_ATTACKING2:
//            stateString = @"HIGH ATTACKING";
//            break;
//
//        case COMBAT_ALERT:
//            stateString = @"ALERT";
//            break;
//    }
//
//    playerStateLabel.text = stateString;
}

- (void)updateEnemyLabels
{
    NSString *name = [currentEnemy getName];
    int currentLife = [currentEnemy getCurrentLife];
    int maxLife = [currentEnemy getMaxLife];
    enemyNameLabel.text = [NSString stringWithFormat:@"%@ [%i / %i]", name,
                           currentLife, maxLife];
    
    if ([currentEnemy getCombatState] == COMBAT_DEAD)
    {
        combatStatusLabel.text = [NSString stringWithFormat:@"<Tap to continue - Reward: %i G>",
                                  [currentNode getGoldReward]];
    }
    
//    NSString *stateString;
//    switch ([currentEnemy getCombatState])
//    {
//        case COMBAT_NEUTRAL:
//            stateString = @"NEUTRAL";
//            break;
//
//        case COMBAT_DODGING_LEFT:
//            stateString = @"DODGING LEFT";
//            break;
//
//        case COMBAT_DODGING_RIGHT:
//            stateString = @"DODGING RIGHT";
//            break;
//
//        case COMBAT_BLOCKING:
//            stateString = @"BLOCKING";
//            break;
//
//        case COMBAT_ATTACKING:
//            stateString = @"REGULAR ATTACKING";
//            break;
//
//        case COMBAT_DEAD:
//            stateString = @"DEAD";
//            combatStatusLabel.text = [NSString stringWithFormat:@"<Tap to continue - Reward: %i G>",
//                           [currentNode getGoldReward]];
//            break;
//
//        case COMBAT_HURT:
//            stateString = @"HURT";
//            break;
//
//        case COMBAT_ATTACKING2:
//            stateString = @"HIGH ATTACKING";
//            break;
//
//        case COMBAT_ALERT:
//            stateString = @"ALERT";
//            break;
//    }
//
//    enemyStateLabel.text = stateString;
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

@end
