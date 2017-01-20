//
//  EdhitaAccessoryView.h
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EdhitaAccessoryView : UIScrollView {
	UITextView *textView_;
}

- (id)initWithTextView:(UITextView *)textView;

- (void)insertDidPush:(UIButton *)button;
- (void)tabDidPush;
- (void)insertString:(NSString *)string;
- (void)backSpace:(NSString *)string;


@end
