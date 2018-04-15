//
//  VSScrollableMenuView.h
//  VSTopBarScrollView
//
//  Created by Nate on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSScrollableMenuView;

@protocol VSScrollableMenuViewDelegate <NSObject>
- (void)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
					didMoveToPage:(NSInteger)index;
- (void)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
					didScrollToPage:(NSInteger)index;
@end

@protocol VSScrollableMenuViewDataSource <NSObject>
- (NSInteger)numberOfMenus;
- (UIView*)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
          menuViewAtIndex:(NSInteger)index;
- (UIView*)scrollableMenuView:(VSScrollableMenuView*)scrollableMenuView
          contentViewtIndex:(NSInteger)index;
@end

@interface VSScrollableMenuView : UIView

@property (nonatomic, weak) id<VSScrollableMenuViewDelegate> delegate;
@property (nonatomic, weak) id<VSScrollableMenuViewDataSource> dataSource;

- (instancetype)initWithDelegate:(id<VSScrollableMenuViewDelegate>)delegate
                        dataSource:(id<VSScrollableMenuViewDataSource>)dataSource
                        pagingEnabled:(BOOL)pagingEnabled
												height:(CGFloat)height
                        defaultPageIndex:(NSInteger)defaultPageIndex;
- (void)setScrollableMenuViewDelegateAndDataSource:(id<VSScrollableMenuViewDelegate, VSScrollableMenuViewDataSource>)delegateAndDataSource;
@end
