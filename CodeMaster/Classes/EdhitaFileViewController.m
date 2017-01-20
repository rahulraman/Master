//
//  EdhitaTableViewController.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "EdhitaFileViewController.h"

@implementation EdhitaFileViewController

@synthesize detailViewController;

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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];

}

- (void)viewWillDisappear:(BOOL)animated {
	[self renameFile];
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Status Bar

- (BOOL)prefersStatusBarHidden
{
    return NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items_ count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

	// Configure the cell...
	cell.textLabel.text = [items_ objectAtIndex:indexPath.row];
	
	
	NSError *error;
	NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path_ error:&error];

    if (indexPath.row == 0) {
		textField_ = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.size.width * 0.3, 0, cell.frame.size.width * 0.6, cell.frame.size.height)];
		textField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		textField_.textAlignment = NSTextAlignmentRight;
		textField_.delegate = self;
		textField_.text = [path_ lastPathComponent];
		textField_.returnKeyType = UIReturnKeyDone;
		textField_.clearButtonMode = UITextFieldViewModeWhileEditing;
		[textField_ becomeFirstResponder];		
		[cell.contentView addSubview:textField_];
		textField_.autocorrectionType = UITextAutocorrectionTypeNo;
		textField_.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField_.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
	else {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width * 0.3, 0, cell.frame.size.width * 0.6, cell.frame.size.height)];
		label.textAlignment = NSTextAlignmentRight;
		label.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:label];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;

		if(indexPath.row == 1) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"Y-MM-dd HH:mm:ss"];
			label.text = [dateFormatter stringFromDate:[attributes objectForKey:NSFileModificationDate]];						
		}
		else if(indexPath.row == 2) {
			label.text = [NSString stringWithFormat:@"%@ bytes", [attributes objectForKey:NSFileSize]];
		}
	}

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
}


#pragma mark -
#pragma mark Memory management


- (id)initWithPath:(NSString *)path {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		items_ = [NSArray arrayWithObjects: @"Name", @"Modified", @"Size", nil];
		path_ = path;
		self.title = [path_ lastPathComponent];
		textField_ = [[UITextField alloc] init];
	}
	return self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self renameFile];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

- (void)renameFile {
	NSError *error;
	NSString *dstPath = [[path_ stringByDeletingLastPathComponent] stringByAppendingPathComponent:textField_.text];
	[[NSFileManager defaultManager] moveItemAtPath:path_ toPath:dstPath error:&error];
}

- (CGSize)contentSizeForViewInPopover {
	return CGSizeMake(320, 527);
}


@end

