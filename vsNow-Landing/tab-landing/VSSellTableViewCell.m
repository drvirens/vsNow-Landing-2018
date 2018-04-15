//
//  VSSellTableViewCell.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSSellTableViewCell.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"

@interface VSSellTableViewCell ()
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSSellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:self.calloutView];
}

- (void)prepareForReuse {
	[super prepareForReuse];
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (VSProminentCalloutView*)calloutView {
	if (!_calloutView) {
		VSProminentCalloutView* callout = [[VSProminentCalloutView alloc] initWithFirstIcon:@"photo-camera" lastIcon:@"dot-matrix"];
		callout.translatesAutoresizingMaskIntoConstraints = NO;
		callout.backgroundColor = [UIColor whiteColor];
		_calloutView = callout;
	}
	return _calloutView;
}

- (void)reloadData {
  [self.calloutView setDelegate:self.collectionViewDelegate dataSource:self.collectionViewDataSrc calloutDelegate:self.calloutDelegate];
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
	
  NSLayoutConstraint* leadingCalloutView = [NSLayoutConstraint constraintWithItem:self.calloutView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingCalloutView = [NSLayoutConstraint constraintWithItem:self.calloutView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];
	NSLayoutConstraint* topCalloutView = [NSLayoutConstraint constraintWithItem:self.calloutView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:-0];
	NSLayoutConstraint* bottomCalloutView = [NSLayoutConstraint constraintWithItem:self.calloutView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
	
	[parent addConstraints:@[
				leadingCalloutView,
				trailingCalloutView,
				topCalloutView,
				bottomCalloutView
				]];
}

@end
