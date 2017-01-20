//
//  TemplateViewController.h
//  HTML Studio
//
//  Created by Do Quang Tri on 7/31/14.
//
//

#import <UIKit/UIKit.h>

@interface TemplateViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate> {
    UICollectionView *_collectionView;
    NSIndexPath *currentIndexPath;
}

@property (nonatomic, strong) NSString *path_;

@end
