//
//  VSUIUtils.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSUIUtils.h"

static const CGFloat kTotalMenus = 4;
static const CGFloat kTotalInOneRowMenus = 3;

const CGFloat kHeightTopScrollView = 50.f;
const CGFloat kWidthArrowView = 10.f;
const CGFloat kHeightArrowView = 10.f;
const CGFloat kTopScrollViewMargin = 0.f;
const CGFloat kBottomArrowViewMargin = 2.f;

@implementation VSUIUtils
+ (CGFloat)menuWidth {
	static CGFloat w = 0.f;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		CGRect r = [[UIScreen mainScreen] bounds];
		w = r.size.width / kTotalMenus;
	});
	return w;
}
+ (CGFloat)itemMenuWidth {
	static CGFloat w = 0.f;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		CGRect r = [[UIScreen mainScreen] bounds];
		w = r.size.width / kTotalInOneRowMenus;
	});
	return w;
}
+ (CGFloat)heightOfContentScrollVIew:(CGFloat)h {
  CGFloat heightBottomScrollView = h - kHeightTopScrollView - kWidthArrowView - (3*kTopScrollViewMargin);
  return heightBottomScrollView;
}
+ (UIColor*)brandColor {
	return [UIColor colorWithRed:41.f/255.f green:150.f/255.f blue:204.f/255.f alpha:1.f];
}

@end
