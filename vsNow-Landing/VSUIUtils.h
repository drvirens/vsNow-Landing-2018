//
//  VSUIUtils.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>


FOUNDATION_EXPORT const CGFloat kHeightTopScrollView;
FOUNDATION_EXPORT const CGFloat kWidthArrowView;
FOUNDATION_EXPORT const CGFloat kHeightArrowView;
FOUNDATION_EXPORT const CGFloat kTopScrollViewMargin;
FOUNDATION_EXPORT const CGFloat kBottomArrowViewMargin;

@interface VSUIUtils : NSObject
+ (CGFloat)menuWidth;
+ (CGFloat)itemMenuWidth;
+ (UIColor*)brandColor;
+ (CGFloat)heightOfContentScrollVIew:(CGFloat)h;
@end
