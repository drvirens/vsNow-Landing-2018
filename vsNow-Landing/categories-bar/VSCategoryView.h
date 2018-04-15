//
//  VSCategoryView.h
//  VSTopBarScrollView
//
//  Created by Nate on 7/8/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSCategoryView : UIView
@property (nonatomic) UICollectionView* collectionView;
- (instancetype)initWithDelegate:(id <UICollectionViewDelegate>)delegate
                      dataSource:(id <UICollectionViewDataSource>)dataSource
                      height:(CGFloat)height;
- (void)reload;
@end
