//
//  EdhitaTableViewController.h
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface EdhitaFileViewController : UITableViewController <UITextFieldDelegate> {
	NSArray *items_;
	NSString *path_;
	UITextField *textField_;
	DetailViewController *detailViewController;
}

@property (nonatomic, strong) DetailViewController *detailViewController;

- (id)initWithPath:(NSString *)path;

- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
	
- (void)renameFile;

- (CGSize)contentSizeForViewInPopover;

@end
