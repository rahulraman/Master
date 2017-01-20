//
//  EditorSplitViewController.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "EditorSplitViewController.h"


@implementation EditorSplitViewController

- (void) viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	UIViewController *root = [self.viewControllers objectAtIndex:0];

    [root viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.toolbar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   }

#pragma mark -
#pragma mark Status Bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}
- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    if (svc.displayMode == UISplitViewControllerDisplayModePrimaryHidden)
    {
        return UISplitViewControllerDisplayModePrimaryOverlay;
    }
    return UISplitViewControllerDisplayModePrimaryHidden;
}


@end
