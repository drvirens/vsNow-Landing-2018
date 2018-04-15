//
//  VSScrollableMenuView.m
//  VSTopBarScrollView
//
//  Created by Nate on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSScrollableMenuView.h"
#import "VSArrowView.h"
#import "VSMenuView.h"
#import "VSCategoryView.h"
#import "VSUIUtils.h"
#import "VSLandingTheme.h"

static const NSInteger kDefaultPageIndex = 0;
static const CGFloat kExtremeEndAlpha = 0.2f;
static const CGFloat kIntermediateAlpha = 0.4f;
static const CGFloat kFocussedAlpha = 1.f;


@interface VSScrollableMenuView () <UIScrollViewDelegate>
@property (nonatomic) UIScrollView* scrollViewTopMenus;
@property (nonatomic) VSArrowView* arrowView;
@property (nonatomic) UIScrollView* scrollViewContents;
@property (nonatomic) UIView* wrapperView;

@property (nonatomic) NSMutableArray<UIView*>* menuViewsArray;
@property (nonatomic) NSMutableArray<UIView*>* contentViewsArray;

@property (nonatomic) BOOL pagingEnabled;
@property (nonatomic) BOOL hasAppliedConstraints;
@property (nonatomic) CGFloat height;

@property (nonatomic) NSInteger defaultPageIndex;
@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) NSInteger previousPageIndex;

@property (nonatomic) NSInteger numOfMenuItems;

@property (nonatomic) BOOL shouldApplyGradientToTopMenuBar;

@property (nonatomic) UIScrollView* currentScrollView;
@property (nonatomic) BOOL isLaidOut;

@property (nonatomic) NSLayoutConstraint* centerYArrowView;

@end

@implementation VSScrollableMenuView

- (instancetype)initWithDelegate:(id<VSScrollableMenuViewDelegate>)delegate
                        dataSource:(id<VSScrollableMenuViewDataSource>)dataSource
                        pagingEnabled:(BOOL)pagingEnabled
												height:(CGFloat)height
                        defaultPageIndex:(NSInteger)defaultPageIndex {
  if (self = [super init]) {
    _delegate = delegate;
    _dataSource = dataSource;
    _pagingEnabled = pagingEnabled;
		_height = height;
    _defaultPageIndex = defaultPageIndex;
    if (_defaultPageIndex < 0) {
      _defaultPageIndex = kDefaultPageIndex;
    }
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.shouldApplyGradientToTopMenuBar = YES;
	self.menuViewsArray = [NSMutableArray array];
  self.contentViewsArray = [NSMutableArray array];
	
	self.backgroundColor = [VSLandingTheme veryLightGrayColor];
  [self addSubview:self.arrowView];
  [self addSubview:self.scrollViewTopMenus];
  [self addSubview:self.scrollViewContents];
	[self addSubview:self.wrapperView];
}

- (void)setScrollableMenuViewDelegateAndDataSource:(id<VSScrollableMenuViewDelegate, VSScrollableMenuViewDataSource>)delegateAndDataSource {
	_delegate = delegateAndDataSource;
	_dataSource = delegateAndDataSource;
	
	[self setupTopMenuItems];
  [self setupTopContentItems];
}

- (void)setupTopMenuItems {
	if (self.dataSource && [self.dataSource  respondsToSelector:@selector(numberOfMenus)]) {
		self.numOfMenuItems = [self.dataSource numberOfMenus];
	}
	NSAssert(self.numOfMenuItems > 0, @"You must set at least one menu in the menu-items");
	for (NSInteger i = 0; i < self.numOfMenuItems; i++) {
		UIView* menuView = nil;
		if ( !(self.dataSource && [self.dataSource  respondsToSelector:@selector(scrollableMenuView:menuViewAtIndex:)]) ) {
			continue;
		}
		menuView = [self.dataSource scrollableMenuView:self menuViewAtIndex:i];
		if (menuView) {
			menuView.translatesAutoresizingMaskIntoConstraints = NO;
			menuView.userInteractionEnabled = YES;
			UITapGestureRecognizer* singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnMenu:)];
			menuView.tag = i;
			[menuView addGestureRecognizer:singleTapRecognizer];
			[self.scrollViewTopMenus addSubview:menuView];
			[self.menuViewsArray addObject:menuView];
		}
	}
}

- (void)setupTopContentItems {
	NSAssert(self.numOfMenuItems > 0, @"You must set at least one menu in the menu-items");
	
	for (NSInteger i = 0; i < self.numOfMenuItems; i++) {
		UIView* contentView = nil;
		if ( !(self.dataSource && [self.dataSource  respondsToSelector:@selector(scrollableMenuView:contentViewtIndex:)]) ) {
			continue;
		}
		contentView = [self.dataSource scrollableMenuView:self contentViewtIndex:i];
		if (contentView) {
			contentView.translatesAutoresizingMaskIntoConstraints = NO;
			[self.scrollViewContents addSubview:contentView];
			[self.contentViewsArray addObject:contentView];
		}
	}
}

- (void)applyGradientToTopMenuBar {
  if (!self.shouldApplyGradientToTopMenuBar) {
    return;
  }
  
  if (self.numOfMenuItems <= 0) {
    return;
  }
  
  for (NSInteger i = 0; i < self.numOfMenuItems; i++) {
    CGFloat alpha = 1.f;
    long offset = abs(i - self.currentPageIndex);
    if (offset > 1) {
      alpha = kExtremeEndAlpha;
    } else if (offset > 0) {
      alpha = kIntermediateAlpha;
    } else {
      alpha = kFocussedAlpha;
    }
    
    UIView* menuView = self.menuViewsArray[i];
    menuView.alpha = alpha;
		VSMenuView* menu = (VSMenuView*)menuView;
		[menu updatUI:alpha];
  }
}

- (void)setupPageIndex:(NSInteger)pageIndex {
  self.previousPageIndex = self.currentPageIndex;
  self.currentPageIndex = pageIndex;
  
  if (self.numOfMenuItems == 0) { //if we start with first, then dont touch contentOffset yet
    return;
  }
  
  CGFloat menuBarScrollViewOffsetX = 0.f;
  CGFloat contentScrollViewOffsetX = 0.f;
  
  for (NSInteger i = 0; i < pageIndex; i++) {
    menuBarScrollViewOffsetX += [self widthOfMenuItemAtIndex:i];
    contentScrollViewOffsetX += [self widthOfContentAtIndex:i];
  }
  
  CGFloat selfWidth = self.frame.size.width;
	CGFloat pageWidth = [self widthOfMenuItemAtIndex:pageIndex] / 2;
	
	CGFloat diff = selfWidth - pageWidth;
	diff /= 2;
	CGFloat x = menuBarScrollViewOffsetX - (diff);
	
	CGFloat offsetY = self.scrollViewTopMenus.contentOffset.y;
	CGFloat y = offsetY;
  
  CGPoint pt = CGPointMake(x, y);
  [self.scrollViewTopMenus setContentOffset:pt animated:NO];
}

- (CGFloat)widthOfMenuItemAtIndex:(NSInteger)index {
  CGFloat w = 0.f;
  VSMenuView* menu = (VSMenuView*)self.menuViewsArray[index];
  if ([menu respondsToSelector:@selector(width)]) {
    w = [menu width];
  }
  return w;
}

- (CGFloat)widthOfContentAtIndex:(NSInteger)index {
  CGFloat w = 0.f; //this is always the width of current screen
  w = self.frame.size.width;
  return w;
}

- (void)doMoreSetUp {
	CGFloat halfWidth = (self.bounds.size.width / 2);
	CGFloat menuItemViewWidth = [self widthOfMenuItemAtIndex:0];
	CGFloat halfmenuItemViewWidth = menuItemViewWidth / 2;
	CGFloat leftMargin = halfWidth - halfmenuItemViewWidth;
	
	menuItemViewWidth = [self widthOfMenuItemAtIndex:self.numOfMenuItems-1];
	halfmenuItemViewWidth = menuItemViewWidth / 2;
	CGFloat rightMargin = halfWidth - halfmenuItemViewWidth;
	
	//content inset for upper scroll view
	UIEdgeInsets insets = UIEdgeInsetsMake(0, leftMargin, 0, rightMargin);
	[self.scrollViewTopMenus setContentInset:insets];
}

- (void)lazyLoadPages {
	CGSize contentSizeBottom = self.scrollViewContents.contentSize;
	
	if (contentSizeBottom.width >= 0.f) {
		contentSizeBottom.height = self.scrollViewContents.bounds.size.height;
		[self.scrollViewContents setContentSize:contentSizeBottom];
	}
}


#pragma mark - lifecycle
- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self doMoreSetUp];

  [self setupPageIndex:self.defaultPageIndex];
	[self applyGradientToTopMenuBar];
	self.isLaidOut = YES;
	[self lazyLoadPages];
}

- (void)loadData:(NSInteger)pageIndex {
  VSCategoryView* category = nil;
  [category reload];
}

#pragma mark - related to scrolling
- (void)stopScrolling {
	[self.scrollViewTopMenus setContentOffset:self.scrollViewTopMenus.contentOffset animated:NO];
	[self.scrollViewContents setContentOffset:self.scrollViewContents.contentOffset animated:NO];
}

- (NSInteger)currentVisiblePageIndex {
	CGFloat width = self.frame.size.width;
	
	CGFloat w = self.scrollViewContents.contentOffset.x + (0.5f * width);
	
	NSInteger currPageIndex = w / width;
	
	if (currPageIndex < 0) {
		currPageIndex = 0;
	} else if (currPageIndex >= self.numOfMenuItems) {
		currPageIndex = self.numOfMenuItems - 1;
	}
	
	return currPageIndex;
}

- (void)moveToIndex:(NSInteger)index animated:(BOOL)animated {
	NSAssert(index >= 0 && index < self.numOfMenuItems, @"invalid index dude");
	if ( !(index >= 0 && index < self.numOfMenuItems) ) {
		return;
	}
	
	if (self.pagingEnabled) {
		[self stopScrolling];
		
		if (!self.currentScrollView || self.currentScrollView == self.scrollViewTopMenus) {
			self.currentScrollView = self.scrollViewContents;
			
			CGRect currrect = self.scrollViewContents.frame;
			
			CGFloat width = currrect.size.width; ////self.frame.size.width;
      CGFloat height = currrect.size.height;  //self.currentScrollView.frame.size.height;
			
			CGFloat x = width * (CGFloat)index;
			CGFloat y = currrect.origin.y;
			
			CGRect rect = CGRectMake(x, y, width, height);
			
			//ensure correct content size
			[self lazyLoadPages];
      [self.scrollViewContents scrollRectToVisible:rect animated:YES];
		}
	}
	
	if (self.previousPageIndex != index) {
		self.previousPageIndex = index;
		if (self.delegate && [self.delegate respondsToSelector:@selector(scrollableMenuView:didMoveToPage:)]) {
			[self.delegate scrollableMenuView:self didMoveToPage:index];
		}
	}
}

#pragma mark - top menu taps
- (void)didTapOnMenu:(id)sender {
	self.currentScrollView = self.scrollViewTopMenus;
	
	UITapGestureRecognizer* tapped = (UITapGestureRecognizer*)sender;
	UIView* tappedView = [tapped view];
	NSInteger index = tappedView.tag;
	[self moveToIndex:index animated:YES];
	//[self scrollViewDidScroll:self.scrollViewTopMenus];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self stopScrolling];
	self.currentScrollView = scrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSInteger index = [self currentVisiblePageIndex];
	[self moveToIndex:index animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (!decelerate) {
		NSInteger index = [self currentVisiblePageIndex];
		[self moveToIndex:index animated:YES];
		//[self adjustContentsScrollView];
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSInteger index = [self currentVisiblePageIndex];
	if (scrollView == self.currentScrollView) {
		CGFloat selfWidth = self.frame.size.width;
		CGFloat w = [self widthOfMenuItemAtIndex:index];
		CGFloat speed = selfWidth / w;
		CGFloat halfWidth = selfWidth/2;
		
		CGFloat menuWidth = 0.f;
		CGFloat contentsWidth = 0.f;
		
		for (NSInteger i = 0; i < index; i++) {
			menuWidth += [self widthOfMenuItemAtIndex:i];
			contentsWidth += self.bounds.size.width;
		}
		
		if (scrollView == self.scrollViewTopMenus) {
			CGFloat newX = ((self.scrollViewTopMenus.contentOffset.x + halfWidth - menuWidth) * speed) + contentsWidth - halfWidth;
			CGPoint contentoffset = self.scrollViewTopMenus.contentOffset;
			contentoffset.x = newX;
			[self.scrollViewContents setContentOffset:contentoffset animated:NO];
		}
		
		if (scrollView == self.scrollViewContents) {
			CGFloat newX = ((self.scrollViewContents.contentOffset.x + halfWidth - contentsWidth) / speed) + menuWidth - halfWidth;
			CGPoint contentoffset = self.scrollViewContents.contentOffset;
			contentoffset.x = newX;
			[self.scrollViewTopMenus setContentOffset:contentoffset animated:NO];
		}
		[self applyGradientToTopMenuBar];
	}
	
	if (self.isLaidOut && index != self.currentPageIndex) {
		self.currentPageIndex = index;
		
		//load pages
		[self lazyLoadPages];
	}
}

#pragma mark - UI Elements
- (UIView*)wrapperView {
	if (!_wrapperView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.hidden = YES;
		v.backgroundColor = [VSLandingTheme redColorInnerColor];
		_wrapperView = v;
	}
	return _wrapperView;
}

- (UIScrollView*)scrollViewTopMenus {
  if (!_scrollViewTopMenus) {
    UIScrollView* sv = [[UIScrollView alloc] init];
		sv.backgroundColor = [VSLandingTheme veryLightGrayColor];
    sv.translatesAutoresizingMaskIntoConstraints = NO;
    sv.pagingEnabled = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.delegate = self;
		
    _scrollViewTopMenus = sv;
  }
  return _scrollViewTopMenus;
}

- (VSArrowView*)arrowView {
  if (!_arrowView) {
    VSArrowView* arrowView = [[VSArrowView alloc] init];
    arrowView.translatesAutoresizingMaskIntoConstraints = NO;
    _arrowView = arrowView;
  }
  return _arrowView;
}


- (UIScrollView*)scrollViewContents {
  if (!_scrollViewContents) {
    UIScrollView* sv = [[UIScrollView alloc] init];
		sv.backgroundColor = [UIColor whiteColor];
    sv.translatesAutoresizingMaskIntoConstraints = NO;
    sv.pagingEnabled = self.pagingEnabled;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.delegate = self;
		
    _scrollViewContents = sv;
  }
  return _scrollViewContents;
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
//arrowView
//scrollViewTopMenus
//scrollViewContents
	UIView* parent = self;
	
		//lhs icon width and height
	NSLayoutConstraint* lhsIconWidth = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:8];
	NSLayoutConstraint* lhsIconHeight = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kHeightTopScrollView - 10.f];
	[self.wrapperView addConstraints:@[ lhsIconHeight, lhsIconWidth]];

	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:2];
//	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:15];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollViewTopMenus attribute:NSLayoutAttributeTop multiplier:1.f constant:0];

	
	[parent addConstraints:@[leadingWrapperView, //trailingWrapperView,
													  topWrapperView,
	]];
	
		//arrow
	NSLayoutConstraint* heightArrow = [NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kHeightArrowView * 2.f];
	
	[self.arrowView addConstraints:@[heightArrow /*, widthArrow*/]];
	
	NSLayoutConstraint* topArrowView = [NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0]; //kBottomArrowViewMargin
	NSLayoutConstraint* bottomArrowView = [NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollViewTopMenus attribute:NSLayoutAttributeTop multiplier:1.f constant:0]; //kBottomArrowViewMargin
	NSLayoutConstraint* leftArrowView = [NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:kTopScrollViewMargin];
	NSLayoutConstraint* rightArrowView = [NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-kTopScrollViewMargin];
	
	//top scroll view
	NSLayoutConstraint* heightTopScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewTopMenus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kHeightTopScrollView];
	[self.scrollViewTopMenus addConstraints:@[heightTopScrollView]];

	NSLayoutConstraint* topScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewTopMenus attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.arrowView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]; //kBottomArrowViewMargin
	NSLayoutConstraint* leftScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewTopMenus attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:kTopScrollViewMargin];
	NSLayoutConstraint* rightScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewTopMenus attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-kTopScrollViewMargin];
	
	NSLayoutConstraint* bottomScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewTopMenus attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollViewContents attribute:NSLayoutAttributeTop multiplier:1.f constant:-kTopScrollViewMargin];
	NSLayoutConstraint* topContentScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewContents attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollViewTopMenus attribute:NSLayoutAttributeBottom multiplier:1.f constant:kTopScrollViewMargin];


	NSLayoutConstraint* bottomContentScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewContents attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-kTopScrollViewMargin];
	NSLayoutConstraint* leftContentScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewContents attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:kTopScrollViewMargin];
	NSLayoutConstraint* rightContentScrollView = [NSLayoutConstraint constraintWithItem:self.scrollViewContents attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-kTopScrollViewMargin];
	

	[parent addConstraints:@[topScrollView, bottomScrollView, leftScrollView, rightScrollView,
													 topArrowView, bottomArrowView,
													 leftArrowView, rightArrowView,
													 //centerXArrowView,
													 topContentScrollView, bottomContentScrollView, leftContentScrollView, rightContentScrollView
													 ]];

	[self applyConstraintsForMenuItems];
	[self applyConstraintsForContentItems];
}

- (void)applyConstraintsForMenuItems {
	if (!self.menuViewsArray || self.menuViewsArray.count == 0) {
		return;
	}
	
	UIView* parent = self.scrollViewTopMenus;
  	
	//first view
	{
		UIView* firstMenu = self.menuViewsArray[0];
		firstMenu.translatesAutoresizingMaskIntoConstraints = NO;
	
		UIView* nextView = self.menuViewsArray[1];
	
		//height
		NSLayoutConstraint* heightArrow = [NSLayoutConstraint constraintWithItem:firstMenu attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44.f];
		[firstMenu addConstraints:@[heightArrow /*, widthArrow*/ ]];

		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:firstMenu attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:firstMenu attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
		NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:firstMenu attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
		
		[parent addConstraints:@[leading, trailing , centerY]];
	}
	
	//intermediate views
	NSInteger count = self.menuViewsArray.count - 2;
	for (NSInteger i = 1; i <= count; i++) {
		UIView* intermdiateMenu = self.menuViewsArray[i];
		intermdiateMenu.translatesAutoresizingMaskIntoConstraints = NO;
		
		UIView* previousView = self.menuViewsArray[i-1];
		UIView* nextView = self.menuViewsArray[i+1];
		
			//height
		NSLayoutConstraint* heightArrow = [NSLayoutConstraint constraintWithItem:intermdiateMenu attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44.f];
		[intermdiateMenu addConstraints:@[heightArrow /*, widthArrow */ ]];
		
		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:intermdiateMenu attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:intermdiateMenu attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
		NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:intermdiateMenu attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
		
		[parent addConstraints:@[leading, trailing , centerY ]];
	}
	
	//last view
	{
		count = self.menuViewsArray.count;
		UIView* lastMenu = self.menuViewsArray[count - 1];
		lastMenu.translatesAutoresizingMaskIntoConstraints = NO;
	
		UIView* previousView = self.menuViewsArray[count-2];
	
		//height
		NSLayoutConstraint* heightArrow = [NSLayoutConstraint constraintWithItem:lastMenu attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44.f];
		[lastMenu addConstraints:@[heightArrow /*, widthArrow*/ ]];

		
		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:lastMenu attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:lastMenu attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:lastMenu attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
		
		[parent addConstraints:@[leading, trailing , centerY ]];
	}
}

- (void)applyConstraintsForContentItems {
	if (!self.contentViewsArray || self.contentViewsArray.count == 0) {
		return;
	}
	
	UIView* parent = self.scrollViewContents;
  
  CGFloat h = self.height;
  CGFloat heightBottomScrollView = [VSUIUtils heightOfContentScrollVIew:h];
	
	//first view
	{
		UIView* firstContent = self.contentViewsArray[0];
		firstContent.translatesAutoresizingMaskIntoConstraints = NO;
	
		UIView* nextView = self.contentViewsArray[1];
	
		//height
		NSLayoutConstraint* heightContentView = [NSLayoutConstraint constraintWithItem:firstContent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil 
      attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:heightBottomScrollView];
		[firstContent addConstraints:@[heightContentView /*, widthContentView*/ ]];

		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:firstContent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:firstContent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:firstContent attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:2.f];

		[parent addConstraints:@[leading, trailing , centerY,
									]];
	}
	
	//intermediate views
	NSInteger count = self.contentViewsArray.count - 2;
	for (NSInteger i = 1; i <= count; i++) {
		UIView* intermdiateContent = self.contentViewsArray[i];
		intermdiateContent.translatesAutoresizingMaskIntoConstraints = NO;
		
		UIView* previousView = self.contentViewsArray[i-1];
		UIView* nextView = self.contentViewsArray[i+1];
		
			//height
		NSLayoutConstraint* heightContentView = [NSLayoutConstraint constraintWithItem:intermdiateContent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil 
      attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:heightBottomScrollView];
		[intermdiateContent addConstraints:@[heightContentView /*, widthContentView */ ]];
		
		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:intermdiateContent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:intermdiateContent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
		NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:intermdiateContent attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];

		[parent addConstraints:@[leading, trailing , centerY
		]];
	}
	
	//last view
	{
		count = self.contentViewsArray.count;
		UIView* lastContent = self.contentViewsArray[count - 1];
		lastContent.translatesAutoresizingMaskIntoConstraints = NO;
	
		UIView* previousView = self.contentViewsArray[count-2];
	
		//height
		NSLayoutConstraint* heightContentView = [NSLayoutConstraint constraintWithItem:lastContent attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil 
      attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:heightBottomScrollView];
		[lastContent addConstraints:@[heightContentView /*, widthContentView*/ ]];

		
		//constraints
		NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:lastContent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:lastContent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f];
		NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:lastContent attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];

		[parent addConstraints:@[leading, trailing , centerY
		]];
	}
}


@end

