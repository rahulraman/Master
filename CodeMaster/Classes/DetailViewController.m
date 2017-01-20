//
//  DetailViewController.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "DetailViewController.h"
#import "Reachability.h"
#import "PXAlertView.h"
#import "QEDTextView.h"
#import "Common.h"

@interface DetailViewController ()
//@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end


@implementation DetailViewController

@synthesize popoverController, detailItem, detailDescriptionLabel, path = path_, toolbar = _toolBar;

#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    //    if (popoverController != nil) {
    //        [popoverController dismissPopoverAnimated:YES];
    //    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    //    detailDescriptionLabel.text = [detailItem description];
}


#pragma mark -
#pragma mark Split view support

- (BOOL)splitViewController:(UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Documents";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.toolbar setTranslucent:YES];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = pc;
    self.popoverController.backgroundColor = [UIColor blackColor];
    svc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.toolbar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0],
                                                                       NSFontAttributeName:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size: 20.0f]
                                                                       }];
    
    
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = nil;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.toolbar setTranslucent:YES];
}

#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        // Handle rotation call on iPhone only
        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        } else {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
}


/*
 #pragma mark -
 #pragma mark Status Bar
 
 - (BOOL)prefersStatusBarHidden
 {
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
 return NO;
 
 } else {
 return YES;
 }
 }
 */


#pragma mark -
#pragma mark View lifecycle


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
   // [self disableButton_];
    //* keyboard notification method is called
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
   // [self disableButton_];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    [self saveContents];
}



#pragma mark -
#pragma mark Memory management




- (id)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];
        
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            // Show toolbar on iPhone
            textView_ = [[QEDTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            
        } else {
            // Show text view on iPad
            textView_ = [[QEDTextView alloc] initWithFrame:CGRectMake(0, 88.0, self.view.bounds.size.width, self.view.bounds.size.height)];
            
        }
        textView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //textView_.backgroundColor = [UIColor lightGrayColor];
        textView_.text = @"";
        textView_.autocorrectionType = UITextAutocorrectionTypeNo;
        textView_.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.view addSubview:textView_];

        //* comment by anu
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        //textView_.font = [UIFont fontWithName:@"AmericanTypewriter" size:20];
        
        /*
         NSMutableArray *result = [NSMutableArray array];
         NSArray *families = [UIFont familyNames];
         
         for (NSString *family in families) {
         NSArray *names = [UIFont fontNamesForFamilyName: family];
         [result addObjectsFromArray:names];
         }
         [result sortUsingSelector:@selector(compare:)];
         NSLog([result description]);
         */
        
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        
        NSInteger textColor = [settings integerForKey:@"textColor"];
        NSInteger backgroundColor = [settings objectForKey: @"backgroundColor"] != NULL ? [settings integerForKey:@"backgroundColor"] : 3;
        NSString *fontName = [settings objectForKey: @"fontName"] != NULL ? [settings stringForKey:@"fontName"] : @"SourceCodePro-Regular";
        NSInteger fontSize = [settings objectForKey: @"fontSize"] != NULL ? [settings integerForKey:@"fontSize"] : 16;
        
        textView_.font = [UIFont fontWithName:fontName size:fontSize];
        textView_.textColor = [self getColorWithIndex:textColor];
        textView_.backgroundColor = [self getColorWithIndex:backgroundColor];
        
        //* textview delegate method is called
        textView_.delegate=self;
        
        
        UIBarButtonItem *undoButton_ = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoDidPush)];
        UIBarButtonItem *redoButton_ = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redoDidPush)];
        
        UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixed.width = 25;
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *leftButton_  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftArrow"] style:UIBarButtonItemStyleBordered target:self action:@selector(leftDidPush)];
        UIBarButtonItem *rightButton_  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"RightArrow"] style:UIBarButtonItemStyleBordered target:self action:@selector(rightDidPush)];
        
        //UIBarButtonItem *escapeButton  = [[UIBarButtonItem alloc] initWithTitle:@"&amp;" style:UIBarButtonItemStyleBordered target:self action:@selector(escapeDidPush)];
        
        segment_ = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Source", @"Browser", nil]];		segment_.selectedSegmentIndex = 1;
        segment_.frame = CGRectMake(0, 0, 130, 30);
        [segment_ addTarget:self action:@selector(segmentDidPush:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *segmentButton = [[UIBarButtonItem alloc] initWithCustomView:segment_];
        
        //UIBarButtonItem *safariButton  = [[UIBarButtonItem alloc] initWithTitle:@"Safari" style:UIBarButtonItemStyleBordered target:self action:@selector(safariDidPush)];
        //UIBarButtonItem *mailButton  = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(mailDidPush)];
        UIImage *packageIcon = [[UIImage imageNamed:@"Package"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *mailButton = [[UIBarButtonItem alloc] initWithImage:packageIcon style:UIBarButtonItemStylePlain target:self action:@selector(mailDidPush)];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
        [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.toolbar setTranslucent:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            // Show toolbar on iPhone
            NSArray *items = [NSArray arrayWithObjects:segmentButton, flexible, mailButton, nil];
            [self setToolbarItems:items];
            
            // Adjust font size on iPhone
            NSInteger fontSize = [settings objectForKey: @"fontSize"] != NULL ? [settings integerForKey:@"fontSize"] : 16;
            textView_.font = [UIFont fontWithName:fontName size:fontSize-2];
        } else {
            // Show toolbar on iPad
            
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
            self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
            self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            [self.view addSubview:self.toolbar];
            NSArray *items = [NSArray arrayWithObjects:flexible, undoButton_, redoButton_, fixed, leftButton_, rightButton_, flexible, segmentButton, fixed, mailButton, nil];
            [self.toolbar setItems:items];
        }
        
        
        //        if ([settings objectForKey:@"accessoryView"] == NULL || [settings boolForKey:@"accessoryView"]) {
        //            accessoryView_ = [[EdhitaAccessoryView alloc] initWithTextView:textView_];
        //            textView_.inputAccessoryView = accessoryView_;
        //        }
        
        //pathLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 10, self.view.frame.size.height - 40, self.view.frame.size.width / 2 - 10, 20)];
        //pathLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 40, self.view.frame.size.width - 40, 20)];
        //pathLabel_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        //pathLabel_.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        //pathLabel_.textAlignment = NSTextAlignmentRight;
        //pathLabel_.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        //pathLabel_.textColor = [UIColor whiteColor];
        //pathLabel_.text = @"test";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            // Show path on iPhone
            
        } else {
            // Show path on iPad
            [self.view addSubview:pathLabel_];
        }
        // WebView for Preview
        if ([Common isIpad]) {
            webView_ = [[UIWebView alloc] initWithFrame:CGRectMake(textView_.frame.origin.x, 88.0, textView_.frame.size.width, textView_.frame.size.height)];
        }
        else {
            webView_ = [[UIWebView alloc] initWithFrame:CGRectMake(textView_.frame.origin.x,64, textView_.frame.size.width, textView_.frame.size.height - 108.0)];
        }
        
        webView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        webView_.delegate = self;
        [self.view addSubview:webView_];
        //  webView_.hidden = YES;
        webView_.contentMode=UIViewContentModeScaleAspectFit;
        webView_.hidden = NO;
        
        /*
         UIView *splash = [[UIView alloc] initWithFrame:self.view.bounds];
         splash.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];;
         [self.view addSubview:splash];
         */
        webView_.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];
        

        // Network check, if yes - show Announcements, if no - show alert
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            NSLog(@"There IS NO internet connection");
            
            // LOCAL WELCOME SCREEN
            /*
             NSString *welcome = [[NSBundle mainBundle] pathForResource:@"Welcome" ofType:@"html"];
             self.path = welcome;
             segment_.selectedSegmentIndex = 1;
             webView_.hidden = NO;
             [self changeUrl];
             */
            
        } else {
            // INTERNET-CONNECTED WELCOME SCREEN
            
             NSLog(@"There IS internet connection - show Announcements");
             NSString *welcome = [[NSBundle mainBundle] pathForResource:@"Announcements" ofType:@"html"];
             self.path = welcome;
             segment_.selectedSegmentIndex = 1;
             webView_.hidden = NO;
             [self changeUrl];
             
        }
        
        /*
         NSString *welcome = [[NSBundle mainBundle] pathForResource:@"Welcome" ofType:@"html"];
         self.path = welcome;
         segment_.selectedSegmentIndex = 1;
         webView_.hidden = NO;
         [self changeUrl];
         */
        
        
        
        
        
        
    }
    return self;
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    
    if (!isKeyboardShown) {
        
        CGRect frameEnd = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        frameEnd = [self.view convertRect:frameEnd fromView:nil];
        frameEnd.size.height=0+44;
        CGRect textFrame = textView_.frame;
        textFrame.size.height =(textFrame.size.height- frameEnd.size.height);
        textView_.frame = textFrame;
         [self disableButton_];
        isKeyboardShown = YES;
    }
    else {
        
        CGRect frameBegin = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect frameEnd = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        frameBegin = [self.view convertRect:frameBegin fromView:nil];
        frameEnd = [self.view convertRect:frameEnd fromView:nil];
        
        CGFloat heightDiff = (frameEnd.size.height - frameBegin.size.height);
        
        if (heightDiff != 0) {
            CGRect textFrame = textView_.frame;
            textFrame.size.height -= heightDiff;
            
        }
        
        
        
    }
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//        //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingAction:)];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HideKey"] style:UIBarButtonItemStylePlain target:self action:@selector(doneEditingAction:)];
//    }
//    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
//        //[self enableButton_];
//         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HideKey"] style:UIBarButtonItemStylePlain target:self action:@selector(doneEditingAction:)];
//
//    }
//    
    //[self enableButton_];
}

- (void)keyboardWasHidden:(NSNotification *)aNotification {
    CGRect frameEnd = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    frameEnd = [self.view convertRect:frameEnd fromView:nil];
    
    CGRect textFrame = textView_.frame;
    textFrame.size.height += frameEnd.size.height;
    textView_.frame = textFrame;
    
    isKeyboardShown = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        self.navigationItem.rightBarButtonItem = nil;
    }
   else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self disableButton_];
}


- (IBAction)doneEditingAction:(id)sender
{
    [textView_ resignFirstResponder];
}


- (void)enableButton_ {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        // Do nothing for iPhone
    }
    
    else  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
         NSArray *items = [self.toolbar items];
        ((UIBarButtonItem *)[items objectAtIndex:1]).enabled = YES;
        ((UIBarButtonItem *)[items objectAtIndex:2]).enabled = YES;
        ((UIBarButtonItem *)[items objectAtIndex:3]).enabled = YES;
        ((UIBarButtonItem *)[items objectAtIndex:4]).enabled = YES;
        ((UIBarButtonItem *)[items objectAtIndex:5]).enabled = YES;
        ((UIBarButtonItem *)[items objectAtIndex:6]).enabled = YES;
    }
}

- (void)disableButton_ {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        // Do nothing for iPhone
    }
    
    
    else  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        NSArray *items = [self.toolbar items];
        ((UIBarButtonItem *)[items objectAtIndex:1]).enabled = NO;
        ((UIBarButtonItem *)[items objectAtIndex:2]).enabled = NO;
        ((UIBarButtonItem *)[items objectAtIndex:3]).enabled = NO;
        ((UIBarButtonItem *)[items objectAtIndex:4]).enabled = NO;
        ((UIBarButtonItem *)[items objectAtIndex:5]).enabled = NO;
        ((UIBarButtonItem *)[items objectAtIndex:6]).enabled = NO;
    }
}

- (void)setPath:(NSString *)path {
    
    [self saveContents];
    
    path_ = path;
    NSError *error;
    
    NSLog(@"%@", path);
    
    // Show image if there is an image
    if ([UIImage imageWithContentsOfFile:self.path]) {
        
        // Show image
        webView_.hidden = NO;
        NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:self.path]];
        webView_.scalesPageToFit=YES;
        [webView_ loadRequest:request];
        textView_ = nil;
        
        // Customize toolbar
        UIBarButtonItem *mailButton  = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(mailDidPush)];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            // Show toolbar on iPhone
            NSArray *items = [NSArray arrayWithObjects:flexible, mailButton, nil];
            [self setToolbarItems:items];
        } else {
            // Show toolbar on iPad
            [self.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
            [self.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
            [self.toolbar setTranslucent:YES];
            NSArray *items = [NSArray arrayWithObjects:flexible, mailButton, nil];
            [self.toolbar setItems:items];
        }
    }
    else
    {
        textView_.text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        
        NSString *homeDir = NSHomeDirectory();
        //NSString *docDir = [homeDir stringByAppendingPathComponent:@"Documents"];
        NSArray *components = [path componentsSeparatedByString:homeDir];
        
        NSLog(@"%@", components);
        
        pathLabel_.text=@"";
        
        if(components.count>0)
            pathLabel_.text = [components objectAtIndex:(components.count-1)];
        
        /*
         if (segment_.selectedSegmentIndex == 1) {
         [self changeUrl];
         }
         */
        
        segment_.selectedSegmentIndex = 0;
        webView_.hidden = YES;
        
        
        
    }
    
    
    
}

- (void)saveContents {
    
    NSError *error;
    [textView_.text writeToFile:path_ atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}

- (UIColor *)getColorWithIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            return [UIColor blackColor];
            break;
        case 1:
            return [UIColor darkGrayColor];
            break;
        case 2:
            return [UIColor lightGrayColor];
            break;
        case 3:
            return [UIColor whiteColor];
            break;
        case 4:
            return [UIColor grayColor];
            break;
        case 5:
            return [UIColor redColor];
            break;
        case 6:
            return [UIColor greenColor];
            break;
        case 7:
            return [UIColor blueColor];
            break;
        case 8:
            return [UIColor cyanColor];
            break;
        case 9:
            return [UIColor yellowColor];
            break;
        case 10:
            return [UIColor magentaColor];
            break;
        case 11:
            return [UIColor orangeColor];
            break;
        case 12:
            return [UIColor purpleColor];
            break;
        case 13:
            return [UIColor brownColor];
            break;
        default:
            return [UIColor blackColor];
            break;
    }
}

- (void)undoDidPush {
    [[textView_ undoManager] undo];
}

- (void)redoDidPush {
    [[textView_ undoManager] redo];
}

- (void)leftDidPush {
    NSRange range = textView_.selectedRange;
    textView_.selectedRange = NSMakeRange(range.location - 1, range.length);
    [[textView_ undoManager] registerUndoWithTarget:self selector:@selector(rightDidPush) object:nil];
}

- (void)rightDidPush {
    NSRange range = textView_.selectedRange;
    textView_.selectedRange = NSMakeRange(range.location + 1, range.length);
    [[textView_ undoManager] registerUndoWithTarget:self selector:@selector(leftDidPush) object:nil];
}

//- (void)escapeDidPush {

/*
 
 NSMutableString *text = [textView_.text mutableCopy];
	
	[text replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	
	NSLog(@"%d", textView_.dataDetectorTypes);
	textView_.dataDetectorTypes = UIDataDetectorTypeNone;
	NSLog(@"%d", textView_.dataDetectorTypes);
	
	
	NSLog(@"before: %@", textView_.text);
	NSLog(@"before text: %@", text);
	NSString *test = [NSString stringWithFormat:@"%@ %@", @"%26lt%3B", @"\&&amp;\gt\;"];
	textView_.text = test;
	NSLog(test);
	NSLog(@"after: %@", textView_.text);
	NSLog(@"after text: %@", text);
 
	[[textView_ undoManager] registerUndoWithTarget:self selector:@selector(rightDidPush) object:nil];
 */
/*
	NSMutableString *text = [textView_.text mutableCopy];
	NSRange range = textView_.selectedRange;
	NSMutableString *selectedString = [[text substringWithRange:range] mutableCopy];
	
	[selectedString replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[selectedString replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[selectedString replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	
	NSLog(@"before: %@", textView_.text);
	NSLog(@"before text: %@", text);
	[text replaceCharactersInRange:range withString:selectedString];
	textView_.text = text;
	NSLog(@"after: %@", textView_.text);
	NSLog(@"after text: %@", text);
 */

/*
 
	NSRange range = textView_.selectedRange;
	NSLog(@"0: %d, %d : %d", range.location, range.length, [textView_.text length]);
	NSMutableString *text = [[textView_.text substringWithRange:range] mutableCopy];
	NSLog(@"1: %@", text);
 
	[text replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	NSLog(@"2: %@", text);
	
	NSMutableString *text2 = [textView_.text mutableCopy];
	[text2 replaceCharactersInRange:range withString:text];
	textView_.text = text2;
	NSLog(@"3: %@", text2);
	NSLog(textView_.text);
	NSLog(@"%d, %d", [textView_.text length], [text2 length]);
	
	textView_.selectedRange = NSMakeRange([textView_.text length], 0);
 */
/*
	text = [text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	text = [text stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	text = [text stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
 
	NSMutableString *mutable = [textView_.text mutableCopy];
	[mutable replaceCharactersInRange:range withString:text];
	textView_.text = mutable;
 */
//}

- (void)segmentDidPush:(UISegmentedControl *)sender {
    
    if (0 == sender.selectedSegmentIndex) {
        
        //[UIView beginAnimations:nil context:NULL];
        //[UIView setAnimationDuration:0.5];
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        
        webView_.hidden = YES;
        
        //[UIView commitAnimations];
        
    }
    else if (1 == sender.selectedSegmentIndex) {
        
        //[UIView beginAnimations:nil context:NULL];
        //[UIView setAnimationDuration:0.5];
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        
        [self saveContents];
        [self changeUrl];
        
        webView_.hidden = NO;
        
        //[UIView commitAnimations];
    }
    
}

- (void)changeUrl {
    
    webViewReloaded = NO;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // <meta charset="UTF-8" />しないと文字化けする
    NSURL *url = [NSURL fileURLWithPath:path_];
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
    [webView_ loadRequest:req];
    
}

// MobileSafari
/*
 - (void)safariDidPush {
 
	NSURL *url = [NSURL fileURLWithPath:path_];
	[[UIApplication sharedApplication] openURL:url];
	NSLog(@"test");
 }
 */

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    /*
     if (!webViewReloaded) {
     webViewReloaded = YES;
     //		[webView_ reload];
     }
     else {
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     }
     */
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)mailDidPush {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
        
        mailViewController.mailComposeDelegate = self;
        
        NSData *data = [NSData dataWithContentsOfFile:path_];
        [mailViewController setSubject:[path_ lastPathComponent]];
        [mailViewController setMessageBody:@"See attachment." isHTML:NO];
        // [mailViewController setMessageBody:textView_.text isHTML:NO];
        [mailViewController addAttachmentData:data mimeType:@"text/plain" fileName:[path_ lastPathComponent]];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation
                                            duration:duration];
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        accessoryView_.contentSize = CGSizeMake(768 * 2, 0);
    }
    else {
        accessoryView_.contentSize = CGSizeMake(1024 * 2, 0);
    }
}

@end
