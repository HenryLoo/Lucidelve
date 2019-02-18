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

@interface CombatVC ()
{
    // Pointer to the player instance.
    Player *player;
    
    // The remaining delay in seconds between each player action,
    // before the player's combat state reverts to Neutral.
    float playerCooldown;
    
    // The remaining delay in seconds between each enemy action,
    // before the enemy's state reverts to Neutral.
    float enemyCooldown;
    
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
    
    // TODO: pointer to temporary label elements, remove this later
    UILabel *enemyNameLabel;
    UILabel *enemyStateLabel;
    UILabel *playerStateLabel;
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
    
    isNodeCleared = true;
    
    // Randomize the number of nodes, bounded by the the min and max values.
    numNodes = _currentDungeon.minNumNodes + arc4random() % (_currentDungeon.maxNumNodes - _currentDungeon.minNumNodes);
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
    
    // TODO: set up pointers to temporary labels, remove this later
    enemyNameLabel = ((CombatView*) self.view).enemyNameLabel;
    enemyStateLabel = ((CombatView*) self.view).enemyStateLabel;
    playerStateLabel = ((CombatView*) self.view).playerStateLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // Calculate deltaTime for this frame
    self.game.deltaTime = [self.game.dungeonLastTime timeIntervalSinceNow];
    self.game.dungeonLastTime = [NSDate date];
    
    // If current node is cleared and the dungeon run is not over,
    // then process the next node
    if (isNodeCleared && remainingNodes > 0)
    {
        currentNode = [_currentDungeon getDungeonNode];
        
        EnemyType enemyType = [currentNode getEnemyType];
        if (enemyType == ENEMY_NONE)
        {
            // No enemy in this node
            currentEnemy = nil;
        }
        else
        {
            // Initialize the enemy
            currentEnemy = [self.game getEnemy:enemyType];
            [currentEnemy reset];
        }
        
        isNodeCleared = false;
        remainingNodes--;
        [self updateRemainingNodes];
        
        // Reset cooldowns
        playerCooldown = 0;
        [player setCombatState:COMBAT_NEUTRAL];
        enemyCooldown = 0;
    }
    // Otherwise, continue performing updates for this node
    else
    {
        [self updatePlayer];
        [self updateEnemy];
    }
    
    [super update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer render:self.game.deltaTime drawRect:rect];
}

- (void)onTap:(UITapGestureRecognizer *)recognizer
{
    if (currentEnemy != nil)
    {
        // If the enemy is dead, clear the node and add reward gold
        // onto the total amount of reward gold.
        if ([currentEnemy getState] == ENEMY_DEAD)
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
        enemyStateLabel.text = stateString;
        
        isReturningToHub = true;
    }
    // Second tap when dungeon run is over
    else if (isReturningToHub)
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
 * Perform the player's regular attack
 * @author Henry Loo
 */
- (void)performRegularAttack
{
    // Can only attack from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        [player setCombatState:COMBAT_REGULAR_ATTACKING];
        [self dealSwordDamageToEnemy];
    }
}

/*!
 * Perform the player's high attack
 * @author Henry Loo
 */
- (void)performHighAttack
{
    // Can only attack from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        [player setCombatState:COMBAT_HIGH_ATTACKING];
        [self dealSwordDamageToEnemy];
    }
}

- (void)dealSwordDamageToEnemy
{
    // TODO: replace hard-coded damage value to reflect the player's sword
    [currentEnemy addLife:-1];
    
    // Restart the enemy's cooldown
    enemyCooldown = COMBAT_COOLDOWN;
}

/*!
 * Perform the player's blocking action
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
 * Perform the player's dodge left action
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
 * Perform the player's dodge right action
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
* Update the player's values.
* This should be called every frame in the update loop.
* @author Henry Loo
*/
- (void)updatePlayer
{
    CombatState state = [player getCombatState];
    if (state != COMBAT_NEUTRAL && state != COMBAT_DEAD)
    {
        // We just changed from Neutral, so start the cooldown
        if (playerCooldown == 0)
        {
            playerCooldown = COMBAT_COOLDOWN;
        }
        
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        playerCooldown += self.game.deltaTime;
        playerCooldown = MAX(0, playerCooldown);
        
        // Cooldown is over, so reset to Neutral
        if (playerCooldown == 0)
        {
            [player setCombatState:COMBAT_NEUTRAL];
        }
    }
    
    [self updatePlayerLabel];
}

// TODO: replace these with visual assets
- (void)updatePlayerLabel
{
    NSString *stateString;
    switch ([player getCombatState])
    {
        case COMBAT_NEUTRAL:
            stateString = @"NEUTRAL";
            break;
            
        case COMBAT_DODGING_LEFT:
            stateString = @"DODGING LEFT";
            break;
            
        case COMBAT_DODGING_RIGHT:
            stateString = @"DODGING RIGHT";
            break;
            
        case COMBAT_BLOCKING:
            stateString = @"BLOCKING";
            break;
            
        case COMBAT_REGULAR_ATTACKING:
            stateString = @"REGULAR ATTACKING";
            break;
            
        case COMBAT_DEAD:
            stateString = @"DEAD";
            break;
            
        case COMBAT_HURT:
            stateString = @"HURT";
            break;
            
        case COMBAT_HIGH_ATTACKING:
            stateString = @"HIGH ATTACKING";
            break;
    }
    
    playerStateLabel.text = stateString;
}

/*!
 * Update the enemy's values.
 * This should be called every frame in the update loop.
 * @author Henry Loo
 */
- (void)updateEnemy
{
    if (currentEnemy == nil) return;
    
    EnemyState state = [currentEnemy getState];
    if (state != ENEMY_NEUTRAL && state != ENEMY_DEAD)
    {
        // We just changed from Neutral, so start the cooldown
        if (enemyCooldown == 0)
        {
            enemyCooldown = COMBAT_COOLDOWN;
        }
        
        // Decrement cooldown timer and make sure it doesn't
        // drop lower than 0
        enemyCooldown += self.game.deltaTime;
        enemyCooldown = MAX(0, enemyCooldown);
        
        // Cooldown is over, so reset to Neutral
        if (enemyCooldown == 0)
        {
            [currentEnemy setState:ENEMY_NEUTRAL];
        }
    }
    
    [self updateEnemyLabels];
}

// TODO: replace these with visual assets
- (void)updateEnemyLabels
{
    NSString *name = [currentEnemy getName];
    int currentLife = [currentEnemy getCurrentLife];
    int maxLife = [currentEnemy getMaxLife];
    enemyNameLabel.text = [NSString stringWithFormat:@"%@ [%i / %i]", name,
                           currentLife, maxLife];
    
    NSString *stateString;
    switch ([currentEnemy getState])
    {
        case ENEMY_NEUTRAL:
            stateString = @"NEUTRAL";
            break;
            
        case ENEMY_ALERT:
            stateString = @"ALERT";
            break;
            
        case ENEMY_ATTACKING:
            stateString = @"ATTACKING";
            break;
            
        case ENEMY_DEAD:
            stateString = [NSString stringWithFormat:@"DEAD\n<Tap to continue - Reward: %i G>",
                               [currentNode getGoldReward]];
            break;
            
        case ENEMY_HURT:
            stateString = @"HURT";
            break;
    }
    
    enemyStateLabel.text = stateString;
}

/*!
 * Update the remaining nodes label.
 * @author Henry Loo
 */
- (void)updateRemainingNodes
{
    remainingNodesLabel.text = [NSString stringWithFormat:@"Room: %i/%i",
                                numNodes - remainingNodes, numNodes];
}

@end
