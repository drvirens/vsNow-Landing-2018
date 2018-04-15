//
//  VSCategoriesTableViewCell.m
//  vsNow-Landing
//
//  Created by Nate on 6/28/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSCategoriesTableViewCell.h"
#import "VSScrollableMenuView.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"

@interface VSCategoriesTableViewCell ()
@property (nonatomic) VSScrollableMenuView* sublabel;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSCategoriesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:self.sublabel];
}

- (void)setScrollableMenuViewDelegateAndDataSource:(id<VSScrollableMenuViewDelegate, VSScrollableMenuViewDataSource>)delegateAndDataSource {
	[self.sublabel setScrollableMenuViewDelegateAndDataSource:delegateAndDataSource];
}

- (void)prepareForReuse {
	[super prepareForReuse];
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (VSScrollableMenuView*)sublabel {
	if (!_sublabel) {
		CGFloat h = [UIScreen mainScreen].bounds.size.height;
		VSScrollableMenuView* menuView = [[VSScrollableMenuView alloc] initWithDelegate:nil dataSource:nil pagingEnabled:YES height:h
    defaultPageIndex:0];
		menuView.translatesAutoresizingMaskIntoConstraints = NO;
		_sublabel = menuView;
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
	
	NSLayoutConstraint* leadingSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];
	NSLayoutConstraint* topSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomSubLabel = [NSLayoutConstraint constraintWithItem:self.sublabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
	
	[parent addConstraints:@[
				leadingSubLabel,
				trailingSubLabel,
				topSubLabel,
				bottomSubLabel
				]];
}

@end
