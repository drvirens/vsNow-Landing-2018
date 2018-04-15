//
//  VSSellTableViewCell.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSProminentCalloutView.h"

@interface VSSellTableViewCell : UITableViewCell

@property (nonatomic) VSProminentCalloutView* calloutView;

@property (nonatomic) id<UICollectionViewDelegate> collectionViewDelegate;
@property (nonatomic) id<UICollectionViewDataSource> collectionViewDataSrc;
@property (nonatomic, weak) id<VSProminentCalloutViewDelegate> calloutDelegate;

+ (NSString*)reusableID;
- (void)reloadData;
@end
