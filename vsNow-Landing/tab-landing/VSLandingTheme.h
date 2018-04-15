//
//  VSLandingTheme.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/21/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FONT_REGULAR  [VSLandingTheme fontRegular];
#define FONT_SMALL    [VSLandingTheme fontSmall];
#define FONT_X_SMALL  [VSLandingTheme fontXSmall];
#define FONT_MEDIUM   [VSLandingTheme fontMedium];
#define FONT_LARGE    [VSLandingTheme fontLarge];
#define FONT_X_LARGE  [VSLandingTheme fontXLarge];
#define FONT_X_X_LARGE

FOUNDATION_EXPORT const CGFloat kCornerRadius;

@interface VSLandingTheme : NSObject

//colors
+ (UIColor*)randomLightFlatColorForBackground;
+ (UIColor*)tableViewBackground;
+ (UIColor*)categoryViewBackground;
+ (UIColor*)topContainerBackground;
+ (UIColor*)collectionViewBackground;
+ (UIColor*)categoryItemViewBorderBorderColor;
+ (UIColor*)collectionViewViewBorderBorderColor;
+ (UIColor*)categoryItemtextColor;
+ (UIColor*)categoryItemSeeAlltextColor;
+ (UIColor*)categoryItemViewBackgroundColor;
+ (UIColor*)categoryItemViewNameTextColor;
+ (UIColor*)categoryItemViewPriceTextColor;
+ (UIColor*)cameraOverlayColor;
+ (UIColor*)searchBorderColor;
+ (UIColor*)topCellBgColor;
+ (UIColor*)sellCellBgColor;
+ (UIColor*)redColorInnerColor;
+ (UIColor*)redColorMiddleColor;
+ (UIColor*)redColorOuterColor;
+ (UIColor*)searchBgColor;
+ (UIColor*)searchTextColor;
+ (UIColor*)darkGreenColor;
+ (UIColor*)menuTextColor;
+ (UIColor*)veryLightGrayColor;
+ (UIColor*)yellowCaliforniaColor;
+ (UIColor*)flatBlueColor;
+ (UIColor*)currentPageIndicatorTintColorFlatBlue;
+ (UIColor*)pageIndicatorTintColorFlatBlue;

//categories
+ (UIColor*)categoryAllColor;
+ (UIColor*)categoryMenColor;
+ (UIColor*)categoryWomenColor;
+ (UIColor*)categoryKidsColor;
+ (UIColor*)categoryElectronicsColor;

//fonts
+ (UIFont*)fontMedium;
+ (UIFont*)fontSmall;
+ (UIFont*)fontXSmall;
+ (UIFont*)fontLarge;
+ (UIFont*)fontXLarge;
+ (UIFont*)fontRegular;

//gradients
+ (CAGradientLayer*)blueGradient:(UIColor*)color;

@end
