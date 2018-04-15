//
//  VSLandingUIConstants.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingUIConstants.h"

const CGFloat kHeightOfTableViewHeader = 180.f;
static const CGFloat kCornerRadiusCategoryItemView = 3;
static const CGFloat kCornerWidthCategoryItemView = .5f;

@implementation VSLandingUIConstants

+ (CGFloat)scaledMargin:(CGFloat)num {
	return num;
}

+ (CGFloat)scale {
	static CGFloat ret = 0.f;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^() {
		ret = [[UIScreen mainScreen] scale];
	});
	
	return ret;
}

+ (CGFloat)cellHeight:(CGFloat)tabbarHeight navBarHeight:(CGFloat)navBarHeight {
	static CGFloat ret = 0.f;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^() {
		CGRect r = [UIScreen mainScreen].bounds;
		CGFloat h = r.size.height;
		CGFloat margin = [VSLandingUIConstants scaledMargin:20.f];
		CGFloat statusHt = [VSLandingUIConstants scaledMargin:20.f];
		CGFloat verticalDistanceBetweenTwoCells = [VSLandingUIConstants scaledMargin:40.f];
		h -= (tabbarHeight + navBarHeight + statusHt + margin*2 + verticalDistanceBetweenTwoCells);
		h += 20;
		h /= 2.f;
		ret = h;
	});
	
	return ret;
}

+ (CGFloat)categoryItemViewHeight:(CGFloat)tabbarHeight navBarHeight:(CGFloat)navBarHeight {
	CGFloat ret = [VSLandingUIConstants cellHeight:tabbarHeight navBarHeight:navBarHeight];
	CGFloat margin = [VSLandingUIConstants scaledMargin:20.f];
	ret -= (margin);
	return ret;
}

+ (CGFloat)cornerRadiusCategoryItemView {
	CGFloat r = kCornerRadiusCategoryItemView;
	CGFloat scale = [VSLandingUIConstants scale];
	CGFloat ret = r * scale;
	return ret;
}

+ (CGFloat)cornerWidthCategoryItemView {
	CGFloat r = kCornerWidthCategoryItemView;
	CGFloat scale = [VSLandingUIConstants scale];
	CGFloat ret = r * scale;
	return ret;
}

+ (CGFloat)cellHeight {
	CGFloat tabbarHt = 49.f;
	CGFloat navbarHt = 44.f;
	CGFloat h = [VSLandingUIConstants cellHeight:tabbarHt navBarHeight:navbarHt];
	return h;
}
+ (CGFloat)cellWidth {
	CGFloat h = [self cellHeight];
	CGFloat w = 0.5f * h;
	return w;
}
+ (CGFloat)cellWidthSmall {
	CGFloat h = [self cellHeight];
	CGFloat w = 0.41f * h;
	return w;
}
+ (CGFloat)cellWidth:(CGFloat)xPercentOf {
	CGFloat h = [self cellHeight];
	CGFloat w = xPercentOf * h;
	return w;
}

@end
