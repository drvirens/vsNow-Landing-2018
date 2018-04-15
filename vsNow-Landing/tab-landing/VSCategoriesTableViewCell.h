//
//  VSCategoriesTableViewCell.h
//  vsNow-Landing
//
//  Created by Nate on 6/28/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSScrollableMenuView.h"

@interface VSCategoriesTableViewCell : UITableViewCell
+ (NSString*)reusableID;
- (void)setScrollableMenuViewDelegateAndDataSource:(id<VSScrollableMenuViewDelegate, VSScrollableMenuViewDataSource>)delegateAndDataSource;
@end
