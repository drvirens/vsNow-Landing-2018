//
//  VSProminentCalloutView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSProminentCalloutView;

@protocol VSProminentCalloutViewDelegate <NSObject>
@end

@interface VSProminentCalloutView : UIView

- (instancetype)initWithFirstIcon:(NSString*)icon
	lastIcon:(NSString*)icon
	delegate:(id <UICollectionViewDelegate>)delegate
	dataSource:(id <UICollectionViewDataSource>)dataSource
	calloutDelegate:(id<VSProminentCalloutViewDelegate>)calloutDelegate;
- (instancetype)initWithFirstIcon:(NSString*)firstIcon
      lastIcon:(NSString*)lastIcon;
      
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource calloutDelegate:(id<VSProminentCalloutViewDelegate>)calloutDelegate;
@end
