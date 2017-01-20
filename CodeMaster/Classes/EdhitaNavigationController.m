//
//  EdhitaNavigationController.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//


#import "EdhitaNavigationController.h"


@implementation EdhitaNavigationController


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Overriden to allow any orientation.
    return YES;
}

/*
#pragma mark -
#pragma mark Status Bar

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
 */

- (id)init {
	if (self = [super init]) {
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
        [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.toolbar setTranslucent:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	}
	return self;
}


@end
