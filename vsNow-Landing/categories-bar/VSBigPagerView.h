//
//  VSBigPagerView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 7/18/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSCollectionView.h"

@interface VSBigPagerView : UIView
@property (nonatomic) VSCollectionView* collectionView;
@property (nonatomic) UIPageControl* pageControl;

- (instancetype)initWithNumberOfPages:(NSInteger)numOfPages;
- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate
	indexpath:(NSIndexPath*)indexPath;
- (void)reset;
@end
