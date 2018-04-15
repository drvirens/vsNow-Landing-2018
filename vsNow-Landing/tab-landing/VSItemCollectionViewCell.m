//
//  VSItemCollectionViewCell.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSItemCollectionViewCell.h"
#import "VSCategorytemView.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"
#import "VSPresentableItemModel.h"

@interface VSItemCollectionViewCell ()
@property (nonatomic) VSCategorytemView* itemView;
@property(nonatomic, assign) BOOL hasAppliedConstraints;
@end

@implementation VSItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self resetUIElements];
}

- (void)commonInit {
	[self.contentView addSubview:self.itemView];
	[self resetUIElements];
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (void)resetUIElements {
	self.layer.cornerRadius = [VSLandingUIConstants cornerRadiusCategoryItemView];
	self.layer.borderWidth = [VSLandingUIConstants cornerWidthCategoryItemView];
	self.layer.borderColor = [VSLandingTheme categoryItemViewBorderBorderColor].CGColor;
	self.itemView.imageViewIcon.backgroundColor = [VSLandingTheme randomLightFlatColorForBackground];
}

#pragma mark - configure
- (void)configureWithModel:(VSPresentableItemModel*)model {
	CGSize sz = CGSizeMake(model.cellWidth, model.cellWidth);
	UIImage* i = [UIImage imageNamed:model.imageUrl];
	UIImage* img = [self imageWithImage:i scaledToSize:sz];
	
	self.itemView.imageViewIcon.image = img;
	self.itemView.labelCategoryName.text = model.name;
	self.itemView.labelSeeAll.text = model.price;
}

- (UIImage*)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize {
   UIGraphicsBeginImageContext( newSize );
   [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
   UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();

   return newImage;
}

#pragma mark - UI Elements
- (VSCategorytemView*)itemView {
	if (!_itemView) {
		VSCategorytemView* iv = [[VSCategorytemView alloc] init];
		iv.translatesAutoresizingMaskIntoConstraints = NO;
		
		_itemView = iv;
	}
	return _itemView;
}

#pragma mark - constraints
+ (BOOL) requiresConstraintBasedLayout {
	return YES;
}

- (void)updateConstraints {
	if (!self.hasAppliedConstraints) {
		[self applyConstraints];
	}
	[super updateConstraints];
}

- (void)applyConstraints {
	UIView* parent = self.contentView;
	NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self.itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
	NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:self.itemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
	NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:self.itemView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
	NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:self.itemView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
	[self.contentView addConstraints:@[top, bottom, left, right]];
}

@end

