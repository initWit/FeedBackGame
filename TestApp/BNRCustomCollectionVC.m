#import "BNRCustomCollectionVC.h"
#import "QuizViewController.h"
#import "CustomCollectionViewCell.h"
#import "AppDelegate.h"


#define TRANSITION_DURATION 1.0

@interface BNRCustomCollectionVC () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
{
    int currentSavedLevel;
    
    UIColor *passedInBackgroundColor;
}
@end

@implementation BNRCustomCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // get the saved plist from the documents directory
    NSString *nameOfSavedLevelPlist = @"CurrentSavedLevel.plist";
    NSArray *mySavedLevelPlistPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *mySavedLevelPlistFilePath = [[mySavedLevelPlistPathArray objectAtIndex:0] stringByAppendingPathComponent:nameOfSavedLevelPlist];
    
	// get the value form the saved plist
    NSMutableArray *myCurrentSavedLevelArray = [[NSMutableArray alloc] initWithContentsOfFile:mySavedLevelPlistFilePath];
    NSNumber *currentSavedLevelObject = [myCurrentSavedLevelArray objectAtIndex:0];
    
    currentSavedLevel = [currentSavedLevelObject intValue];

}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                forIndexPath:indexPath];
    
    if ((indexPath.row+1) < (currentSavedLevel)) {
        
        UIColor *color = [UIColor lightGrayColor];
        
        [cell setBackgroundColor:color];
        
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.myCellLabel setTextColor:[UIColor lightGrayColor]];
    }
    
    if ((indexPath.row+1) == currentSavedLevel) {
        [cell.myCellLabel setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor blueColor]];
    }

    [cell.myCellLabel setText:[NSString stringWithFormat:@"%i",(indexPath.row + 1)]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // logic to lock incomplete levels
    int selectedLevel = (indexPath.row + 1);
    
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    if (selectedLevel > currentSavedLevel)
    {
        UIAlertView *lockedLevelsAlert;
        lockedLevelsAlert = [[UIAlertView alloc] initWithTitle:@"Sorry, that level is locked"
                                                       message:@"You must complete the previous level"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil];
        [lockedLevelsAlert show];
    }
    else
    {
        NSNumber *selectedLevelObject = [NSNumber numberWithInt:selectedLevel];
        myAppDelegate.playThisLevel = selectedLevelObject;
        
        QuizViewController *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizVC"];
        
        passedInBackgroundColor = [[collectionView cellForItemAtIndexPath:indexPath] backgroundColor];
        [toVC.view setBackgroundColor:passedInBackgroundColor];
        
        toVC.transitioningDelegate = self;
        toVC.modalPresentationStyle = UIModalPresentationCustom;
        
        [self presentViewController:toVC animated:YES completion:nil];
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	NSIndexPath *selected = self.collectionView.indexPathsForSelectedItems[0];
	UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:selected];
	
    UIView *container = transitionContext.containerView;
	
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

	CGRect beginFrame = [container convertRect:cell.bounds fromView:cell];
    CGRect endFrame = [transitionContext initialFrameForViewController:fromVC];


	UIView *move = nil;
	if (toVC.isBeingPresented)
    {
		toView.frame = endFrame;
		move = [toView snapshotViewAfterScreenUpdates:YES];
		move.frame = beginFrame;
		cell.hidden = YES;
	}
    else
    {
        QuizViewController *transitioningQuizVC = (QuizViewController *) fromVC;
        [transitioningQuizVC.view setBackgroundColor:passedInBackgroundColor];
        [transitioningQuizVC.oneButton setAlpha:0.0];
        [transitioningQuizVC.twoButton setAlpha:0.0];
        [transitioningQuizVC.Tile1_button setAlpha:0.0];
        [transitioningQuizVC.Tile2_button setAlpha:0.0];
        [transitioningQuizVC.Tile3_button setAlpha:0.0];
        [transitioningQuizVC.Tile4_button setAlpha:0.0];
        [transitioningQuizVC.menuButton setAlpha:0.0];
        [transitioningQuizVC.IAP_button setAlpha:0.0];
        [transitioningQuizVC.scoreProgressBar setAlpha:0.0];



		move = [fromView snapshotViewAfterScreenUpdates:YES];
		move.frame = fromView.frame;
		[fromView removeFromSuperview];
	}
    [container addSubview:move];
	
	[UIView animateWithDuration:TRANSITION_DURATION delay:0
         usingSpringWithDamping:500 initialSpringVelocity:15
                        options:0 animations:^{
                            move.frame = toVC.isBeingPresented ?  endFrame : beginFrame;}
                     completion:^(BOOL finished) {
                         if (toVC.isBeingPresented) {
                             [move removeFromSuperview];
                             toView.frame = endFrame;
                             [container addSubview:toView];
                         } else {
                             cell.hidden = NO;
                         }

                         [transitionContext completeTransition: YES];
                     }];
}

@end
