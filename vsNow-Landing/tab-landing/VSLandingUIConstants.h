//
//  VSLandingUIConstants.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const CGFloat kHeightOfTableViewHeader;

@interface VSLandingUIConstants : NSObject

+ (CGFloat)cellHeight:(CGFloat)tabbarHeight navBarHeight:(CGFloat)navBarHeight;
+ (CGFloat)categoryItemViewHeight:(CGFloat)tabbarHeight navBarHeight:(CGFloat)navBarHeight;

+ (CGFloat)cornerRadiusCategoryItemView;
+ (CGFloat)cornerWidthCategoryItemView;

+ (CGFloat)cellHeight;
+ (CGFloat)cellWidth;
+ (CGFloat)cellWidthSmall;

@end
