//
//  VSProminentCalloutView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSProminentCalloutView.h"
#import "VSUIUtils.h"
#import "VSMenuItemView.h"
#import "VSMenuItemPhotoView.h"
#import "VSMenuItemBarcodeScanView.h"


@interface VSProminentCalloutView ()
@property (nonatomic) UIView* wrapperView;
@property (nonatomic) UICollectionView* collectionView;
@property (nonatomic, weak, nullable) id <UICollectionViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <UICollectionViewDataSource> dataSource;
@property (nonatomic, weak) id<VSProminentCalloutViewDelegate> calloutDelegate;

@property (nonatomic, copy) NSString* firstIcon;
@property (nonatomic, copy) NSString* lastIcon;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSProminentCalloutView
- (instancetype)initWithFirstIcon:(NSString*)firstIcon
	lastIcon:(NSString*)lastIcon
	delegate:(id <UICollectionViewDelegate>)delegate
	dataSource:(id <UICollectionViewDataSource>)dataSource
	calloutDelegate:(id<VSProminentCalloutViewDelegate>)calloutDelegate {
	if (self = [super init]) {
		_firstIcon = firstIcon;
		_lastIcon = lastIcon;
		_delegate = delegate;
		_dataSource = dataSource;
		_calloutDelegate = calloutDelegate;
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithFirstIcon:(NSString*)firstIcon
      lastIcon:(NSString*)lastIcon {
	if (self = [super init]) {
		_firstIcon = firstIcon;
		_lastIcon = lastIcon;
		[self commonInit];
	}
	return self;
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource calloutDelegate:(id<VSProminentCalloutViewDelegate>)calloutDelegate {
  self.collectionView.delegate = delegate;
  self.collectionView.dataSource = dataSource;
  self.calloutDelegate = calloutDelegate;
  
  [self.collectionView reloadData];
}

- (void)commonInit {
	[self addSubview:self.wrapperView];
	[self.wrapperView addSubview:self.collectionView];
	self.backgroundColor = [UIColor whiteColor];
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
		[flowlayout setMinimumLineSpacing:10];
    [flowlayout setMinimumInteritemSpacing:10];
		[flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
		
		UICollectionView* sv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
		sv.translatesAutoresizingMaskIntoConstraints = NO;
		sv.backgroundColor = [UIColor clearColor];
    //sv.backgroundColor = [UIColor blueColor];
		sv.showsVerticalScrollIndicator = NO;
		sv.showsHorizontalScrollIndicator = NO;
		sv.contentInset = UIEdgeInsetsMake(0, 10, 0, 20);
		
		[sv registerClass:[VSMenuItemView class] forCellWithReuseIdentifier:[VSMenuItemView reusableID]];
    [sv registerClass:[VSMenuItemPhotoView class] forCellWithReuseIdentifier:[VSMenuItemPhotoView reusableID]];
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
	
	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-0];
	
	[parent addConstraints:@[leadingWrapperView, trailingWrapperView, topWrapperView, bottomWrapperView]];
	
	parent = self.wrapperView;
	
	NSLayoutConstraint* leadingScrollView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingScrollView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topScrollView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
  NSLayoutConstraint* bottomScrollView = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingScrollView, trailingScrollView, topScrollView, bottomScrollView]];
}


@end
