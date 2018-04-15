//
//  VSLandingView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/19/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingView.h"
#import "VSCategoriesTableViewCell.h"
#import "VSSellTableViewCell.h"
#import "VSSellHeaderTableViewCell.h"
#import "VSBrowseHeaderTableViewCell.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"

@interface VSLandingView ()
@property (nonatomic) id<UITableViewDelegate> tableDelegate;
@property (nonatomic) id<UITableViewDataSource> tableDataSrc;
@property (nonatomic, weak) id<UICollectionViewDelegate> collectionViewDelegate;
@property (nonatomic, weak) id<UICollectionViewDataSource> collectionViewDataSrc;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSLandingView

- (instancetype)initWithTableDelegate:(id<UITableViewDelegate>)delegate
												tableDataSrc:(id<UITableViewDataSource>)tableDataSrc
												collectionViewDelegate:(id<UICollectionViewDelegate>)collectionViewDelegate
												collectionViewDataSrc:(id<UICollectionViewDataSource>)collectionViewDataSrc {
	if (self = [super init]) {
		_tableDelegate = delegate;
		_tableDataSrc = tableDataSrc;
		_collectionViewDelegate = collectionViewDelegate;
		_collectionViewDataSrc = collectionViewDataSrc;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [VSLandingTheme tableViewBackground];
	[self addSubview:self.tableView];
}

#pragma mark - UI Elements
- (UITableView*)tableView {
	if (!_tableView) {
		CGRect r = [UIScreen mainScreen].bounds;
		UITableView* tv = [[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
		tv.translatesAutoresizingMaskIntoConstraints = NO;
		tv.allowsSelection = NO;
		tv.showsVerticalScrollIndicator = NO;
		tv.showsHorizontalScrollIndicator = NO;
		
		tv.backgroundColor = [UIColor whiteColor];
    tv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
		tv.contentOffset = CGPointMake(0, -kHeightOfTableViewHeader);
		tv.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		tv.delegate = self.tableDelegate;
		tv.dataSource = self.tableDataSrc;

		[tv registerClass:[VSCategoriesTableViewCell class] forCellReuseIdentifier:[VSCategoriesTableViewCell reusableID]];		
		[tv registerClass:[VSSellTableViewCell class] forCellReuseIdentifier:[VSSellTableViewCell reusableID]];
    [tv registerClass:[VSSellHeaderTableViewCell class] forCellReuseIdentifier:[VSSellHeaderTableViewCell reusableID]];
		[tv registerClass:[VSBrowseHeaderTableViewCell class] forCellReuseIdentifier:[VSBrowseHeaderTableViewCell reusableID]];
		
		_tableView = tv;
	}
	return _tableView;
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
	
	NSLayoutConstraint* leadingTableView = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingTableView = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topTableView = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomTableView = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingTableView, trailingTableView, topTableView, bottomTableView]];
}

@end
