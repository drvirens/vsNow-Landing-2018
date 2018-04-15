//
//  VSCategoryTableViewCell.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSCategoryTableViewCell.h"

@interface VSCategoryTableViewCell ()
@property (nonatomic) VSCategoryView* categoryView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSCategoryTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self.contentView addSubview:self.categoryView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)prepareForReuse {
	[super prepareForReuse];
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate indexpath:(NSIndexPath*)indexPath {
	[self.categoryView setCollectionViewDataSrcAndDelegate:dataSrcAndDelegate indexpath:indexPath];
}

- (void)setCategoryIcon:(NSString*)categoryIcon
												categoryName:(NSString*)categoryName
												color:(UIColor*)color
												delegate:(id<VSCategoryViewDelegate>)delegate {
	[self.categoryView setCategoryIcon:categoryIcon categoryName:categoryName color:color delegate:delegate];
}

#pragma mark - UI Elements
- (VSCategoryView*)categoryView {
	if (!_categoryView) {
		VSCategoryView* catview = [[VSCategoryView alloc] init];
		catview.translatesAutoresizingMaskIntoConstraints = NO;
		_categoryView = catview;
	}
	return _categoryView;
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
	
	NSLayoutConstraint* leadingCollectionView = [NSLayoutConstraint constraintWithItem:self.categoryView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingCollectionView = [NSLayoutConstraint constraintWithItem:self.categoryView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topCollectionView = [NSLayoutConstraint constraintWithItem:self.categoryView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomCollectionView = [NSLayoutConstraint constraintWithItem:self.categoryView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingCollectionView, trailingCollectionView, topCollectionView, bottomCollectionView]];
}


@end
