//
//  VSCategoryWrapperView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/30/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSCategoryWrapperView.h"
#import "VSLandingUIConstants.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"
#import "VSCollectionView.h"
#import "VSSmallItemCollectionViewCell.h"
#import "VSResourceNames.h"


@interface VSCategoryWrapperView ()
@property (nonatomic) VSCollectionView* collectionView;
@property (nonatomic) BOOL hasAppliedConstraints;
@property (nonatomic) BOOL showGradientBackground;
@end

@implementation VSCategoryWrapperView

- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
  self.backgroundColor = [UIColor whiteColor];
	self.showGradientBackground = NO;
  
	[self addSubview:self.collectionView];
}

- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate indexpath:(NSIndexPath*)indexPath {
	self.collectionView.dataSource = dataSrcAndDelegate;
	self.collectionView.delegate = dataSrcAndDelegate;
	self.collectionView.indexpath = indexPath;
	
	[self.collectionView reloadData];
}

- (VSCollectionView*)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
		flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
		
		CGFloat h = [VSLandingUIConstants cellHeight];
		CGFloat w = [VSLandingUIConstants cellWidthSmall];
		CGFloat topheight = .22f * h;
		h -= topheight;
		
		flowlayout.itemSize = CGSizeMake(w, h);
		flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		
		VSCollectionView* collview = [[VSCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
		collview.translatesAutoresizingMaskIntoConstraints = NO;
		collview.showsHorizontalScrollIndicator = NO;
		[collview registerClass:[VSSmallItemCollectionViewCell class] forCellWithReuseIdentifier:[VSSmallItemCollectionViewCell reusableID]];
		collview.backgroundColor = [VSLandingTheme collectionViewBackground];
    
		_collectionView = collview;
	}
	return _collectionView;
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
	
	//collectionview
	NSLayoutConstraint* leadingCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingCollectionView, trailingCollectionView, topCollectionView, bottomCollectionView]];
}


@end
