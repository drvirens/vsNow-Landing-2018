//
//  VSCategoryWrapperView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/30/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSCategoryWrapperView : UIView
- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate indexpath:(NSIndexPath*)indexPath;
@end
