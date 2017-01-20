//
//  EdhitaAccessoryView.m
//  HTML Studio
//
//  Created by Justin Bush on 10/31/13.
//  Copyright RevBlaze 2013. All rights reserved.
//

#import "EdhitaAccessoryView.h"


@implementation EdhitaAccessoryView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithTextView:(UITextView *)textView {
	if (self = [super init]) {
		
		textView_ = textView;

		NSArray *titles = [NSArray arrayWithObjects:

						   @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"'", @"\"", @"<", @">",
						   @"tab",
						   @"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"=", @"_", @"\\", @"|", @"~", nil];
		
		NSInteger padding = 8;
		NSInteger margin = 8;
		NSInteger size = 46;
		
		self.frame = CGRectMake(0, 0, 768, size + padding * 2);
		self.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:211.0f/255.0f blue:213.0f/255.0f alpha:1.0];
		self.contentSize = CGSizeMake(768 * 2, 0);

		NSInteger i = 0;
		for (NSString *title in titles) {

			UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

			if (i < 14) {
				button.frame = CGRectMake((size + margin) * i + padding, padding, size, size);
			}
			else {
				button.frame = CGRectMake((size + margin) * i + padding + padding + padding, padding, size, size);
			}
			
            [button setBackgroundImage:[UIImage imageNamed:@"ButtonBack"] forState:UIControlStateNormal];
			
			button.titleLabel.font = [UIFont systemFontOfSize: 18];
			[button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			
			if ([title isEqualToString:@"tab"] != YES) {
				[button addTarget:self action:@selector(insertDidPush:) forControlEvents:UIControlEventTouchUpInside];				
			} 
			else {
				[button addTarget:self action:@selector(tabDidPush) forControlEvents:UIControlEventTouchUpInside];
			}
			
			[self addSubview:button];
			i++;
		}

		/*
		NSInteger biggerWidth = 52;
		 
		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		button.frame = CGRectMake((size + margin) * i++ + padding, padding, biggerWidth, size);
		[button setTitle:@"&amp;" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(escapeDidPush) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		button.frame = CGRectMake((size + margin) * i++ + padding + biggerWidth - size, padding, biggerWidth, size);
		[button setTitle:@"&" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(unescapeDidPush) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
        */
		
	}
	return self;
}
- (void)insertDidPush:(UIButton *)button {
	[self insertString:button.titleLabel.text];
}

- (void)tabDidPush {
	[self insertString:@"\t"];
}

- (void)insertString:(NSString *)string {

	NSMutableString *text = [textView_.text mutableCopy];

	NSRange range = textView_.selectedRange;
	[text replaceCharactersInRange:range withString:string];

    //NSLog(@"before %@", textView_.text);
	textView_.text = text;
    //NSLog(@"after %@", textView_.text);
	textView_.selectedRange = NSMakeRange(range.location + 1, range.length);
    //NSLog(@"after %@", textView_.text);

	//[[textView_ undoManager] registerUndoWithTarget:self selector:@selector(backSpace:) object:string];
    
}

- (void)backSpace:(NSString *)string {
	
	NSMutableString *text = [textView_.text mutableCopy];
	
	NSRange range = textView_.selectedRange;
	textView_.selectedRange = NSMakeRange(range.location - 1, 1);
	[text replaceCharactersInRange:textView_.selectedRange withString:@""];
	textView_.text = text;
	
	textView_.selectedRange = NSMakeRange(range.location - 1, range.length);
	
    //[[textView_ undoManager] registerUndoWithTarget:self selector:@selector(insertString:) object:string];
    
}

/*
- (void)escapeDidPush {
	NSRange range = textView_.selectedRange;
	NSString *text = [textView_.text substringWithRange:range];
	
	text = [text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	text = [text stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	text = [text stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];

	NSMutableString *mutable = [textView_.text mutableCopy];
	[mutable replaceCharactersInRange:range withString:text];	
	textView_.text = mutable;
}

- (void)unescapeDidPush {
	NSRange range = textView_.selectedRange;
	NSString *text = [textView_.text substringWithRange:range];
	text = [text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	text = [text stringByReplacingOccurrencesOfString:@"&gt" withString:@">"];	
	textView_.text = text;
}
*/


@end
