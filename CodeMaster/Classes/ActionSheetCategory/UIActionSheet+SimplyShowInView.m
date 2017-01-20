//
//  UIActionSheet+SimplyShowInView.m
//  HTML Studio
//
//  Created by Anuroop Singhal on 05/10/14.
//
//

#import "UIActionSheet+SimplyShowInView.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation UIActionSheet (SimplyShowInView)

- (void) simplyShowInView:(UIView *) view
{
    if(SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        [self showInView:view];
    }
    else
    {
        // "Translating" UIActionSheet to UIAlertController for better compatibility with iOS 8
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:self.title preferredStyle:UIAlertControllerStyleActionSheet];
        NSInteger nactions = [self numberOfButtons];
        int i=0;
        while(i<nactions)
        {
            NSString *button_title=[self buttonTitleAtIndex:i];
            UIAlertActionStyle style=UIAlertActionStyleDefault;
            if(i==[self cancelButtonIndex])
            {
                style = UIAlertActionStyleCancel;
            }
            else if(i==[self destructiveButtonIndex])
            {
                style = UIAlertActionStyleDestructive;
            }
            
            UIAlertAction *newAction = [UIAlertAction actionWithTitle:button_title style:style handler:^(UIAlertAction *action) {
                NSLog(@"clicked action %d",i);
                [self.delegate actionSheet:self clickedButtonAtIndex:i];
            }];
            
            [alert addAction:newAction];
            i++;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [alert setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [alert
                                                             popoverPresentationController];
            popPresenter.sourceView = view;
            popPresenter.sourceRect = CGRectMake(view.frame.size.width/2-1, 0.45*view.frame.size.height, 2, 1);
            popPresenter.permittedArrowDirections = 0;
        }
        UIViewController *sourceViewController;
        if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(presentViewController:animated:completion:)])
        {
            NSLog(@"presenting UIAlertController on source view controller");
            sourceViewController=(UIViewController *)(self.delegate);
        }
        else
        {
            // When the actionsheet delegate is not a UIViewController
            NSLog(@"presenting UIAlertController on displayed view controller");
            //sourceViewController = /* Set up a method here to obtain the view controller where you want to display it */
        }
        [sourceViewController presentViewController:alert animated:YES completion:nil];
    }
}

@end
