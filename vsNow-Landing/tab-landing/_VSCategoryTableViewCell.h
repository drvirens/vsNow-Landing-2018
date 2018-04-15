//
//  VSCategoryTableViewCell.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSCategoryView.h"

@interface VSCategoryTableViewCell : UITableViewCell

+ (NSString*)reusableID;
- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate indexpath:(NSIndexPath*)indexPath;
- (void)setCategoryIcon:(NSString*)categoryIcon
												categoryName:(NSString*)categoryName
												color:(UIColor*)color
												delegate:(id<VSCategoryViewDelegate>)delegate;
@end
