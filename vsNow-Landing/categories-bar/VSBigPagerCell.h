//
//  VSBigPagerCell.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 7/18/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSBigPagerView.h"

@interface VSBigPagerCell : UICollectionViewCell
@property (nonatomic) VSBigPagerView* regularItemView;
+ (NSString*)reuseID;
@end
