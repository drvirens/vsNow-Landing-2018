//
//  VSDataCellCollectionViewCell.h
//  VSTopBarScrollView
//
//  Created by Nate on 7/8/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSItemModel.h"

@interface VSDataCell : UICollectionViewCell
+ (NSString*)reuseID;
- (void)configureWithModel:(VSItemModel*)model;
@end
