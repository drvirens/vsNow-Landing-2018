//
//  VSBigPagerView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 7/18/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSBigPagerView.h"
#import "VSLandingTheme.h"
#import "VSUIUtils.h"
#import "VSLandingUIConstants.h"
#import "VSSmallItemCollectionViewCell.h"
#import "VSCollectionViewFlowLayout.h"

@interface VSBigPagerView ()
@property (nonatomic) NSInteger numOfPages;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSBigPagerView
- (instancetype)initWithNumberOfPages:(NSInteger)numOfPages {
	if (self = [super init]) {
		_numOfPages = numOfPages;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
  self.backgroundColor = [VSLandingTheme flatBlueColor];
	[self addSubview:self.collectionView];
	[self addSubview:self.pageControl];
}

- (void)reset {
}

- (void)setCollectionViewDataSrcAndDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)dataSrcAndDelegate
	indexpath:(NSIndexPath*)indexPath {
	self.collectionView.dataSource = dataSrcAndDelegate;
	self.collectionView.delegate = dataSrcAndDelegate;
	self.collectionView.indexpath = indexPath;
	
	[self.collectionView reloadData];
}

- (void)didChangePage:(id)sender {
//	UIPageControl* pc = (UIPageControl*)sender;
}

#pragma mark - UI Elements
- (UIPageControl*)pageControl {
	if (!_pageControl) {
		UIPageControl* pc = [[UIPageControl alloc] init];
		pc.translatesAutoresizingMaskIntoConstraints = NO;
		pc.numberOfPages = self.numOfPages;
		pc.pageIndicatorTintColor = [VSLandingTheme pageIndicatorTintColorFlatBlue];
		pc.currentPageIndicatorTintColor = [VSLandingTheme currentPageIndicatorTintColorFlatBlue];
		
		[pc addTarget:self action:@selector(didChangePage:) forControlEvents:UIControlEventValueChanged];
		_pageControl = pc;
	}
	return _pageControl;
}

- (VSCollectionView*)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
		flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
		flowlayout.minimumLineSpacing = 0;
		flowlayout.minimumInteritemSpacing = 0;
		flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		
		VSCollectionView* collview = [[VSCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
		collview.translatesAutoresizingMaskIntoConstraints = NO;
		collview.showsHorizontalScrollIndicator = NO;
		collview.pagingEnabled = YES;
		collview.showsHorizontalScrollIndicator = NO;
		
		[collview registerClass:[VSSmallItemCollectionViewCell class] forCellWithReuseIdentifier:[VSSmallItemCollectionViewCell reusableID]];
		collview.backgroundColor = [VSLandingTheme flatBlueColor];
		
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
	NSLayoutConstraint* bottomCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.pageControl attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingCollectionView, trailingCollectionView, topCollectionView,bottomCollectionView
	]];
	
		//page control
	NSLayoutConstraint* leadingpageControl = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:40];
	NSLayoutConstraint* toppageControl = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
	NSLayoutConstraint* bottompageControl = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-10];
	
	[parent addConstraints:@[leadingpageControl, toppageControl, bottompageControl]];

}

@end
