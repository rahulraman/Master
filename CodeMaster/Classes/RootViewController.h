//
//  RootViewController.h
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdhitaFileViewController.h"
#import "EdhitaAppDelegate.h"
#import "DetailViewController.h"

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
	NSMutableArray *items_;
	NSArray *images_;
	NSString *path_;
	UIView *downloadView_;
	UITextField *urlField_;
	UILabel *messageLabel_;
	
	// HTTP
	NSMutableData *downloadBuffer_;
}

//@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, strong) DetailViewController *detailViewController;

- (void)newFileDidPush;
- (void)newDirDidPush;
- (NSString *)nextFileName:fileName withExtension:(NSString *)extenstion;

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (CGSize)contentSizeForViewInPopover;

- (void)downloadDidPush;
- (void)dlDidPush;

- (NSString *)encodeURI:(NSString *)string;

- (id)initWithPath:(NSString *)path;

@end
