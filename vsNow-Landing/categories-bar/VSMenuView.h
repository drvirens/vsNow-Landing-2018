//
//  VSMenuView.h
//  VSTopBarScrollView
//
//  Created by Virendra Shakya on 7/6/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSMenuView : UIView
- (instancetype)initWithText:(NSString*)text;
- (CGFloat)width;
- (void)updatUI:(CGFloat)alpha;
@end
