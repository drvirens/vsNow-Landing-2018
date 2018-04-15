//
//  VSMenuItemPhotoView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSMenuItemPhotoView.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"
#import "VSLabel.h"

@interface VSMenuItemPhotoView ()
@property (nonatomic) UIView* wrapperView;
@property (nonatomic) UIImageView* imageView;
@property (nonatomic) VSLabel* labelItemPrice;
@property (nonatomic) BOOL hasAppliedConstraints;
@end
 
@implementation VSMenuItemPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self.contentView addSubview:self.wrapperView];
	[self.wrapperView addSubview:self.imageView];
	[self.wrapperView addSubview:self.labelItemPrice];
	self.layer.cornerRadius = kCornerRadius;
	self.backgroundColor = [VSLandingTheme categoryItemViewBackgroundColor];
}

- (void)prepareForReuse {
	self.imageView.image = nil;
	self.hasAppliedConstraints = NO;
}

- (void)configureWithModel:(VSItemModel*)model {
  NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:model.itemPrice];
  self.labelItemPrice.attributedText = attributedText;
  self.imageView.image = [UIImage imageNamed:model.imageUrl];
}
- (void)configureWithImageUrl:(NSString*)imageUrl {
	UIImage* header = [UIImage imageNamed:imageUrl];
	self.imageView.image = header;
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

#pragma mark - UI Elements
- (UIView*)wrapperView {
	if (!_wrapperView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		_wrapperView = v;
	}
	return _wrapperView;
}

- (UIImageView*)imageView {
	if (!_imageView) {
		UIImageView* v = [[UIImageView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.clipsToBounds = YES;
		v.layer.cornerRadius = kCornerRadius;
		v.contentMode = UIViewContentModeScaleToFill;
		_imageView = v;
	}
	return _imageView;
}

- (VSLabel*)labelItemPrice {
	if (!_labelItemPrice) {
		VSLabel* lbl = [[VSLabel alloc] init];
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.textColor = [UIColor whiteColor];
		lbl.numberOfLines = 1;
		lbl.font = FONT_X_SMALL;
		lbl.layer.cornerRadius = 4.f;
		lbl.layer.masksToBounds = YES;
		lbl.backgroundColor = [VSLandingTheme darkGreenColor];
		lbl.textAlignment = NSTextAlignmentCenter;
		_labelItemPrice = lbl;
	}
	return _labelItemPrice;
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
	UIView* parent = self.contentView;
	
	//image view
	CGFloat margin = 0;
	
	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-margin];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:margin];
	NSLayoutConstraint* bottomWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-margin];
	
	[parent addConstraints:@[leadingWrapperView, trailingWrapperView, topWrapperView, bottomWrapperView]];
	
	
	parent = self.wrapperView;
	
	margin = 0;
	
	NSLayoutConstraint* leadingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-margin];
	NSLayoutConstraint* topImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:margin];
	NSLayoutConstraint* bottomImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-margin];
	
	[parent addConstraints:@[leadingImageView, trailingImageView, topImageView, bottomImageView]];
	
	NSLayoutConstraint* topSelectImageView = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingSelectImageView = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-margin];

	[parent addConstraints:@[topSelectImageView, trailingSelectImageView]];
}

@end
