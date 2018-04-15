//
//  VSItemsViewController.m
//  VSTopBarScrollView
//
//  Created by Nate on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSItemsViewController.h"
#import "VSDataCell.h"


@interface VSItemsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonnull, nonatomic) UICollectionView* collectionView;
@end

@implementation VSItemsViewController
+ (UIViewController*)viewController {
  VSItemsViewController* vc = [[VSItemsViewController alloc] init];
  return vc;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self addCollectionView];
}

- (void)addCollectionView {
  [self.view addSubview:self.collectionView];
}

- (UICollectionView*)collectionView {
  if (!_collectionView) {
    UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = width/3;
    CGFloat h = w + (w/4);
    flowlayout.itemSize = CGSizeMake(w, h);
    
    CGRect rect = CGRectMake(0, 0, width, height - 60 - 44);
    UICollectionView* cv = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowlayout];
    cv.backgroundColor = [UIColor redColor];
    cv.delegate = self;
    cv.dataSource = self;
    cv.translatesAutoresizingMaskIntoConstraints = NO;
    [cv registerClass:[VSDataCell class] forCellWithReuseIdentifier:[VSDataCell reuseID]];
    
    _collectionView = cv;
  }
  return _collectionView;
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UICVD & data src
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 21;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
  VSDataCell* cell = (VSDataCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[VSDataCell reuseID] forIndexPath:indexPath];
	// XXX
  VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"test-guy2.jpg" 
            itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
  [cell configureWithModel:model];
  return cell;
}

@end
