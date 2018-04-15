//
//  VSRegularItemView.h
//  vsNow-Landing
//
//  Created by Nate on 7/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSItemModel.h"

@interface VSRegularItemView : UIView
- (void)reset;
- (void)configureWithModel:(VSItemModel*)model;
@end
