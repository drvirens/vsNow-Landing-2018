//
//  VSLandingSimpleHeaderView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/9/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingSimpleHeaderView.h"
#import "VSBurgerButton.h"
#import "VSSearchTextField.h"
#import "VSSubHeaderView.h"

@interface VSLandingSimpleHeaderView ()
@property (nonatomic) VSSubHeaderView* mainHeaderView;
@property (nonatomic) VSSubHeaderView* subHeaderView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSLandingSimpleHeaderView

- (instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle {
	if (self = [super init]) {
		_title = title;
		_subtitle = subtitle;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.mainHeaderView];
	//[self addSubview:self.subHeaderView];
	self.mainHeaderView.label.text = self.title;
	self.subHeaderView.label.text = self.subtitle;
}

#pragma mark - UI Elements

- (VSSubHeaderView*)subHeaderView {
	if (!_subHeaderView) {
		VSSubHeaderView* subheader = [[VSSubHeaderView alloc] init];
		subheader.translatesAutoresizingMaskIntoConstraints = NO;
		_subHeaderView = subheader;
	}
	return _subHeaderView;
}

- (VSSubHeaderView*)mainHeaderView {
	if (!_mainHeaderView) {
		VSSubHeaderView* mainheader = [[VSSubHeaderView alloc] init];
		mainheader.translatesAutoresizingMaskIntoConstraints = NO;
		_mainHeaderView = mainheader;
	}
	return _mainHeaderView;
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
//	
//	NSLayoutConstraint* leadingSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:10];
//	NSLayoutConstraint* trailingSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.btnRHSFilter attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
//	NSLayoutConstraint* centerXSearch = [NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
//	
//	NSLayoutConstraint* leadingRhs = [NSLayoutConstraint constraintWithItem:self.btnRHSFilter attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.searchTextField attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
//	NSLayoutConstraint* trailingRhs = [NSLayoutConstraint constraintWithItem:self.btnRHSFilter attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
////	NSLayoutConstraint* centerXRhs = [NSLayoutConstraint constraintWithItem:self.btnRHSFilter attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
//	NSLayoutConstraint* topRhs = [NSLayoutConstraint constraintWithItem:self.btnRHSFilter attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
//	NSLayoutConstraint* bottomRhs = [NSLayoutConstraint constraintWithItem:self.btnRHSFilter attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
//	
//	[parent addConstraints:@[leadingSearch, trailingSearch, centerXSearch,
//	                         leadingRhs, trailingRhs, topRhs, bottomRhs /*centerXRhs*/ ]];
//	
	parent = self;
	NSLayoutConstraint* leadingContainer = [NSLayoutConstraint constraintWithItem:self.mainHeaderView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingContainer = [NSLayoutConstraint constraintWithItem:self.mainHeaderView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topContainer = [NSLayoutConstraint constraintWithItem:self.mainHeaderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:30];
	NSLayoutConstraint* bottomContainer = [NSLayoutConstraint constraintWithItem:self.mainHeaderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingContainer, trailingContainer, topContainer, bottomContainer]];
	
	
//			//height of subheqader
//	NSLayoutConstraint* subHeaderHeight = [NSLayoutConstraint constraintWithItem:self.subHeaderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
//	[self.subHeaderView addConstraints:@[subHeaderHeight]];
//	
//	NSLayoutConstraint* leadingSubHeader = [NSLayoutConstraint constraintWithItem:self.subHeaderView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
//	NSLayoutConstraint* trailingSubHeader = [NSLayoutConstraint constraintWithItem:self.subHeaderView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
//	NSLayoutConstraint* topSubHeader = [NSLayoutConstraint constraintWithItem:self.subHeaderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainHeaderView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
//	NSLayoutConstraint* bottomSubHeader = [NSLayoutConstraint constraintWithItem:self.subHeaderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
//	
//	[parent addConstraints:@[leadingSubHeader, trailingSubHeader, topSubHeader, bottomSubHeader]];
}

@end
