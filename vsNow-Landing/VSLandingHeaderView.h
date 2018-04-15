//
//  VSLandingHeaderView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/9/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSLandingHeaderViewDelegate <NSObject>

- (void)didTapSearchField:(id)sender;
- (void)didTapOnRhsIcon:(id)sender;

@end

@interface VSLandingHeaderView : UIView
@property(nonatomic, copy) NSString* searchPlaceHolderText;
@property(nonatomic, copy) NSString* searchIconImage;
@property(nonatomic, copy) NSString* rhsIconImage;

- (instancetype)initWithSearchPlaceHolderText:(NSString*)searchPlaceHolderText
										searchIconImage:(NSString*)searchIconImage
										rhsIconImage:(NSString*)rhsIconImage
										delegate:(id<VSLandingHeaderViewDelegate>)delegate;
@end
