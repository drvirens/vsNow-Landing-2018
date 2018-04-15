//
//  VSBrowseHeaderTableViewCell.m
//  vsNow-Landing
//
//  Created by Nate on 6/28/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSBrowseHeaderTableViewCell.h"
#import "VSLabel.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"

@interface VSBrowseHeaderTableViewCell ()
@property (nonatomic) VSLabel* label;
@property (nonatomic) VSLabel* sublabel;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSBrowseHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [UIColor greenColor];
	[self.contentView addSubview:self.label];
	[self.contentView addSubview:self.sublabel];
}

- (void)prepareForReuse {
	[super prepareForReuse];
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (VSLabel*)label {
	if (!_label) {
		VSLabel* lbl = [[VSLabel alloc] init];
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.textColor = [UIColor whiteColor];
    lbl.text = @"";
		lbl.numberOfLines = 1;
		lbl.font = FONT_X_LARGE;
		_label = lbl;
	}
	return _label;
}

- (VSLabel*)sublabel {
	if (!_sublabel) {
		VSLabel* lbl = [[VSLabel alloc] init];
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.textColor = [UIColor whiteColor];
		lbl.font = FONT_SMALL;
		lbl.numberOfLines = 2;
		_sublabel = lbl;
	}
	return _sublabel;
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
	
	NSLayoutConstraint* leadingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:10];
	NSLayoutConstraint* trailingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-10];
	NSLayoutConstraint* bottomLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.sublabel attribute:NSLayoutAttributeTop multiplier:1.f constant:-0];
	[parent addConstraints:@[
                        leadingLabel, 
                        trailingLabel,
                        bottomLabel]];
	
	NSLayoutConstraint* leadingSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:10];
	NSLayoutConstraint* trailingSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-10];
	NSLayoutConstraint* topSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	NSLayoutConstraint* bottomSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-10];
	
	[parent addConstraints:@[
				leadingSubLabel,
				trailingSubLabel,
				topSubLabel,
				bottomSubLabel
				]];
}

@end
