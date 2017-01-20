//
//  EdhitaAppDelegate.h
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"
#import "DetailViewController.h"
#import "EdhitaNavigationController.h"
#import "EditorSplitViewController.h"

@interface EdhitaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	EditorSplitViewController *splitViewController_;
}

@property (strong, nonatomic) UIWindow *window;

@end

