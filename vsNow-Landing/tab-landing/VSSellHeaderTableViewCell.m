//
//  VSSellHeaderTableViewCell.m
//  vsNow-Landing
//
//  Created by Nate on 6/28/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSSellHeaderTableViewCell.h"
#import "VSLabel.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"

@interface VSSellHeaderTableViewCell ()
@property (nonatomic) VSLabel* label;
@property (nonatomic) UIView* wrapperView;
@property (nonatomic) UIImageView* imageViewRhs;

@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSSellHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [VSLandingTheme sellCellBgColor];
	[self.contentView addSubview:self.label];
	[self.contentView addSubview:self.wrapperView];
	[self.contentView addSubview:self.imageViewRhs];
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
		lbl.textColor = [UIColor lightGrayColor];
		lbl.text = @"Just added";
		lbl.numberOfLines = 1;
		lbl.textAlignment = NSTextAlignmentLeft;
		lbl.font = FONT_LARGE;
		_label = lbl;
	}
	return _label;
}

- (UIView*)wrapperView {
	if (!_wrapperView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.backgroundColor = [VSLandingTheme redColorInnerColor];
		v.hidden = YES;
		_wrapperView = v;
	}
	return _wrapperView;
}

- (UIImageView*)imageViewRhs {
	if (!_imageViewRhs) {
		UIImageView* v = [[UIImageView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.clipsToBounds = YES;
		v.contentMode = UIViewContentModeScaleAspectFit;
		
		UIImage* img = [UIImage imageNamed:@"ic_keyboard_arrow_right_white_18pt"];
		img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		v.image = img;
		
		v.tintColor = [UIColor lightGrayColor];
		
		_imageViewRhs = v;
	}
	return _imageViewRhs;
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
	CGFloat margin = 10;
	
	    	//lhs icon width and height
	NSLayoutConstraint* lhsIconWidth = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:8];
	[self.wrapperView addConstraints:@[ /*lhsIconHeight,*/ lhsIconWidth]];

	
	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:2];
	NSLayoutConstraint* trailingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeLeading multiplier:1.f constant:-margin];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:margin];
	NSLayoutConstraint* bottomWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-margin];
	
	[parent addConstraints:@[leadingWrapperView, trailingWrapperView,
	topWrapperView, bottomWrapperView,
	]];

	
	NSLayoutConstraint* leadingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.wrapperView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.imageViewRhs attribute:NSLayoutAttributeLeading multiplier:1.f constant:-margin];
	NSLayoutConstraint* centerYLabel = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.wrapperView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
	[parent addConstraints:@[
                        leadingLabel, 
                        trailingLabel, 
												centerYLabel]];
	
	
			//lhs icon width and height
	NSLayoutConstraint* rhsIconHeight = [NSLayoutConstraint constraintWithItem:self.imageViewRhs attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:22];
	NSLayoutConstraint* rhsIconWidth = [NSLayoutConstraint constraintWithItem:self.imageViewRhs attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:22];
	[self.imageViewRhs addConstraints:@[rhsIconHeight, rhsIconWidth]];

	NSLayoutConstraint* leadingImageView = [NSLayoutConstraint constraintWithItem:self.imageViewRhs attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTrailing multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingImageView = [NSLayoutConstraint constraintWithItem:self.imageViewRhs attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-margin];
	NSLayoutConstraint* centerYImageView = [NSLayoutConstraint constraintWithItem:self.imageViewRhs attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.wrapperView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
	
	[parent addConstraints:@[leadingImageView, trailingImageView, centerYImageView /*, bottomImageView*/ ]];
}

@end
