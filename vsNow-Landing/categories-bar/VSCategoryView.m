//
//  VSCategoryView.m
//  VSTopBarCollectionView
//
//  Created by Nate on 7/8/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSCategoryView.h"
#import "VSUIUtils.h"
#import "VSDataCell.h"
#import "VSCollectionViewFlowLayout.h"
#import "VSBigPagerCell.h"

@interface VSCategoryView ()
@property (nonatomic) UIView* wrapperView;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;
@property (nonatomic) BOOL hasAppliedConstraints;
@property (nonatomic) CGFloat height;
@end

@implementation VSCategoryView
- (instancetype)initWithDelegate:(id <UICollectionViewDelegate>)delegate
                        dataSource:(id <UICollectionViewDataSource>)dataSource
                        height:(CGFloat)height {
  if (self = [super init]) {
		_delegate = delegate;
		_dataSource = dataSource;
    _height = height;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.wrapperView];
	[self.wrapperView addSubview:self.collectionView];
}

- (void)reload {
	[self.collectionView reloadData];
}

#pragma mark - UI Elements
- (UIView*)wrapperView {
	if (!_wrapperView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		_wrapperView = v;
	}
	return _wrapperView;
}

- (UICollectionView*)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
		[flowlayout setMinimumLineSpacing:0];
    [flowlayout setMinimumInteritemSpacing:0];
		[flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];

		UICollectionView* sv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
		sv.translatesAutoresizingMaskIntoConstraints = NO;
		sv.backgroundColor = [UIColor clearColor];
		sv.showsVerticalScrollIndicator = YES;
		sv.showsHorizontalScrollIndicator = NO;
		sv.contentInset = UIEdgeInsetsMake(32, 0, 20, 0);
		sv.delegate = self.delegate;
		sv.dataSource = self.dataSource;
		
    [sv registerClass:[VSDataCell class] forCellWithReuseIdentifier:[VSDataCell reuseID]];
    [sv registerClass:[VSBigPagerCell class] forCellWithReuseIdentifier:[VSBigPagerCell reuseID]];
		
		_collectionView = sv;
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
  
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  CGFloat h = self.height;
  CGFloat height = [VSUIUtils heightOfContentScrollVIew:h];

  
  NSLayoutConstraint* heightArrow = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:height];
	NSLayoutConstraint* widthArrow = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:width];
	
	[self.wrapperView addConstraints:@[heightArrow, widthArrow]];

	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingWrapperView, trailingWrapperView, topWrapperView, bottomWrapperView]];
	
	parent = self.wrapperView;
	
	NSLayoutConstraint* leadingCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-0];
	NSLayoutConstraint* topCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:8];
  NSLayoutConstraint* bottomCollectionView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-18];
	
	[parent addConstraints:@[leadingCollectionView, trailingCollectionView, topCollectionView, bottomCollectionView]];
}
@end

