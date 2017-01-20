//
//  DetailViewController.h
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdhitaAccessoryView.h"
#import <MessageUI/MessageUI.h>

#import "QEDTextView.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UIWebViewDelegate, MFMailComposeViewControllerDelegate,UITextViewDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    id detailItem;
    UILabel *detailDescriptionLabel;
	
	//UITextView *textView_;
    QEDTextView *textView_;

	BOOL isKeyboardShown;
	
	NSString *path_;
	UILabel *pathLabel_;
	
	UIWebView *webView_;
	BOOL webViewReloaded;
	
	UISegmentedControl *segment_;	
	
	EdhitaAccessoryView *accessoryView_;
}

//@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, strong) id detailItem;
//@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, strong) UILabel *detailDescriptionLabel;

@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) UIPopoverController *popoverController;

- (void)keyboardWasShown:(NSNotification *)aNotification;
- (void)keyboardWasHidden:(NSNotification *)aNotification;
- (void)enableButton_;
- (void)disableButton_;

- (void)saveContents;
- (UIColor *)getColorWithIndex:(NSInteger)index;

- (void)undoDidPush;
- (void)redoDidPush;

- (void)leftDidPush;
- (void)rightDidPush;

//- (void)escapeDidPush;

- (void)segmentDidPush:(UISegmentedControl *)sender;
- (void)changeUrl;
//- (void)safariDidPush;

- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

- (void)mailDidPush;

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;

@end
