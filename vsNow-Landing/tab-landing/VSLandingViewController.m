//
//  VSLandingViewController.m
//  ssi
//
//  Created by Virendra Shakya on 5/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingViewController.h"
#import "VSLandingView.h"
#import "VSCategoriesTableViewCell.h"
#import "VSSellTableViewCell.h"
#import "VSSellHeaderTableViewCell.h"
#import "VSBrowseHeaderTableViewCell.h"
#import "VSCollectionView.h"
#import "VSItemCollectionViewCell.h"
#import "VSPresentableItemModel.h"
#import "VSCategoryView.h"
#import "VSResourceNames.h"
#import "VSLandingTheme.h"
#import "VSLandingUIConstants.h"
#import "VSPresentableCategory.h"
#import "VSMenuItemView.h"
#import "VSMenuItemPhotoView.h"
#import "VSUIUtils.h"
#import "VSArrowView.h"
#import "VSScrollableMenuView.h"
#import "VSMenuView.h"
#import "VSCategoryView.h"
#import "VSDataCell.h"
#import "VSLandingTheme.h"
#import "VSDataMgr.h"
#import "VSBigPagerView.h"
#import "VSBigPagerCell.h"
#import "VSSmallItemCollectionViewCell.h"

@interface VSLandingViewController () <UITableViewDelegate,
																			 UITableViewDataSource,
																			 UICollectionViewDelegate,
																			 UICollectionViewDataSource,
																			 VSScrollableMenuViewDelegate,
																			 VSScrollableMenuViewDataSource>
@property (nonatomic) VSLandingView* landingView;
@property (nonatomic) NSMutableArray<VSPresentableCategory*>* categoryArray;
@property (nonatomic) NSMutableArray<NSString*>* imageUrls;
@property (nonatomic) NSMutableArray<NSString*>* menuNames;
@property (nonatomic) NSInteger currentColor;

@property (nonatomic) NSMutableArray<UIView*>* menuViewsArray;
@property (nonatomic) NSMutableArray<UIView*>* contentViewsArray;
@property (nonatomic) NSMutableArray<UIColor*>* colorArray;

@property (nonatomic) BOOL isCellExpanded;

//@property (nonatomic) VSBigPagerCell* pagerCell;

@property (nonatomic) VSDataMgr* dataMgr;
@end

@implementation VSLandingViewController

+ (UIViewController*)viewController {
	VSLandingViewController* landingVC = [[VSLandingViewController alloc] init];
	UINavigationController* navvc = [[UINavigationController alloc] initWithRootViewController:landingVC];
	return navvc;
//	return laxxndingVC;
}

-(instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
			self.title = @"";
			self.tabBarItem.image = [self tabBarIcon];
			self.dataMgr = [[VSDataMgr alloc] init];
    }
    return self;
}

- (void)addLeftNavBarButton {
	UIImage* img = [UIImage imageNamed:@"ic_settings_36pt"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	
	UIBarButtonItem* lhsBarButton = [[UIBarButtonItem alloc] initWithImage:img  style:UIBarButtonItemStylePlain target:self action:@selector(didTapSettingsBtn:)];
	lhsBarButton.tintColor = [VSLandingTheme redColorInnerColor];
	
	self.navigationItem.leftBarButtonItem = lhsBarButton;
}

- (void)didTapSettingsBtn:(id)sender {
}

- (void)addRightNavBarButtons {
	UIImage* img = [UIImage imageNamed:@"ic_search_white_36pt"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	UIBarButtonItem* searchBarBtn = [[UIBarButtonItem alloc] initWithImage:img  style:UIBarButtonItemStylePlain target:self action:@selector(didTapSearchBtn:)];
	searchBarBtn.tintColor = [VSLandingTheme redColorInnerColor];
	
	//
	img = [UIImage imageNamed:@"ic_search_white_36pt"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	UIBarButtonItem* notificationsBarBtn = [[UIBarButtonItem alloc] initWithImage:img  style:UIBarButtonItemStylePlain target:self action:@selector(didTapNotificationsBtn:)];
	notificationsBarBtn.tintColor = [VSLandingTheme redColorInnerColor];
	
	self.navigationItem.rightBarButtonItems = @[searchBarBtn, notificationsBarBtn];
}

- (void)didTapSearchBtn:(id)sender {
}

- (void)didTapNotificationsBtn:(id)sender {
}


-(void)viewDidLayoutSubviews{
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.automaticallyAdjustsScrollViewInsets = YES;
	
	[self onViewDidLoad];
//	[self testPager];
}

- (void)testPager {
	self.view.backgroundColor = [UIColor blueColor];
	VSBigPagerView* pagerview = [[VSBigPagerView alloc] initWithFrame:self.view.bounds];
	[pagerview setCollectionViewDataSrcAndDelegate:self indexpath:nil];
	[self.view addSubview:pagerview];
}

- (void)onViewDidLoad {
	[self addLeftNavBarButton];
	[self addRightNavBarButtons];
	
	[self addMenuNames];
	[self populateImageUrls];
	[self populateCategoryArray];

	self.tabBarController.tabBar.translucent = NO;
	self.navigationController.navigationBar.translucent = NO;
	
	[self addLandingViewConstraints];
	
	UIView* tblHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];

	_landingView.tableView.tableHeaderView = tblHeaderView;
	[_landingView.tableView sendSubviewToBack:_landingView.tableView.tableHeaderView];
}


- (void)addLandingViewConstraints {
	UIView* parent = self.view;
	
	[self.view addSubview:self.landingView];
	
	NSLayoutConstraint* leadingTableView = [NSLayoutConstraint constraintWithItem:self.landingView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingTableView = [NSLayoutConstraint constraintWithItem:self.landingView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topTableView = [NSLayoutConstraint constraintWithItem:self.landingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomTableView = [NSLayoutConstraint constraintWithItem:self.landingView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	bottomTableView.priority = UILayoutPriorityDefaultLow;
	[parent addConstraints:@[leadingTableView, trailingTableView, topTableView, bottomTableView]];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
	return NO;
}

#pragma mark - data
- (void)addMenuNames {
	
	self.menuNames = [NSMutableArray array];
	[self.menuNames addObjectsFromArray:@[ @"Electronics", @"Shoes", @"Tablets", @"3D Printers & Supplies", @"TRAVEL", @"STYLE", @"SPECIALS"]];
	self.menuViewsArray = [NSMutableArray array];
	{
		for (NSInteger i = 0; i < self.menuNames.count; i++) {
			NSString* name = self.menuNames[i];
			VSMenuView* oneMenu = [[VSMenuView alloc] initWithText:name];
			[self.menuViewsArray addObject:oneMenu];
		}
	}
  
  self.colorArray = [NSMutableArray array];
	[self.colorArray addObjectsFromArray:@[
																				[UIColor whiteColor],
																				[UIColor whiteColor],
																				[UIColor whiteColor],
																				[UIColor whiteColor],
																				[UIColor whiteColor],
																				[UIColor whiteColor],
																				[UIColor whiteColor]
																				]];

	self.contentViewsArray = [NSMutableArray array];
	{
		  CGFloat h = self.view.frame.size.height; //XXX
			for (NSInteger i = 0; i < self.menuNames.count; i++) {
				VSCategoryView* contentView = [[VSCategoryView alloc] initWithDelegate:self dataSource:self height:h];
				NSInteger categoryType = VSCategoryType_Begin + i;
				contentView.collectionView.tag = categoryType; //69;
				contentView.backgroundColor = self.colorArray[i];
				[self.contentViewsArray addObject:contentView];
			}
	}
}

- (void)populateImageUrls {
	self.imageUrls = [NSMutableArray array];
	[self.imageUrls addObject:@"sku_362719_1_small.jpg"];
	[self.imageUrls addObject:@"sku_396047_1_small.jpg"];
	[self.imageUrls addObject:@"sku_417673_1_small.jpg"];
	[self.imageUrls addObject:@"sku_82148_1_small.jpg"];
	[self.imageUrls addObject:@"sku_331592_1_small.jpg"];
	[self.imageUrls addObject:@"sku_260021_1_small.jpg"];
	[self.imageUrls addObject:@"sku_381336_1_small.jpg"];
	[self.imageUrls addObject:@"sku_426491_1_small.jpg"];
	[self.imageUrls addObject:@"sku_399029_1_small.jpg"];
	
	[self.imageUrls addObject:@"ic_more_horiz_white"];
}


// XXX - these should be coming from cloud
- (void)populateCategoryArray {
	self.categoryArray = [NSMutableArray array];
	
	VSPresentableCategory* dummy = [VSPresentableCategory new];
	[self.categoryArray addObject:dummy];
	[self.categoryArray addObject:dummy];
	[self.categoryArray addObject:dummy];
	
	VSPresentableCategory* categoryAll = [[VSPresentableCategory alloc] initWithCategoryName:@"All" categoryIcon:@"" categoryType:VSPresentableCategoryTypeAll];
	[self.categoryArray addObject:categoryAll];
}

#pragma mark - UI Elements
- (UIImage*)tabBarIcon {
	UIImage* img = [UIImage imageNamed:@"tab-home"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return img;
}

- (VSLandingView*)landingView {
	if (!_landingView) {
		VSLandingView* lv = [[VSLandingView alloc] initWithTableDelegate:self tableDataSrc:self collectionViewDelegate:self collectionViewDataSrc:self];
		lv.translatesAutoresizingMaskIntoConstraints = NO;
		_landingView = lv;
	}
	return _landingView;
}

- (CGFloat)cellHeight {
	CGFloat h = self.view.frame.size.height ;
	return h;
}

#pragma mark - tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if				(0 == indexPath.row) { //sell-header
		return 60;
	} else if (1 == indexPath.row) { //sell
		return 180;
	}
	else if   (2 == indexPath.row) { //browse header
		return 0;
	}
	CGFloat ret = [self cellHeight] ; //+ 20;
	return ret;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.categoryArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (0 == indexPath.row) {
		VSSellHeaderTableViewCell* cell = (VSSellHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[VSSellHeaderTableViewCell reusableID] forIndexPath:indexPath];
		return cell;
	} else if (1 == indexPath.row) {
		VSSellTableViewCell* cell = (VSSellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[VSSellTableViewCell reusableID] forIndexPath:indexPath];
		return cell;
	}
	else if (2 == indexPath.row) {
		VSBrowseHeaderTableViewCell* cell = (VSBrowseHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[VSBrowseHeaderTableViewCell reusableID] forIndexPath:indexPath];
		return cell;
	}
	else {
		VSCategoriesTableViewCell* cell = (VSCategoriesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[VSCategoriesTableViewCell reusableID] forIndexPath:indexPath];
		//[cell setScrollableMenuViewDelegateAndDataSource:self];
		return cell;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger index = indexPath.row;
	
	if (0 == index) {
		NSLog(@"this is sell header");
		return;
	} else if (1 == index) {
		VSSellTableViewCell* c = (VSSellTableViewCell*)cell;
		c.collectionViewDelegate = self;
		c.collectionViewDataSrc = self;
		
		[c reloadData];
		return;
	}
	if (2 == index) {
		NSLog(@"this is browse header");
		return;
	}
	VSCategoriesTableViewCell* c = (VSCategoriesTableViewCell*)cell;
	[c setScrollableMenuViewDelegateAndDataSource:self];
}

#pragma mark - collection view 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSInteger tag = collectionView.tag;
	if ([self.dataMgr isValidCategory:tag]) {
		NSInteger totalItemsInCategory = [self.dataMgr totalItemsInCategory:tag];
		return totalItemsInCategory;
	}
	
	if ([collectionView isKindOfClass:[VSCollectionView class]]) { //pager collection view
		return 5;
	}

	
	return self.imageUrls.count; //top Just Added collection view
}

// fixthisshit
- (CGFloat)pageWidth {
	return ([VSUIUtils itemMenuWidth] * 3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGSize size;
	CGFloat baseWidth = [VSUIUtils itemMenuWidth];
	CGFloat baseHeight = baseWidth + (0.40f * baseWidth);
	CGFloat basePagerHeight = (baseHeight*1.5f);
	
	NSInteger tag = collectionView.tag;
	{
		CGFloat w = baseWidth;
    CGFloat height = baseHeight;
    CGFloat width = w;
		if ([self.dataMgr isValidCategory:tag]) {
			if (indexPath.item == 0) { //pagerCell
				size = CGSizeMake(width * 3, basePagerHeight);
				return size;
			}
			size = CGSizeMake(width, height);
			return size;
		}
	}
	
	if ([collectionView isKindOfClass:[VSCollectionView class]]) { //pager collection view
		CGFloat height = basePagerHeight-100;
		CGFloat width = [self pageWidth];
		//width = width * 3;
		size = CGSizeMake(width, height);
		return size;
	}
	
  //for the photo cell
  CGFloat heightPhotoCell = [VSUIUtils menuWidth] + 10;
  CGFloat widthPhotoCell = [VSUIUtils menuWidth] + 10;
  size = CGSizeMake(widthPhotoCell, heightPhotoCell);
  return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger tag = collectionView.tag;
	if ([self.dataMgr isValidCategory:tag]) {
		if (indexPath.item == 0) {
//			self.pagerCell = (VSBigPagerCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[VSBigPagerCell reuseID] forIndexPath:indexPath];
//			
//			return self.pagerCell;
			VSBigPagerCell* pagerCell = (VSBigPagerCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[VSBigPagerCell reuseID] forIndexPath:indexPath];
			[pagerCell layoutIfNeeded];
			return pagerCell;
		}
		
		VSDataCell* cell = (VSDataCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[VSDataCell reuseID] forIndexPath:indexPath];
		VSItemModel* model = [self.dataMgr getItemAtIndex:indexPath.item category:tag];
    [cell configureWithModel:model];
		return cell;
	}
	
	if ([collectionView isKindOfClass:[VSCollectionView class]]) { //pager collection view
		VSSmallItemCollectionViewCell* cell = (VSSmallItemCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[VSSmallItemCollectionViewCell reusableID] forIndexPath:indexPath];
		return cell;

	}
	
  UICollectionViewCell* cell = [self callOut_collectionView:collectionView cellForItemAtIndexPath:indexPath];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger tag = collectionView.tag;
	if ([self.dataMgr isValidCategory:tag]) {
    NSLog(@"Selected an item from category");
    return;
  }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
	BOOL tag = cell && [cell isKindOfClass:[VSBigPagerCell class]];
	if (tag) {
		VSBigPagerCell* c = (VSBigPagerCell*)cell;
		[c.regularItemView setCollectionViewDataSrcAndDelegate:self indexpath:indexPath];
	}
}

- (UICollectionViewCell*)callOut_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.imageUrls.count - 1 == indexPath.item) { //last cell is "more"
    VSMenuItemView* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[VSMenuItemView reusableID] forIndexPath:indexPath];
    NSString* theimage = self.imageUrls[indexPath.item];
    [cell configureWithImageUrl:theimage];
    return cell;
  } else {
    VSMenuItemPhotoView* photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:[VSMenuItemPhotoView reusableID] forIndexPath:indexPath];
		VSItemModel* model = [[VSItemModel alloc] initWithImageURL:self.imageUrls[indexPath.item]
            itemPrice:@"$69" itemWasPrice:@"     $78     " isNewItem:YES itemsLeft:10];
    [photoCell configureWithModel:model];
    return photoCell;
  }
  return nil;
}

static const NSInteger numOfMenuItems = 5;

- (NSInteger)currentVisiblePageIndex:(VSCollectionView*)collectionView {
	CGFloat width = collectionView.frame.size.width;
	
	CGFloat w = collectionView.contentOffset.x + (0.5f * width);
	
	NSInteger currPageIndex = w / width;
	
	if (currPageIndex < 0) {
		currPageIndex = 0;
	} else if (currPageIndex >= numOfMenuItems) {
		currPageIndex = numOfMenuItems - 1;
	}
	
	return currPageIndex;
}

- (void)moveToIndex:(NSInteger)index animated:(BOOL)animated collectionView:(VSCollectionView*)collectionView {
	NSAssert(index >= 0 && index < numOfMenuItems, @"invalid index dude");
	if ( !(index >= 0 && index < numOfMenuItems) ) {
		return;
	}
	
//	if (self.pagingEnabled) {
//		[self stopScrolling];
	
//		if (!self.currentScrollView || self.currentScrollView == self.scrollViewTopMenus) {
//			self.currentScrollView = self.scrollViewContents;
	
			CGRect currrect = collectionView.frame;
			
			CGFloat width = self.view.frame.size.width;
      CGFloat height = currrect.size.height;  //self.currentScrollView.frame.size.height;
			
			CGFloat x = width * (CGFloat)index;
			CGFloat y = currrect.origin.y;
			
			CGRect rect = CGRectMake(x, y, width, height);
			
			//ensure correct content size
//			[self lazyLoadPages];
      [collectionView scrollRectToVisible:rect animated:YES];
//		}
//	}
	
//	if (self.previousPageIndex != index) {
//		self.previousPageIndex = index;
//		if (self.delegate && [self.delegate respondsToSelector:@selector(scrollableMenuView:didMoveToPage:)]) {
//			[self.delegate scrollableMenuView:self didMoveToPage:index];
//		}
//	}
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (![scrollView isKindOfClass:[UICollectionView class]]) {
		return;
	}
	
	if (![scrollView isKindOfClass:[VSCollectionView class]]) {
		return;
	}
	
	VSCollectionView* collectionView = (VSCollectionView*)scrollView;
	VSBigPagerView* regularView = (VSBigPagerView*)collectionView.superview;
		if (regularView) {
			NSInteger index = [self currentVisiblePageIndex:collectionView];
			regularView.pageControl.currentPage = index;
			[self moveToIndex:index animated:YES collectionView:collectionView];
		}
}

#pragma mark - VSScrollableMenuViewDelegate
- (void)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
					didMoveToPage:(NSInteger)index {
	NSLog(@"didMoveToPage");
}
- (void)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
					didScrollToPage:(NSInteger)index {
	NSLog(@"didScrollToPage");
}

#pragma mark - VSScrollableMenuViewDataSource
- (NSInteger)numberOfMenus{
	return self.menuNames.count;
}
- (UIView*)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
          menuViewAtIndex:(NSInteger)index {
	return self.menuViewsArray[index];
}
- (UIView*)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
          contentViewtIndex:(NSInteger)index {
		return self.contentViewsArray[index];
}

@end
