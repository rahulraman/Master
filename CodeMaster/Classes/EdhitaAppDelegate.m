//
//  EdhitaAppDelegate.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "EdhitaAppDelegate.h"
#include <sys/xattr.h>

@import Firebase;

@interface EdhitaAppDelegate ()
{
//    UIStoryboard *storyboard;
//    int varIntroIndex;
    NSString * documentsDirectoryPath;
//    UISwipeGestureRecognizer * swipeleft;
//    UIPageControl *pageControl;
}
@property (nonatomic, strong) EdhitaNavigationController * navigationController;

@end

@implementation EdhitaAppDelegate

#pragma mark -
#pragma mark Status Bar

/*
- (BOOL)prefersStatusBarHidden {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        return NO;
        
    } else {
        return YES;
    }
}
 */

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    [FIRApp configure];
    
    // Override point for customization after application launch.
    splitViewController_ = [[EditorSplitViewController alloc] init];
    // Preloads keyboard so there's no lag on initial keyboard appearance.
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.toolbar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                       NSFontAttributeName:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size: 20.0f]
                                                                       }];
    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	NSString * homeDir = NSHomeDirectory();
    documentsDirectoryPath = [[homeDir stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Files"];

    NSString *docsDir;
    NSArray *dirPaths;
    NSURL * finalURL;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    finalURL = [NSURL fileURLWithPath:docsDir];
    
    [self addSkipBackupAttributeToItemAtURL:finalURL];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(templateLoaded:) name:@"templateLoaded" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainStarting) name:@"finalIntro" object:nil];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

	//NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * examplesDocumentsPath = [documentsDirectoryPath stringByAppendingPathComponent:@"Demo"];
    
//    NSString * homeDir1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString * examplesDocumentsPath2 = [homeDir1 stringByAppendingPathComponent:@"Templates"];
    
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstTime"])
    {
        [fileManager removeItemAtPath:examplesDocumentsPath error:nil];
        
       // [fileManager removeItemAtPath:examplesDocumentsPath2 error:nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstTime"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isTemplateLoaded"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    if (![fileManager fileExistsAtPath:examplesDocumentsPath])
    {
        NSString *examplesBundlePath = [[[NSBundle mainBundle] resourcePath]
                                        stringByAppendingPathComponent:@"Demo"];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];


        [fileManager copyItemAtPath:examplesBundlePath toPath:examplesDocumentsPath error:&error];
    }
    
   // [self performSelectorInBackground:@selector(copyTemplatesIfNeeded) withObject:nil];
    
    //varIntroIndex=1;

//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isTemplateLoaded"])
//    {
//     
//        
//        storyboard = [UIStoryboard storyboardWithName:@"Intro" bundle:nil];
//        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"Intro%d", varIntroIndex+1]];
////        UIViewController *vc5 = [storyboard instantiateViewControllerWithIdentifier:@"Intro5"];
////        
////        NSLog(@"[vc5.view viewWithTag:123] %@", [vc5.view viewWithTag:123]);
////        
////        UIButton * btn = (UIButton*)[vc5.view viewWithTag:123];
////        [btn addTarget:self action:@selector(mainStarting) forControlEvents:UIControlEventTouchUpInside];
//        
//        self.navigationController = [[EdhitaNavigationController alloc] initWithRootViewController:vc];
//        self.navigationController.navigationBarHidden=YES;
//        [window addSubview:self.navigationController.view];
//        window.rootViewController = self.navigationController;
//        
//        swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
//        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
//        [self.navigationController.view addGestureRecognizer:swipeleft];
//        // SwipeRight
//        
//        UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
//        swiperight.direction=UISwipeGestureRecognizerDirectionRight;
//        [self.navigationController.view addGestureRecognizer:swiperight];
//        // Implement Gesture Methods
//        
//        pageControl = [[UIPageControl alloc] init];
//        pageControl.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height*.4);
//        pageControl.center = CGPointMake(self.navigationController.view.center.x, self.navigationController.view.frame.size.height*.8);
//        pageControl.numberOfPages = 5;
//        pageControl.currentPage = 0;
//        [self.navigationController.view addSubview:pageControl];
//        [self.navigationController.view bringSubviewToFront:pageControl];
//
//    }
//    else
    {
        [self mainStarting];
    }
    
   
    
    
    [window makeKeyAndVisible];
    
	return YES;
}
-(void)mainStarting
{
   // [pageControl removeFromSuperview];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        // Start iPhone app
        
        RootViewController *rootViewController = [[RootViewController alloc] initWithPath:documentsDirectoryPath];
        self.navigationController = [[EdhitaNavigationController alloc] initWithRootViewController:rootViewController];
        
        [window addSubview:self.navigationController.view];
        window.rootViewController = self.navigationController;
        
    } else {
        // Start iPad app
        RootViewController *rootViewController = [[RootViewController alloc] initWithPath:documentsDirectoryPath];
        EdhitaNavigationController* navigationController = [[EdhitaNavigationController alloc] initWithRootViewController:rootViewController];
        
        DetailViewController *detailViewController = [[DetailViewController alloc] init];
        rootViewController.detailViewController = detailViewController;
        
        
        splitViewController_.viewControllers = [NSArray arrayWithObjects:navigationController, detailViewController, nil];
        splitViewController_.delegate = detailViewController;
        //splitViewController_.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self seObserverForOrientationChanging];
            splitViewController_.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
        });
        splitViewController_.presentsWithGesture = YES;
        
        
        [window addSubview:splitViewController_.view];
        
        window.rootViewController = splitViewController_;
    }

}
- (BOOL) shouldAutorotate
{
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
-(void) seObserverForOrientationChanging
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}


- (void) orientationChanged:(NSNotification *)note
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        //Do something in landscape
        splitViewController_.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;

    }
    else {
        //Do something in portrait
        splitViewController_.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
        

    }
}
//-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
//{
//    if(varIntroIndex==4)
//        return;
//    
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isTemplateLoaded"]&&varIntroIndex==3)
//        return;
//    
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isTemplateLoaded"]&&varIntroIndex==2)
//        varIntroIndex++;
//    
//
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"Intro%d", varIntroIndex+2]];
//    [self.navigationController pushViewController:vc animated:YES];
//    varIntroIndex++;
//    
//    pageControl.currentPage=varIntroIndex;
//    
//}
//
//-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
//{
//   if(varIntroIndex>0)
//   {
//       
//       if(self.navigationController.viewControllers.count==5)
//       {
//           NSMutableArray * arrayC = [NSMutableArray array];
//           
//           for(UIViewController * vv in self.navigationController.viewControllers)
//               [arrayC addObject:vv];
//           
//           [arrayC removeObjectAtIndex:3];
//           varIntroIndex--;
//           
//           self.navigationController.viewControllers=arrayC;
//           pageControl.numberOfPages=4;
//       }
//       
//       varIntroIndex--;
//       pageControl.currentPage=varIntroIndex;
//       [self.navigationController popViewControllerAnimated:YES];
//   }
//}
//
//-(void)templateLoaded:(NSNotificationCenter* )notif
//{
//    if(varIntroIndex==3)
//        [self swipeleft:nil];
//    
//    pageControl.numberOfPages=4;
//
//    NSLog(@"LOADD");
//}

//- (NSString *)applicationHiddenDocumentsDirectory {
//    // NSString *path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@".data"];
//    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [libraryPath stringByAppendingPathComponent:@"Templates"];
//    
//    BOOL isDirectory = NO;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
//        if (isDirectory)
//            return path;
//        else {
//            // Handle error. ".data" is a file which should not be there...
//            [NSException raise:@".data exists, and is a file" format:@"Path: %@", path];
//            // NSError *error = nil;
//            // if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
//            //     [NSException raise:@"could not remove file" format:@"Path: %@", path];
//            // }
//        }
//    }
//    NSError *error = nil;
//    if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
//        // Handle error.
//        [NSException raise:@"Failed creating directory" format:@"[%@], %@", path, error];
//    }
//    return path;
//}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL

{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}

//-(void)copyTemplatesIfNeeded
//{
//    NSString * homeDir1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString * documentsDirectoryPath1 = [homeDir1 stringByAppendingPathComponent:@"Templates"];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    //NSString * examplesDocumentsPath = [documentsDirectoryPath stringByAppendingPathComponent:@"Templates"];
//    if (![fileManager fileExistsAtPath:documentsDirectoryPath1]) {
//        //NSString * examplesBundlePath = [[NSBundle mainBundle] pathForResource:@"Templates" ofType:@""];
//        
//        NSString *examplesBundlePath = [[[NSBundle mainBundle] resourcePath]
//                                          stringByAppendingPathComponent:@"Templates"];
//        
//        BOOL success = [fileManager copyItemAtPath:examplesBundlePath toPath:documentsDirectoryPath1 error:&error];
//        NSLog(@"success : %d",success);
//        
//        if(success)
//        {
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTemplateLoaded"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"templateLoaded" object:nil];
//        }
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     */
}


@end
