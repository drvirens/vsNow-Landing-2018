//
//  VSCategoryView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSCategoryView;

@protocol VSCategoryViewDelegate <NSObject>
- (void)didTapOnCategory:(VSCategoryView*)categoryView;
@end

@interface VSCategoryView : UIView

@property (nonatomic, weak) id<VSCategoryViewDelegate> delegate;

- (void)setCategoryIcon:(NSString*)categoryIcon
												categoryName:(NSString*)categoryName
												color:(UIColor*)color
												delegate:(id<VSCategoryViewDelegate>)delegate;

- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate indexpath:(NSIndexPath*)indexPath;
@end
