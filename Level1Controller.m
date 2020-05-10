#import "Level1Controller.h"

@interface Level1Controller ()

@end

@implementation Level1Controller
@synthesize mheroLives;

@synthesize yes;
@synthesize no;

@synthesize mHero;

@synthesize mHealth;

@synthesize mFireBall1;
@synthesize mFireBall2;
@synthesize mFireBall3;
@synthesize mFireBall4;
@synthesize mFireBall5;

int health;
bool isHeroAlive;
int heroLives;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *strTemp;
    strTemp = [NSString stringWithFormat : @"%d" , (int)[self view].bounds.size.width];
    NSLog(strTemp);
    
    [self resetGame];
}

- (void)resetGame {
    
    mHero.center = CGPointMake(100, 100);
    mDirX = 1;
    mDirY = 1;
    mSpeedX = 1.0;
    mSpeedY = 1.0;
    
    // init the vars for tb1
    mFireBall1DirX = 1;
    mFireBall1DirY = 0;
    mFireBall1Speed = 3;
    
    // init the vars for tb1
    mFireBall2DirX = 1;
    mFireBall2DirY = 0;
    mFireBall2Speed = 3;
    
    // init the vars for tb1
    mFireBall3DirX = 1;
    mFireBall3DirY = 0;
    mFireBall3Speed = 3;
    
    // init the vars for tb1
    mFireBall4DirX = 1;
    mFireBall4DirY = 0;
    mFireBall4Speed = 3;
    
    // init the vars for tb1
    mFireBall5DirX = 1;
    mFireBall5DirY = 0;
    mFireBall5Speed = 3;
    [self initializeTimerToMoveAlien];
    
    health = 100;
    
    NSString *strHealth;
    strHealth = [NSString stringWithFormat : @"%d" , health];
    mHealth.text = strHealth;
    
    isHeroAlive = true;
    
    heroLives = 3;
    NSString *strLives;
    strLives = [NSString stringWithFormat : @"%d" , heroLives];
    mheroLives.text = strLives;
}

//---------------------------------------------------------- THREAD FUNC
- (void)initializeTimerToMoveAlien {
    if (mTheTimer == nil) {
        mTheTimer = [CADisplayLink displayLinkWithTarget:self
                                                           selector:@selector(gameLogic)];
        mTheTimer.frameInterval = 1.0f/30.0f;
        [mTheTimer addToRunLoop: [NSRunLoop currentRunLoop]
                                   forMode: NSDefaultRunLoopMode];
    }
}

//---------------------------------------------------------- THREAD FUNC: Game Logic(=game main loop)
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",buttonIndex);
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked Cancel");
        
        UIViewController *levelSelectionController = [self.storyboard instantiateViewControllerWithIdentifier:@"levelSelection"];
        [self presentViewController:levelSelectionController animated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"You have clicked GOO");
        [self resetGame];
    }
}

- (void)gameLogic {
    
    yes.enabled = NO;
    no.enabled = NO;

    // move alien.
    if (mHero.center.x + 16 >= (int)[self view].bounds.size.width ||
        mHero.center.x - 16 < 0) {
        if (mHero.center.x + 16 >= (int)[self view].bounds.size.width) {
            mHero.center = CGPointMake((int)[self view].bounds.size.width-16, mHero.center.y);
        }
        if (mHero.center.x - 16 < 0) {
            mHero.center = CGPointMake(16, mHero.center.y);
        }
        mDirX *= -1;
    }
    if (mHero.center.y + 16 >= 343 || mHero.center.y - 16 < 28) {
        if (mHero.center.y + 16 >= 343) {
            mHero.center = CGPointMake(mHero.center.x, 343-16);
        }
        if (mHero.center.y - 16 < 28) {
            mHero.center = CGPointMake(mHero.center.x, 28+16);
        }
        mDirY *= -1;
    }
    mHero.center = CGPointMake(mHero.center.x+mDirX*mSpeedX, mHero.center.y+mDirY*mSpeedY);

    
    [self processFireball:mHero secondParam:mFireBall1 thirdParam:&mFireBall1DirX fourthParam:&mFireBall1DirY fifthParam:mFireBall1Speed];
    [self processFireball:mHero secondParam:mFireBall2 thirdParam:&mFireBall2DirX fourthParam:&mFireBall2DirY fifthParam:mFireBall2Speed];
    [self processFireball:mHero secondParam:mFireBall3 thirdParam:&mFireBall3DirX fourthParam:&mFireBall3DirY fifthParam:mFireBall3Speed];
    [self processFireball:mHero secondParam:mFireBall4 thirdParam:&mFireBall4DirX fourthParam:&mFireBall4DirY fifthParam:mFireBall4Speed];
    [self processFireball:mHero secondParam:mFireBall5 thirdParam:&mFireBall5DirX fourthParam:&mFireBall5DirY fifthParam:mFireBall5Speed];
}

//void processFireball(UIImageView *hero, UIImageView *fireBall, int fbDirX, int fbDirY, double fbSpeed);
- (void) processFireball:(UIImageView *)hero
             secondParam:(UIImageView *)fireBall
             thirdParam:(int *)fbDirX
             fourthParam:(int *)fbDirY
             fifthParam:(double)fbSpeed
{
    //move Fireball5
    if (fireBall.center.x + 16 >= [self view].bounds.size.width || fireBall.center.x - 16 < 0) {
        *fbDirX *= -1;
    }
    if (fireBall.center.y + 16 >= [self view].bounds.size.height || fireBall.center.y - 16 < 0) {
        *fbDirY *= -1;
    }
    fireBall.center = CGPointMake(fireBall.center.x+(*fbDirX)*fbSpeed, fireBall.center.y+(*fbDirY)*fbSpeed);
    
    if (isHeroAlive &&
        fireBall.center.x <= hero.center.x+32 &&
        fireBall.center.x >= hero.center.x-32 &&
        fireBall.center.y <= hero.center.y+32 &&
        fireBall.center.y >= hero.center.y-32) {
        //fireBall.hidden = true;
        
        health -= 20;
        
        NSString *strHealth;
        strHealth = [NSString stringWithFormat : @"%d" , health];
        mHealth.text = strHealth;
        
        if (health <= 0) {
            heroLives --;
            health = 100;
            
            NSString *strLives;
            strLives = [NSString stringWithFormat : @"%d" , heroLives];
            mheroLives.text = strLives;
        }
        
        if(heroLives <= 0){
            isHeroAlive = false;
            
            // stop timer(game logic)
            [mTheTimer invalidate];
            mTheTimer = nil;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Game Over!"
                                                            message: @"Play Again?"
                                                           delegate: self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles: @"OK",nil];
            [alert setTag:1];
            [alert show];
        }
    }
}

//---------------------------------------------------------- TOUCH
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    //NSLog(@"touchesBegan(): x: %f / y: %f", [touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
    mHero.center = CGPointMake([touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
    
    mDate = [NSDate date];
    
    mTouchStartX = [touch locationInView:touch.view].x;
    mTouchStartY = [touch locationInView:touch.view].y;
    
    mCurSpeedX = mSpeedX;
    mCurSpeedY = mSpeedY;
    
    mSpeedX = 0;
    mSpeedY = 0;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    //NSLog(@"touchesMoved(): x: %f / y: %f", [touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
    mHero.center = CGPointMake([touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    //NSLog(@"touchesBegan(): x: %f / y: %f", [touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
    mHero.center = CGPointMake([touch locationInView:touch.view].x, [touch locationInView:touch.view].y);
    
    NSLog(@"Time Elapsed:" " %g",[mDate timeIntervalSinceNow]*-1);
    
    double milliTimeElapsed = [mDate timeIntervalSinceNow]*-1;
    mTouchEndX = [touch locationInView:touch.view].x;
    mTouchEndY = [touch locationInView:touch.view].y;
    
    // calculate the speed
    mSpeedX = (abs(mTouchEndX - mTouchStartX)) * (1/milliTimeElapsed) / 200;
    mSpeedY = (abs(mTouchEndY - mTouchStartY)) * (1/milliTimeElapsed) / 200;
    
    // decide new direction
    if (mTouchEndX - mTouchStartX > 0.0) {
        mDirX = 1;
    }
    else {
        mDirX = -1;
    }
    
    if (mTouchEndY - mTouchStartY > 0.0) {
        mDirY = 1;
    }
    else {
        mDirY = -1;
    }
    
    mDate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
