#import <UIKit/UIKit.h>

@interface Level2Controller : UIViewController<UIAlertViewDelegate> {
    UIImageView *mHero;
    int mDirX;
    int mDirY;
    double mSpeedX;
    double mSpeedY;
    double mCurSpeedX;
    double mCurSpeedY;
    CADisplayLink *mTheTimer;
    
    double mTouchStartX;
    double mTouchStartY;
    double mTouchEndX;
    double mTouchEndY;
    
    NSDate * mDate; // to check time interval in millisecond.
    
    UIImageView *mFireBall1;
    double mFireBall1Speed;
    int mFireBall1DirX;
    int mFireBall1DirY;
    
    UIImageView *mFireBall2;
    double mFireBall2Speed;
    int mFireBall2DirX;
    int mFireBall2DirY;
    
    UIImageView *mFireBall3;
    double mFireBall3Speed;
    int mFireBall3DirX;
    int mFireBall3DirY;
    
    UIImageView *mFireBall4;
    double mFireBall4Speed;
    int mFireBall4DirX;
    int mFireBall4DirY;
    
    UIImageView *mFireBall5;
    double mFireBall5Speed;
    int mFireBall5DirX;
    int mFireBall5DirY;
    
    UILabel *mHealth;
}
@property (nonatomic, retain) IBOutlet UILabel *mheroLives;


@property (nonatomic, retain) IBOutlet UIButton *yes;
@property (nonatomic, retain) IBOutlet UIButton *no;

@property (nonatomic, retain) IBOutlet UIImageView *mHero;

@property (nonatomic, retain) IBOutlet UILabel *mHealth;

@property (nonatomic, retain) IBOutlet UIImageView *mFireBall1;
@property (nonatomic, retain) IBOutlet UIImageView *mFireBall2;
@property (nonatomic, retain) IBOutlet UIImageView *mFireBall3;
@property (nonatomic, retain) IBOutlet UIImageView *mFireBall4;
@property (nonatomic, retain) IBOutlet UIImageView *mFireBall5;

@end
