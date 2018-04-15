//
//  VSSmallItemCollectionViewCell.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSPresentableItemModel;

@interface VSSmallItemCollectionViewCell : UICollectionViewCell
+ (NSString*)reusableID;
- (void)configureWithModel:(VSPresentableItemModel*)model;
@end
