//
//  VSMenuItemPhotoView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSItemModel.h"

@interface VSMenuItemPhotoView : UICollectionViewCell
- (void)configureWithModel:(VSItemModel*)model;
+ (NSString*)reusableID;
@end
