//
//  VSRegularItemView.m
//  vsNow-Landing
//
//  Created by Nate on 7/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSRegularItemView.h"
#import "VSLabel.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"
#import "VSUIUtils.h"

@interface VSRegularItemView ()

@property (nonatomic) UIImageView* imageViewIcon;
@property (nonatomic) VSLabel* labelItemPrice;
@property (nonatomic) VSLabel* labelDiscount;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSRegularItemView
- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.imageViewIcon];
	[self addSubview:self.labelItemPrice];
	[self addSubview:self.labelDiscount];
	
	self.backgroundColor = [VSLandingTheme categoryItemViewBackgroundColor];
}

- (void)reset {
}
- (void)configureWithModel:(VSItemModel*)model {
  NSMutableAttributedString* mutableAttributedText = [[NSMutableAttributedString alloc] init];
	UIFont* font = nil;
	NSDictionary* dick = nil;
	if (model.hasWasPrice) {
		font = FONT_X_SMALL;
		NSDictionary* dick = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
													 NSFontAttributeName:font,
													 NSStrikethroughColorAttributeName:[UIColor lightGrayColor],
													 NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle]
													 };
		NSString* space = @" ";
		NSAttributedString* spaceAttribute = [[NSAttributedString alloc] initWithString:space];
		NSAttributedString* itemPrice = [[NSAttributedString alloc] initWithString:model.itemWasPrice attributes:dick];
		[mutableAttributedText appendAttributedString:itemPrice];
		[mutableAttributedText appendAttributedString:spaceAttribute];
	}

	font = FONT_SMALL;
	dick = @{NSForegroundColorAttributeName:[UIColor darkGrayColor],
												 NSFontAttributeName:font};
	NSAttributedString* itemPrice = [[NSAttributedString alloc] initWithString:model.itemPrice attributes:dick];
	[mutableAttributedText appendAttributedString:itemPrice];
	
  self.labelItemPrice.attributedText = mutableAttributedText;
  self.imageViewIcon.image = [UIImage imageNamed:model.imageUrl];
	if (model.isNewItem) {
		NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:model.itemWasPrice];
		self.labelDiscount.attributedText = attributedText;
	}
}

#pragma mark - UI Elements
- (VSLabel*)label {
	VSLabel* lbl = [[VSLabel alloc] init];
	lbl.translatesAutoresizingMaskIntoConstraints = NO;
	lbl.numberOfLines = 1;
	return lbl;
}

- (VSLabel*)labelItemPrice {
	if (!_labelItemPrice) {
		VSLabel* lbl = [self label];
		lbl.numberOfLines = 1;
		lbl.backgroundColor = [UIColor clearColor];
		lbl.textAlignment = NSTextAlignmentCenter;
    
		_labelItemPrice = lbl;
	}
	return _labelItemPrice;
}

- (VSLabel*)labelDiscount {
	if (!_labelDiscount) {
		VSLabel* lbl = [self label];
		lbl.textColor = [UIColor whiteColor];
		lbl.numberOfLines = 1;
		lbl.font = FONT_X_SMALL;
		lbl.backgroundColor = [VSLandingTheme yellowCaliforniaColor];
		lbl.textAlignment = NSTextAlignmentCenter;
		
		_labelDiscount = lbl;
	}
	return _labelDiscount;
}


- (UIImageView*)imageView {
	UIImageView* v = [[UIImageView alloc] init];
	v.translatesAutoresizingMaskIntoConstraints = NO;
	v.contentMode = UIViewContentModeScaleToFill;
	v.clipsToBounds = YES;
	return v;
}

- (UIImageView*)imageViewIcon {
	if (!_imageViewIcon) {
		UIImageView* iv = [self imageView];
		iv.backgroundColor = [VSLandingTheme veryLightGrayColor];
		_imageViewIcon = iv;
	}
	return _imageViewIcon;
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
	
		//lhs imageview icon
  NSLayoutConstraint* leftIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:2];
	NSLayoutConstraint* rightIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-2];
	NSLayoutConstraint* topIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:2];
	NSLayoutConstraint* bottomIcon = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelItemPrice attribute:NSLayoutAttributeTop multiplier:1.f constant:2];
	NSLayoutConstraint* aspectRatio = [NSLayoutConstraint constraintWithItem:self.imageViewIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.imageViewIcon attribute:NSLayoutAttributeHeight multiplier:1.f constant:0];

	[parent addConstraints:@[topIcon, bottomIcon, leftIcon, rightIcon , aspectRatio]];
	
		//labelItemPrice
	NSLayoutConstraint* topItemPrice = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1.f constant:-2];
	NSLayoutConstraint* trailingItemPrice = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelDiscount attribute:NSLayoutAttributeTop multiplier:1.f constant:-0];
  NSLayoutConstraint* leftItemPrice = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* rightItemPrice = [NSLayoutConstraint constraintWithItem:self.labelItemPrice attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];

	[parent addConstraints:@[topItemPrice, trailingItemPrice, leftItemPrice, rightItemPrice]];
	
	NSLayoutConstraint* topDiscount = [NSLayoutConstraint constraintWithItem:self.labelDiscount attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelItemPrice attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	NSLayoutConstraint* trailingDiscount = [NSLayoutConstraint constraintWithItem:self.labelDiscount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
  NSLayoutConstraint* leftDiscount = [NSLayoutConstraint constraintWithItem:self.labelDiscount attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* rightDiscount = [NSLayoutConstraint constraintWithItem:self.labelDiscount attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];

	[parent addConstraints:@[topDiscount, trailingDiscount, leftDiscount, rightDiscount]];
}

@end
