//
//  VSLandingHeaderView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/9/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingHeaderView.h"
#import "VSSearchTextField.h"
#import "VSSubHeaderView.h"
#import "VSLandingTheme.h"

@interface VSLandingHeaderView ()
@property (nonatomic) UIImageView* imageViewBackground;
@property (nonatomic) VSSearchTextField* searchTextField;
@property (nonatomic) UIImageView* imageViewLogo;
@property (nonatomic) UIView* containerView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSLandingHeaderView

- (instancetype)initWithSearchPlaceHolderText:(NSString*)searchPlaceHolderText
										searchIconImage:(NSString*)searchIconImage
										rhsIconImage:(NSString*)rhsIconImage
										delegate:(id<VSLandingHeaderViewDelegate>)delegate {
	if (self = [super init]) {
		_searchPlaceHolderText = searchPlaceHolderText;
		_searchIconImage = searchIconImage;
		_rhsIconImage = rhsIconImage;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.imageViewBackground];
	
	[self.containerView addSubview:self.imageViewLogo];
	[self.containerView addSubview:self.searchTextField];
	
	[self addSubview:self.containerView];
}

#pragma mark - UI Elements
- (UIView*)containerView {
	if (!_containerView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.backgroundColor = [UIColor clearColor];
		_containerView = v;
	}
	return _containerView;
}

- (UIImageView*)imageViewLogo {
	if (!_imageViewLogo) {
		UIImage* img = [UIImage imageNamed:self.rhsIconImage];
		img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		UIImageView* btn = [[UIImageView alloc] initWithImage:img];
		btn.translatesAutoresizingMaskIntoConstraints = NO;
		btn.contentMode = UIViewContentModeScaleAspectFit;
		btn.tintColor = [UIColor whiteColor];
		btn.clipsToBounds = YES;
		
		_imageViewLogo = btn;
	}
	return _imageViewLogo;
}

- (UIImageView*)imageViewBackground {
	if (!_imageViewBackground) {
		UIImage* img = [UIImage imageNamed:@"landing-bg"];
		
		UIImageView* btn = [[UIImageView alloc] initWithImage:img];
		btn.translatesAutoresizingMaskIntoConstraints = NO;
		btn.contentMode = UIViewContentModeCenter;
		
		_imageViewBackground = btn;
	}
	return _imageViewBackground;
}

- (VSSearchTextField*)searchTextField {
	if (!_searchTextField) {
		VSSearchTextField* search = [[VSSearchTextField alloc] initSearchPlaceHolderText:self.searchPlaceHolderText
																						searchIconImage:self.searchIconImage];
		search.translatesAutoresizingMaskIntoConstraints = NO;
		search.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  What are you buying today?" attributes:@{NSForegroundColorAttributeName:[VSLandingTheme searchTextColor]}];
		_searchTextField = search;
	}
	return _searchTextField;
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
	UIView* parent = self.containerView;
	
		
	//image height
	NSLayoutConstraint* logoHeight = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:60];
	NSLayoutConstraint* logoWidth = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:60];
	[self.imageViewLogo addConstraints:@[logoHeight, logoWidth]];
	
	NSLayoutConstraint* leadingRhs = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:10];
	NSLayoutConstraint* trailingRhs = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.searchTextField attribute:NSLayoutAttributeLeading multiplier:1.f constant:-10];
	NSLayoutConstraint* topRhs = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:30];
	NSLayoutConstraint* bottomRhs = [NSLayoutConstraint constraintWithItem:self.imageViewLogo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-10];
	bottomRhs.priority = UILayoutPriorityDefaultLow;
	
	//background image
	NSLayoutConstraint* leadingImgBG = [NSLayoutConstraint constraintWithItem:self.imageViewBackground attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:-100];
	NSLayoutConstraint* trailingImgBG = [NSLayoutConstraint constraintWithItem:self.imageViewBackground attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];
	NSLayoutConstraint* topImgBG = [NSLayoutConstraint constraintWithItem:self.imageViewBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:-50];
	NSLayoutConstraint* bottomImgBG = [NSLayoutConstraint constraintWithItem:self.imageViewBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];

	[self addConstraints:@[leadingImgBG, trailingImgBG, topImgBG, bottomImgBG]];
	
				//height of search
	NSLayoutConstraint* searchTextFieldHeight = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	[self.searchTextField addConstraints:@[searchTextFieldHeight]];

	NSLayoutConstraint* leadingSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.imageViewLogo attribute:NSLayoutAttributeTrailing multiplier:1.f constant:10];
	NSLayoutConstraint* trailingSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-10];
	NSLayoutConstraint* centerXSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.imageViewLogo attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
	
	parent = self;
	NSLayoutConstraint* leadingContainer = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingContainer = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topContainer = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomContainer = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingContainer, trailingContainer, topContainer, bottomContainer]];
	
	
	[parent addConstraints:@[leadingSearch, trailingSearch, centerXSearch,
	                         leadingRhs, trailingRhs, topRhs, bottomRhs /*centerXRhs*/ ]];
	
}

@end
