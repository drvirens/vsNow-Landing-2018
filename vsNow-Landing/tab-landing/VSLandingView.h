//
//  VSLandingView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/19/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSLandingView : UIView

@property (nonatomic) UITableView* tableView;

- (instancetype)initWithTableDelegate:(id<UITableViewDelegate>)delegate
												tableDataSrc:(id<UITableViewDataSource>)tableDataSrc
												collectionViewDelegate:(id<UICollectionViewDelegate>)collectionViewDelegate
												collectionViewDataSrc:(id<UICollectionViewDataSource>)collectionViewDataSrc;

@end
