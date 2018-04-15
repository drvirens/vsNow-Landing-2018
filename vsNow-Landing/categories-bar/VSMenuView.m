//
//  VSMenuView.m
//  VSTopBarLabel
//
//  Created by Virendra Shakya on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSMenuView.h"
#import "VSUIUtils.h"
#import "VSLandingTheme.h"

static const CGFloat kMargin = 15.f;

@interface VSMenuView () 
@property (nonatomic) UILabel* label;
@property (nonatomic, copy) NSString* text;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSMenuView

- (instancetype)initWithText:(NSString*)text {
	if (self = [super init]) {
		_text = text;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.label];
}

- (CGFloat)width {
  CGFloat w = (2 * kMargin);
  CGFloat labelWidth = 0.f;
  labelWidth = self.label.intrinsicContentSize.width;
  w += labelWidth;
  return w;
}

- (void)updatUI:(CGFloat)alpha {
	if (alpha == 1.f) {
		self.backgroundColor = [UIColor clearColor];
		self.label.textColor = [VSLandingTheme redColorInnerColor];
	} else {
		self.backgroundColor = [UIColor clearColor];
		self.label.textColor = [UIColor darkGrayColor]; //[VSLandingTheme menuTextColor];
	}
}

#pragma mark - UI Elements
- (UILabel*)label {
  if (!_label) {
    UILabel* p = [[UILabel alloc] init];
		p.translatesAutoresizingMaskIntoConstraints = NO;
		p.textColor = [VSLandingTheme menuTextColor];
		p.numberOfLines = 1;
		p.textAlignment = NSTextAlignmentCenter;
		p.text = self.text;
		p.font = FONT_LARGE;
		
    _label = p;
  }
  return _label;
}

#pragma mark- constraints
- (void)updateConstraints {
	if (!self.hasAppliedConstraints) {
		[self applyConstraints];
		self.hasAppliedConstraints = YES;
	}
	[super updateConstraints];
}

- (void)applyConstraints {
	UIView* parent = self;
	
	NSLayoutConstraint* centerYLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
	NSLayoutConstraint* leftLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:kMargin];
	NSLayoutConstraint* rightLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-kMargin];
	
	[parent addConstraints:@[centerYLabel, leftLabel, rightLabel]];
}
@end
