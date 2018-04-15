//
//  VSCategorytemView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSCategorytemView.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"
#import "VSUIUtils.h"

@interface VSCategorytemView ()

@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSCategorytemView

- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.layer.cornerRadius = [VSLandingUIConstants cornerRadiusCategoryItemView];
	self.layer.borderWidth = [VSLandingUIConstants cornerWidthCategoryItemView];
	self.layer.borderColor = [VSLandingTheme categoryItemViewBorderBorderColor].CGColor;
	
	[self addSubview:self.imageViewIcon];
	[self addSubview:self.labelCategoryName];
	[self addSubview:self.labelSeeAll];
	//[self addSubview:self.imageViewMoreIcon];
	self.backgroundColor = [VSLandingTheme categoryItemViewBackgroundColor];
	
  NSInteger cellheight = [VSLandingUIConstants cellHeight];
  NSInteger factor = .23f * cellheight;
  NSInteger shadowlen = cellheight - factor;
  
	CGRect r = CGRectMake(0, 0, [VSLandingUIConstants  cellWidth], shadowlen);
	UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:r];
	self.layer.masksToBounds = NO;
	self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
	self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
	self.layer.shadowOpacity = 0.5f;
	self.layer.shadowPath = shadowPath.CGPath;
}

- (VSLabel*)label {
	VSLabel* lbl = [[VSLabel alloc] init];
	lbl.translatesAutoresizingMaskIntoConstraints = NO;
	lbl.numberOfLines = 1;
	return lbl;
}

- (VSLabel*)labelCategoryName {
	if (!_labelCategoryName) {
		VSLabel* lbl = [self label];
		lbl.numberOfLines = 2;
		lbl.textColor = [VSLandingTheme categoryItemViewNameTextColor];
    lbl.font = FONT_SMALL;
		
		_labelCategoryName = lbl;
	}
	return _labelCategoryName;
}
- (VSLabel*)labelSeeAll {
	if (!_labelSeeAll) {
		VSLabel* lbl = [self label];
		lbl.textColor = [VSLandingTheme categoryItemViewPriceTextColor];
    lbl.font = FONT_REGULAR;
		
		_labelSeeAll = lbl;
	}
	return _labelSeeAll;
}
- (UIImageView*)imageView {
	UIImageView* v = [[UIImageView alloc] init];
	v.translatesAutoresizingMaskIntoConstraints = NO;
	v.tintColor = [VSUIUtils brandColor];
	v.contentMode = UIViewContentModeScaleAspectFit;
	v.clipsToBounds = YES;
	return v;
}
- (UIImageView*)imageViewIcon {
	if (!_imageViewIcon) {
		UIImageView* iv = [self imageView];
		_imageViewIcon = iv;
	}
	return _imageViewIcon;
}
- (UIImageView*)imageViewMoreIcon {
	if (!_imageViewMoreIcon) {
		UIImageView* iv = [self imageView];
		_imageViewMoreIcon = iv;
	}
	return _imageViewMoreIcon;
}
#pragma mark - layout constraints
+ (BOOL)requiresConstraintBasedLayout {
	return YES;
}

- (void)updateConstraints {
	if (!self.hasAppliedConstraints) {
		self.hasAppliedConstraints = YES;
		[self applyConstraints];
	}
	[super updateConstraints];
}

- (void)applyConstraints {
	UIView* parent = self;
	
		//lhs imageview icon
	NSLayoutConstraint* topIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:10];
	NSLayoutConstraint* bottomIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelCategoryName attribute:NSLayoutAttributeTop multiplier:1.f constant:-10];
	NSLayoutConstraint* centerXIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
	
	NSLayoutConstraint* aspectRatio = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.imageViewIcon attribute:NSLayoutAttributeHeight multiplier:1.f constant:0];
	
	[parent addConstraints:@[topIcon, bottomIcon, centerXIcon, aspectRatio]];
	
		//labelCategoryName
	NSLayoutConstraint* topCatName = [NSLayoutConstraint constraintWithItem:self.labelCategoryName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1.f constant:10];
	NSLayoutConstraint* bottomCatName = [NSLayoutConstraint constraintWithItem:self.labelCategoryName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelSeeAll attribute:NSLayoutAttributeTop multiplier:1.f constant:-10];
	NSLayoutConstraint* centerXCatName = [NSLayoutConstraint constraintWithItem:self.labelCategoryName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
	
	[parent addConstraints:@[topCatName, bottomCatName, centerXCatName]];


	//labelSeeAll
	NSLayoutConstraint* topSeeAll = [NSLayoutConstraint constraintWithItem:self.labelSeeAll attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelCategoryName attribute:NSLayoutAttributeBottom multiplier:1.f constant:10];
	NSLayoutConstraint* bottomSeeAll = [NSLayoutConstraint constraintWithItem:self.labelSeeAll attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-10];
	NSLayoutConstraint* centerXSeeAll = [NSLayoutConstraint constraintWithItem:self.labelSeeAll attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
	
	[parent addConstraints:@[topSeeAll, bottomSeeAll, centerXSeeAll]];


}

@end

