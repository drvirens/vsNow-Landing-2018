//
//  VSSmallCategorytemView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSSmallCategorytemView.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"
#import "VSUIUtils.h"

@interface VSSmallCategorytemView ()

@property (nonatomic) BOOL hasAppliedConstraints;

@end

@implementation VSSmallCategorytemView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.layer.cornerRadius = [VSLandingUIConstants cornerRadiusCategoryItemView];
	self.layer.borderWidth = [VSLandingUIConstants cornerWidthCategoryItemView];
	self.layer.borderColor = [VSLandingTheme categoryItemViewBorderBorderColor].CGColor;
	
	[self addSubview:self.imageViewIcon];
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
		lbl.numberOfLines = 1;
		lbl.textColor = [VSLandingTheme categoryItemViewNameTextColor];
    lbl.font = FONT_SMALL;
		lbl.text = @"labelCategoryName";
		
		_labelCategoryName = lbl;
	}
	return _labelCategoryName;
}
- (VSLabel*)labelSeeAll {
	if (!_labelSeeAll) {
		VSLabel* lbl = [self label];
		lbl.textColor = [VSLandingTheme categoryItemViewPriceTextColor];
    lbl.font = FONT_REGULAR;
		lbl.text = @"labelSeeAll";
		
		_labelSeeAll = lbl;
	}
	return _labelSeeAll;
}
- (UIImageView*)imageView {
	UIImageView* v = [[UIImageView alloc] init];
	v.translatesAutoresizingMaskIntoConstraints = NO;
	v.contentMode = UIViewContentModeRight;
	v.clipsToBounds = YES;
	
	return v;
}
- (UIImageView*)imageViewIcon {
	if (!_imageViewIcon) {
		UIImageView* iv = [self imageView];
		UIImage* img = [UIImage imageNamed:@"sku_362719_1_small"]; // XXX
		iv.image = img;
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
	NSLayoutConstraint* topIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
	NSLayoutConstraint* leftIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* rightIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];
	
	[parent addConstraints:@[topIcon, bottomIcon, leftIcon, rightIcon]];
}

@end

