//
//  VSLandingSimpleHeaderView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/9/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSLandingSimpleHeaderView : UIView
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* subtitle;
- (instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle;
@end
