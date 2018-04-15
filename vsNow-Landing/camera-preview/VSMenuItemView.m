//
//  VSMenuItemView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSMenuItemView.h"
#import "VSUIUtils.h"
#import "VSLandingTheme.h"

@interface VSMenuItemView ()
@property (nonatomic) UIView* wrapperView;
@property (nonatomic) UIImageView* imageView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSMenuItemView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self.contentView addSubview:self.wrapperView];
	[self.wrapperView addSubview:self.imageView];
	self.layer.cornerRadius = kCornerRadius;
	self.backgroundColor = [UIColor blackColor];
}

- (void)prepareForReuse {
	self.imageView.image = nil;
}

- (void)configureWithImageUrl:(NSString*)imageUrl {
	UIImage* header = [UIImage imageNamed:imageUrl];
  header = [header imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.imageView.tintColor = [VSLandingTheme cameraOverlayColor];
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
		v.contentMode = UIViewContentModeCenter;
		_imageView = v;
	}
	return _imageView;
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
  
    	//lhs icon width and height
	NSLayoutConstraint* lhsIconHeight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	NSLayoutConstraint* lhsIconWidth = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	[self.imageView addConstraints:@[lhsIconHeight, lhsIconWidth]];
	
	NSLayoutConstraint* leadingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
	NSLayoutConstraint* trailingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingImageView, trailingImageView /*, topImageView, bottomImageView*/]];
	
}

@end
