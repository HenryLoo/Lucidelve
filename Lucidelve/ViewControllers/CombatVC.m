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

@interface CombatVC ()
{
    // Pointer to the player instance
    Player *player;
    
    // The remaining delay in seconds between each player action,
    // before the player's combat state reverts to Neutral.
    float playerCooldown;
    
    // Gesture pointers
    UITapGestureRecognizer *tapGesture;
    UISwipeGestureRecognizer *swipeUpGesture;
    UISwipeGestureRecognizer *swipeDownGesture;
    UISwipeGestureRecognizer *swipeLeftGesture;
    UISwipeGestureRecognizer *swipeRightGesture;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    // Calculate deltaTime for this frame
    self.game.deltaTime = [self.game.lastTime timeIntervalSinceNow];
    self.game.lastTime = [NSDate date];
    
    // If current node is cleared, process the next node
    if (false)
    {
        // TODO: skip this for now, we're just testing 1 combat node
    }
    // Otherwise, continue performing updates for this node
    else
    {
        [self updatePlayer];
    }
    
    [super update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.renderer render:self.game.deltaTime drawRect:rect];
}

- (void)onTap:(UITapGestureRecognizer *)recognizer
{
    // Regular attack
    [self performRegularAttack];
}

- (void)onSwipe:(UISwipeGestureRecognizer *)recognizer
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
            [self performDodge];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            // Dodge right
            [self performDodge];
            break;
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
        NSLog(@"Regular Attack");
        [player setCombatState:COMBAT_REGULAR_ATTACKING];
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
        NSLog(@"High Attack");
        [player setCombatState:COMBAT_HIGH_ATTACKING];
    }
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
        NSLog(@"Block");
        [player setCombatState:COMBAT_BLOCKING];
    }
}

/*!
 * Perform the player's dodging action
 * @author Henry Loo
 */
- (void)performDodge
{
    // Can only dodge from Neutral state
    if ([player getCombatState] == COMBAT_NEUTRAL)
    {
        NSLog(@"Dodge");
        [player setCombatState:COMBAT_DODGING];
    }
}

/*!
* Update the player's values.
* This should be called every frame in the update loop.
* @author Henry Loo
*/
- (void)updatePlayer
{
    if ([player getCombatState] != COMBAT_NEUTRAL)
    {
        // We just changed from Neutral, so start the cooldown
        if (playerCooldown == 0)
        {
            playerCooldown = PLAYER_COMBAT_COOLDOWN;
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
}

@end
