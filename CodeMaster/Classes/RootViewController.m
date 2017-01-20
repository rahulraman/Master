//
//  RootViewController.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "Common.h"
#import "TemplateViewController.h"
#import "RootViewController.h"
#import "PXAlertView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIActionSheet+SimplyShowInView.h"

@interface RootViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIImagePickerController * imagePicker;

@end

@implementation RootViewController

@synthesize detailViewController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor grayColor]];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
 
    [self.navigationController.navigationBar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"BackIcon"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"BackIcon"];
    
    // Upgrade to Pro Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PRO" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert:)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];

}

- (void) showAlert:(id)sender
{
    UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"What is Pro?"
                                                     message:@"Code Master Pro is the professional edition of this app, available on the App Store. Would you like to check it out? It's got everything this app has, with a lot more features packed into it."
                                                    delegate:self
                                           cancelButtonTitle:@"No Thanks"
                                           otherButtonTitles:@"Learn More",nil];
    [_alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 1 ) /* NO = 0, YES = 1 */
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/code-master-pro/id510839270?ls=1&mt=8"]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	NSError *error;
	items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:&error] mutableCopy];
    
    NSLog(@"%@ - %@", path_, items_);

	[self.tableView reloadData];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.toolbar setTranslucent:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                       NSFontAttributeName:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size: 20.0f]
                                                                       }];
    
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

/*
#pragma mark -
#pragma mark Status Bar

- (BOOL)prefersStatusBarHidden {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        return NO;
        
    } else {
        return YES;
    }
}
 */

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView* view = gestureRecognizer.view;
    CGPoint loc = [gestureRecognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if (urlField_ != subview) {
        [urlField_ resignFirstResponder];
    }
    
    if ([touch.view isDescendantOfView:self.tableView]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    else
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    // Configure the cell.
    /*
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectionColor;
     */
    
    UIFont *customFont = [UIFont fontWithName:@"SanFranciscoDisplay-Regular" size:18.0f];
    cell.textLabel.font = customFont;
    cell.textLabel.textColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.16 alpha:1.0];
    cell.backgroundColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    NSString *text = [items_ objectAtIndex:indexPath.row];
	cell.textLabel.text = text;
	BOOL isDir;
	NSString *path = [path_ stringByAppendingPathComponent:text];
	[[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (isDir) {
        cell.imageView.image = [images_ objectAtIndex:isDir];
    }
    else {
        cell.imageView.image = [Common getFileImage:[path pathExtension]];
    }
	
	
	return cell;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		detailViewController.path = [[NSBundle mainBundle] pathForResource:@"Delete" ofType:@"txt"];

		NSString *path = [path_ stringByAppendingPathComponent:[items_ objectAtIndex:indexPath.row]];
		NSError* error;
		
		[[NSFileManager defaultManager] removeItemAtPath:path error:&error];
		
		[items_ removeObjectAtIndex:indexPath.row];
		
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];		
    }
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
	NSString *path = [path_ stringByAppendingPathComponent:[items_ objectAtIndex:indexPath.row]];

	BOOL isDir;

	[[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];

	if (isDir) {		
		RootViewController *rootViewController = [[RootViewController alloc] initWithPath:path];
		rootViewController.detailViewController = self.detailViewController;
		[self.navigationController pushViewController:rootViewController animated:YES];
		detailViewController.path = [[NSBundle mainBundle] pathForResource:@"Directory" ofType:@"txt"];
	}
	else {
        // Open file
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {

            // iPhone code
            DetailViewController * controller = [[DetailViewController alloc] init];
            NSLog(@"%@", path);
            
            controller.path = path;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else {
            
            // iPAd code
            detailViewController.path = path;
            if (detailViewController.popoverController && detailViewController.popoverController.popoverVisible) {
                [detailViewController.popoverController dismissPopoverAnimated:YES];
            }
        }
        
	}
	
}


#pragma mark -
#pragma mark Memory management


- (id)initWithPath:(NSString *)path {
	if (self = [super init]) {
		path_ = path;
		self.title = [path lastPathComponent];

        if([[path lastPathComponent] isEqualToString:@"Files"])
            self.title=@"My Documents";
        
		NSError *error;
		items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error] mutableCopy];

        UIImage* fileImage = [UIImage imageNamed:@"File"];
		UIImage* dirImage = [UIImage imageNamed:@"Folder"];
		images_ = [NSArray arrayWithObjects:fileImage, dirImage, nil];

		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *addBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];

		// Download via HTTP Button
        /*
        UIImage *image = [[UIImage imageNamed:@"DownloadIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *downloadButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(downloadDidPush)];
        
				
		NSArray *items = [NSArray arrayWithObjects:downloadButton, space, addBarButtonItem, nil];
		[self setToolbarItems:items];
         */
        
        NSArray *items = [NSArray arrayWithObjects: space, addBarButtonItem, space, nil];
        [self setToolbarItems:items];

        self.navigationItem.rightBarButtonItem = [self editButtonItem];
		
		// Download
		downloadView_ = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
		downloadView_.backgroundColor = [UIColor blackColor];
		downloadView_.opaque = NO;
		
		urlField_ = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 245, 30)];
		urlField_.borderStyle = UITextBorderStyleRoundedRect;
		urlField_.placeholder = @"http://";
		urlField_.text = @"http://";
		urlField_.keyboardType = UIKeyboardTypeURL;
		urlField_.clearButtonMode = UITextFieldViewModeWhileEditing;
        urlField_.autocorrectionType = UITextAutocorrectionTypeNo;
        urlField_.autocapitalizationType = UITextAutocapitalizationTypeNone;
		
		UIButton *dlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[dlButton setTitle:@"↓" forState:UIControlStateNormal];
		[dlButton sizeToFit];
		dlButton.frame = CGRectMake(265, 10, 45, 30);
		[dlButton addTarget:self action:@selector(dlDidPush) forControlEvents:UIControlEventTouchUpInside];
		
		messageLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 20) ];
		messageLabel_.backgroundColor = [UIColor blackColor];
		messageLabel_.textAlignment = NSTextAlignmentCenter;
		
		[downloadView_ addSubview:urlField_];
		[downloadView_ addSubview:dlButton];
		[downloadView_ addSubview:messageLabel_];

	}
	return self;
}

NSString *htmlContents = @"<!doctype html>\r<html>\r<head>\r<title>Document</title>\r</head>\r\r<body>\r</body>\r</html>\r";
NSString *phpContents = @"<!doctype html>\r<html>\r<head>\r<title>Document</title>\r</head>\r\r<body>\r</body>\r</html>\r";
NSString *cssContents = @"/* CSS Document */";
NSString *jsContents = @"// JavaScript Document";


#pragma mark - Add Action

- (IBAction)addAction:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"New File", @"New Folder", @"Import Media", @"Add Template",nil];
    
    [popup simplyShowInView:[[UIApplication sharedApplication] keyWindow]];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // New File selected
        [self newFileDidPush];
    } else if (buttonIndex == 1) {
        // New Folder selected
        [self newDirDidPush];
        
    } else if (buttonIndex == 2) {
        // Add Media selected
        // Choose from Library
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
//        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
        
    } else if (buttonIndex == 3) {
        // Add Template selected
        TemplateViewController *templateVC = [[TemplateViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
        templateVC.path_ = path_;
        [self.navigationController pushViewController:templateVC animated:YES];
        
    } else if (buttonIndex == 4) {
        // Cancel
    }
}

- (void)newFileDidPush {
    
    [PXAlertView showAlertWithTitle:@"New File"
                            message:@"Select a file type to create"
                        cancelTitle:@"HTML"
                        otherTitles:@[ @"PHP", @"StyleSheet", @"JavaScript", @"Text", @"Other", @"Cancel" ]
                        contentView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FileSelect"]]
                         completion:^(BOOL cancelled, NSInteger buttonIndex) {
                             if (cancelled) {
                                 NSLog(@"HTML Button Pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@".html"];
                                 NSString *fileContents = htmlContents;
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else if (buttonIndex == 1) {
                                 NSLog(@"PHP button pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@".php"];
                                 NSString *fileContents = phpContents;
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else if (buttonIndex == 2) {
                                 NSLog(@"CSS button pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@".css"];
                                 NSString *fileContents = cssContents;
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else if (buttonIndex == 3) {
                                 NSLog(@"JS button pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@".js"];
                                 NSString *fileContents = jsContents;
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else if (buttonIndex == 4) {
                                 NSLog(@"TXT button pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@".txt"];
                                 NSString *fileContents = @"";
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else if (buttonIndex == 5) {
                                 NSLog(@"Other button pressed");
                                 NSError *error;
                                 
                                 NSString *fileName = [self nextFileName:@"Untitled" withExtension:@""];
                                 NSString *fileContents = @"";
                                 
                                 NSString *filePath = [path_ stringByAppendingPathComponent:fileName];
                                 [fileContents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                                 
                                 items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
                                 [self.tableView reloadData];
                             }
                             
                             else {
                                 NSLog(@"Cancel button pressed");
                             }
                         }];
}

- (void)newDirDidPush {

	NSError *error;
	
	NSString *dirName = [self nextFileName:@"Folder" withExtension:@""];

	NSString *dirPath = [path_ stringByAppendingPathComponent:dirName];
	[[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
	
    items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
	[self.tableView reloadData];
}

- (NSString *)nextFileName:fileName withExtension:(NSString *)extenstion {
	if ([items_ indexOfObject:[fileName stringByAppendingFormat:@"%@", extenstion]] != NSNotFound) {
		
		int i = 2;		
		NSString *newFileName;
		
		while (i < 1024) {
			newFileName = [fileName stringByAppendingFormat:@"(%d)%@", i, extenstion];
			if([items_ indexOfObject:newFileName] == NSNotFound) {
				return newFileName;
			}
			i++;
		}
	}
	return [fileName stringByAppendingFormat:@"%@", extenstion];
}

#pragma mark - Media Picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // get the ref url
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset) {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];

        // Load image data
        Byte *buffer = (Byte*)malloc(imageRep.size);
        NSUInteger buffered = [imageRep getBytes:buffer fromOffset:0.0 length:imageRep.size error:nil];
        NSData *imageData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        
        // Write image data to file
        NSString * imageName = imageRep.filename;
        NSString *filePath = [path_ stringByAppendingPathComponent:imageName];
        [imageData writeToFile:filePath atomically:YES];
        
        // Update UI
        items_ = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_ error:nil] mutableCopy];
        [self.tableView reloadData];
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
 
    
    // Close image picker
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.imagePicker = nil;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.imagePicker = nil;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

	NSString *path = [path_ stringByAppendingPathComponent: [items_ objectAtIndex:indexPath.row]];
	EdhitaFileViewController *tableViewController = [[EdhitaFileViewController alloc] initWithPath:path];
	tableViewController.detailViewController = self.detailViewController;
	[self.navigationController pushViewController:tableViewController animated:YES];
}

- (CGSize)contentSizeForViewInPopover {
	return CGSizeMake(320, 527);
}

- (void)downloadDidPush {

	if (self.tableView.tableHeaderView == nil) {
		self.tableView.tableHeaderView = downloadView_;
//		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	} else {
		self.tableView.tableHeaderView = nil;
		downloadView_.frame = CGRectMake(0, 0, 320, 50);
		messageLabel_.text = @"";
		self.tableView.tableHeaderView = downloadView_;
//		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	}
	
}

- (void)dlDidPush {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	self.tableView.tableHeaderView = nil;
	downloadView_.frame = CGRectMake(0, 0, 320, 80);
	self.tableView.tableHeaderView = downloadView_;
	
	NSURL *url = [NSURL URLWithString:[self encodeURI:urlField_.text]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

	if (connection) {
//		NSLog(@"connected.");
	} else {
		messageLabel_.textColor = [UIColor orangeColor];	
		messageLabel_.text = @"Can't Connect";		
	}
}

// Start Download
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	downloadBuffer_ = [NSMutableData data];
}

// Progress
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[downloadBuffer_ appendData: data];
}

// Finish
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	NSString *name = [urlField_.text lastPathComponent];
	BOOL success = [downloadBuffer_ writeToFile:[path_ stringByAppendingPathComponent:name] atomically:YES];

	if (success) {
		if ([items_ containsObject:name] != YES) {
			[items_ addObject:name];
			[self.tableView reloadData];
//			[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:items_.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

			messageLabel_.textColor = [UIColor cyanColor];	
			messageLabel_.text = [NSString stringWithFormat:@"Saved as \"%@\"", name];
		} else {
			messageLabel_.textColor = [UIColor cyanColor];	
			messageLabel_.text = [NSString stringWithFormat:@"\"%@\" is overwritten", name];
		}
	}
	else {
		messageLabel_.textColor = [UIColor orangeColor];	
		messageLabel_.text = @"Download Error";		
	}
}

// Error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	messageLabel_.textColor = [UIColor orangeColor];	
	messageLabel_.text = [error localizedDescription];		
}

- (NSString *)encodeURI:(NSString *)string {
	NSString *escaped = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, NULL, kCFStringEncodingUTF8));
	return escaped;
}

@end

