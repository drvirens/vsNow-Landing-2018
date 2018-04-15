//
//  VSSubHeaderView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/10/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSSubHeaderView.h"

@interface VSSubHeaderView ()
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSSubHeaderView
- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.label];
}

- (VSLabel*)label {
	if (!_label) {
		VSLabel* lbl = [[VSLabel alloc] init];
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.textColor = [UIColor whiteColor];
		_label = lbl;
	}
	return _label;
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
	
	NSLayoutConstraint* leadingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:10];
	NSLayoutConstraint* trailingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-10];
	NSLayoutConstraint* topLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	topLabel.priority = UILayoutPriorityDefaultLow;
	NSLayoutConstraint* bottomLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-10];
	
	[parent addConstraints:@[leadingLabel, trailingLabel, /*topLabel,*/ bottomLabel]];
}

@end
