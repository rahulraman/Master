//
//  TemplateViewController.m
//  HTML Studio
//
//  Created by Do Quang Tri on 7/31/14.
//
//

#import "Common.h"
#import "TemplateViewController.h"

@interface TemplateViewController ()
{
    NSString * docPath;
    BOOL isIpad;
}
@property (nonatomic, strong) NSArray *arrTemplates;
@end

@implementation TemplateViewController

@synthesize path_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0]];
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    //[self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0]];
   // [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    //[self.navigationController.navigationBar setTranslucent:YES];
   // [self.navigationController.toolbar setTranslucent:YES];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    [self.navigationController.navigationBar setTitleTextAttributes: @{
//                                                                       NSForegroundColorAttributeName:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0],
//                                                                       NSFontAttributeName:[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size: 20.0f]
//                                                                       }];
    [self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationItem.title = @"Templates";
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString * documentsPath = [resourcePath stringByAppendingPathComponent:@"Templates"];
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
    NSArray *files = [directoryContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.png'"]];
    self.arrTemplates = files;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    CGRect frame;
    if ([Common isIpad]) {
        //frame = CGRectMake(0, 0, 310, self.view.frame.size.height);
        
        frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }
    else
    {
        frame = self.view.frame;
    }
    
    [_collectionView removeFromSuperview];
    _collectionView=nil;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    NSLog(@"frame : %@",NSStringFromCGRect(self.view.frame));
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    //[_collectionView setBackgroundColor:[UIColor colorWithRed:0.1568f green:0.1568f blue:0.1568f alpha:1.0f]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    if ([Common isIpad]) {
    //        [flowLayout setItemSize:CGSizeMake(290, 381)]; //610 x 762
    //    }
    //    else {
    //        [flowLayout setItemSize:CGSizeMake(145, 181)];
    //    }
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [_collectionView setCollectionViewLayout:flowLayout];
    
    if (![Common isIpad])
        [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self.view addSubview:_collectionView];
    
    /*
     UIImage *image = [UIImage imageNamed:@"TemplatesLogo"];
     UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
     self.navigationItem.titleView = imgView;
     */
    
    //no under top bars and bottom bars.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        //self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UILabel *poweredBy;
    poweredBy.text = @"HTML5Up";
    poweredBy.textColor = [UIColor whiteColor];
    poweredBy.textAlignment = NSTextAlignmentCenter;

    docPath = [self applicationDocumentsDirectory];
    isIpad = [Common isIpad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //    if ([Common isIpad]) {
    //        return 1;
    //    }
    //    return 2;
    
    return [self.arrTemplates count];
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (isIpad) {
        return UIEdgeInsetsMake(7,10,7,10);
    }
    else {
        return UIEdgeInsetsMake(10,25,10,25);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isIpad) {
        return CGSizeMake(290, 381);
    }
    else {
        return CGSizeMake(145, 181);
    }
}


// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //    if ([Common isIpad]) {
    //        return 20;
    //    }
    //    return 10;
    
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    //    if (!cell) {
    //        CGRect cellRect = CGRectZero;
    //        if ([Common isIpad]) {
    //            cellRect = CGRectMake(0, 0, 100, 100);
    //        }
    //        else {
    //            cellRect = CGRectMake(0, 0, 100, 100);
    //        }
    //        cell = [[UICollectionViewCell alloc] initWithFrame:cellRect];
    //        UIImageView *imgView = [[UIImageView alloc] initWithFrame:cellRect];
    //        imgView.tag = 10;
    //        [cell.contentView addSubview:imgView];
    //    }
    //    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:10];
    //    imgView.image = [UIImage imageNamed:@"1"];
    
    NSInteger imageIdx = [self.arrTemplates count] - indexPath.row;
   // NSLog(@"index : %ld",(long)imageIdx);
    
    //cell.backgroundView.backgroundColor = [UIColor redColor];
    
   // NSString *imagePath=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Templates/%ld@2x.png",(long)imageIdx]];
    
  //  UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Templates/%ld@2x.png",(long)imageIdx]];

    //UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)imageIdx]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:image];
    return cell;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"touched cell %@ at indexPath %@ - %ld - %ld", cell, indexPath, (long)indexPath.section, (long)indexPath.row);
    
    currentIndexPath = indexPath;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you would like to install this theme to the current folder?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Install", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self replaceFiles];
    }
}

- (void)replaceFiles {
    
    NSInteger folderindex = [self.arrTemplates count] - currentIndexPath.row;
    
    NSString *folderString = [NSString stringWithFormat:@"%ld", (long)folderindex];
    NSLog(@"folderString: %@", folderString);
    
    //NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
   // NSString * homeDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   // NSString * documentsDirectoryPath = [homeDir stringByAppendingPathComponent:@"Templates"];
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString * documentsDirectoryPath = [resourcePath stringByAppendingPathComponent:@"Templates"];
    
    NSString *folderPath = [documentsDirectoryPath stringByAppendingPathComponent:folderString];
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:folderPath error:&error];
    NSLog(@"error1: %@", error);
    
    NSLog(@"path_ %@", path_);
    
    for (NSString *filename in files) {
        NSString *newPath = [path_ stringByAppendingPathComponent:filename];
        NSString *oldPath = [folderPath stringByAppendingPathComponent:filename];
        if ([fileManager fileExistsAtPath:newPath]) {
            [fileManager removeItemAtPath:newPath error:nil];
        }
        [fileManager copyItemAtPath:oldPath toPath:newPath error:&error];
        NSLog(@"error2: %@", error);
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Installed template successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (CGRect) orientationChanged:(NSNotification *)note
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        //Do something in landscape
        
    }
    else {
        //Do something in portrait
       
        
    }
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation
                                            duration:duration];
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        _collectionView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }
    else {
        _collectionView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }
}

// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

@end
