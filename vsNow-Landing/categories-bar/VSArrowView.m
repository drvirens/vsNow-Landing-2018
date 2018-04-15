//
//  VSArrowView.m
//  VSTopBarScrollView
//
//  Created by Nate on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSArrowView.h"
#import "VSLandingTheme.h"

@interface VSArrowView ()
@property (nonatomic) UIImageView* imageViewLine;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSArrowView

- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [VSLandingTheme veryLightGrayColor];
	[self addSubview:self.imageViewLine];
}

#pragma mark - UI Elements
- (UIImageView*)imageViewLine {
	if (!_imageViewLine) {
		UIImageView* v = [[UIImageView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.contentMode = UIViewContentModeTop;
		v.clipsToBounds = YES;
		UIImage* img = [UIImage imageNamed:@"ic_drag_line"];
		img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		v.tintColor = [UIColor lightGrayColor];
		v.image = img;
		
		_imageViewLine = v;
	}
	return _imageViewLine;
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
	
	    	//lhs icon width and height
	NSLayoutConstraint* lhsIconWidth = [NSLayoutConstraint constraintWithItem:self.imageViewLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	[self.imageViewLine addConstraints:@[
											lhsIconWidth
											]];
	
	NSLayoutConstraint* centerXLabel = [NSLayoutConstraint constraintWithItem:self.imageViewLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
	
	NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self.imageViewLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:self.imageViewLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[
				centerXLabel,
				top,
				bottom
				]];
}

@end
