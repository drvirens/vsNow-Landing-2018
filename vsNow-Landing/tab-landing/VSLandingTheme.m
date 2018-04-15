//
//  VSLandingTheme.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/21/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLandingTheme.h"
#import "UIColor+Branding.h"

#define OPACITY_BG 0.20f

const CGFloat kCornerRadius = 10.f;

@implementation VSLandingTheme

// colors
+ (UIColor*)randomLightFlatColorForBackground {
	UIColor* color = nil;
	static int nextColor = 0;
	if (nextColor == 0) {
		color = [UIColor colorWithRed:100.f/255.f green:150.f/255.f blue:255.f/255.f alpha:OPACITY_BG];
		nextColor++;
	} else if (nextColor == 1) {
		color = [UIColor colorWithRed:255.f/255.f green:211.f/255.f blue:224.f/255.f alpha:OPACITY_BG];
		nextColor++;
	} else if (nextColor == 2) {
		color = [UIColor colorWithRed:88.f/255.f green:86.f/255.f blue:214.f/255.f alpha:OPACITY_BG];
		nextColor++;
	} else if (nextColor == 3) {
		color = [UIColor colorWithRed:255.f/255.f green:19.f/255.f blue:0.f/255.f alpha:OPACITY_BG];
		nextColor++;
	} else if (nextColor == 4) {
		color = [UIColor colorWithRed:76.f/255.f green:217.f/255.f blue:100.f/255.f alpha:OPACITY_BG];
		nextColor++;
	} else if (nextColor == 5) {
		color = [UIColor colorWithRed:255.f/255.f green:149.f/255.f blue:0.f/255.f alpha:OPACITY_BG];
		nextColor = 0;
	}
	return color;
}

+ (UIColor*)tableViewBackground {
	return [VSLandingTheme redColorMiddleColor];
}
+ (UIColor*)categoryViewBackground {
  return [UIColor redColor];
}
+ (UIColor*)topContainerBackground {
  return [UIColor clearColor];
}
+ (UIColor*)collectionViewBackground {
	return [UIColor clearColor];
}

+ (UIColor*)brandColor {
	return [UIColor colorWithRed:41.f/255.f green:150.f/255.f blue:204.f/255.f alpha:1.f];
}

+ (UIColor*)cameraOverlayColor {
	return [VSLandingTheme darkGreenColor];
}

+ (UIColor*)searchBorderColor {
	return [UIColor colorWithRed:248.f/255.f green:94.f/255.f blue:117.f/255.f alpha:1.f];
}

+ (UIColor*)menuTextColor {
	return [UIColor colorWithRed:255.f/255.f green:222.f/255.f blue:230.f/255.f alpha:1.f];
}

+ (UIColor*)topCellBgColor {
	return [UIColor colorWithRed:243.f/255.f green:0.f/255.f blue:38.f/255.f alpha:1.f];
}

+ (UIColor*)sellCellBgColor {
	return [VSLandingTheme veryLightGrayColor];
}

+ (UIColor*)redColorOuterColor {
	return [UIColor colorWithRed:201.f/255.f green:0.f/255.f blue:32.f/255.f alpha:1.f];
}

+ (UIColor*)redColorMiddleColor {
	return [UIColor colorWithRed:217.f/255.f green:0.f/255.f blue:34.f/255.f alpha:1.f];
}

+ (UIColor*)redColorInnerColor {
	return [UIColor colorWithRed:226.f/255.f green:0.f/255.f blue:26.f/255.f alpha:1.f];
}

+ (UIColor*)searchBgColor {
	return [UIColor colorWithRed:243.f/255.f green:0.f/255.f blue:38.f/255.f alpha:1.f];
}

+ (UIColor*)searchTextColor {
	return [UIColor colorWithRed:239.f/255.f green:181.f/255.f blue:186.f/255.f alpha:1.f];
}


+ (UIColor*)darkGreenColor {
	return [UIColor colorWithRed:1.f/255.f green:178.f/255.f blue:127.f/255.f alpha:1.f];
}

+ (UIColor*)categoryItemViewBorderBorderColor {
	return [VSLandingTheme veryLightGrayColor];
}
+ (UIColor*)collectionViewViewBorderBorderColor {
	return [UIColor clearColor];
}
+ (UIColor*)categoryItemtextColor {
  return [UIColor blackColor];
}
+ (UIColor*)categoryItemSeeAlltextColor {
  return [UIColor lightGrayColor];
}
+ (UIColor*)categoryItemViewBackgroundColor {
	return [UIColor colorWithRed:247.f/255.f green:247.f/255.f blue:247.f/255.f alpha:1.f];
}
+ (UIColor*)categoryItemViewNameTextColor {
  return [UIColor lightGrayColor];
}
+ (UIColor*)categoryItemViewPriceTextColor {
  return [UIColor darkGrayColor];
}

+ (UIColor*)veryLightGrayColor {
	return [UIColor colorWithRed:229.f/255.f green:229.f/255.f blue:229.f/255.f alpha:1.f];
}

+ (UIColor*)yellowCaliforniaColor {
	return [UIColor colorWithRed:248.f/255.f green:148.f/255.f blue:6.f/255.f alpha:1.f];
}

+ (UIColor*)flatBlueColor {
	return [UIColor colorWithRed:27.f/255.f green:178.f/255.f blue:234.f/255.f alpha:1.f];
}

+ (UIColor*)pageIndicatorTintColorFlatBlue {
	return [UIColor colorWithRed:129.f/255.f green:214.f/255.f blue:246.f/255.f alpha:1.f];
}

+ (UIColor*)currentPageIndicatorTintColorFlatBlue {
	//return [UIColor colorWithRed:27.f/255.f green:178.f/255.f blue:234.f/255.f alpha:1.f];
	return [UIColor whiteColor];
}

//category colors
+ (UIColor*)categoryAllColor {
	return [UIColor colorWithRed:100.f/255.f green:150.f/255.f blue:255.f/255.f alpha:1.f];
}
+ (UIColor*)categoryMenColor {
	return [UIColor colorWithRed:255.f/255.f green:148.f/255.f blue:0.f/255.f alpha:1.f];
}
+ (UIColor*)categoryWomenColor {
	return [UIColor colorWithRed:255.f/255.f green:21.f/255.f blue:0.f/255.f alpha:1.f];
}
+ (UIColor*)categoryKidsColor {
	return [UIColor colorWithRed:255.f/255.f green:19.f/255.f blue:0.f/255.f alpha:1.f];
}
+ (UIColor*)categoryElectronicsColor {
	return [UIColor colorWithRed:245.f/255.f green:217.f/255.f blue:0.f/255.f alpha:1.f];
}

//fonts
+ (UIFont*)fontMedium {
  UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:18.f];
  return font;
}
+ (UIFont*)fontSmall {
  UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:16.f];
  return font;
}
+ (UIFont*)fontXSmall {
  UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:13.f];
  return font;
}
+ (UIFont*)fontLarge {
  UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:22.f];
  return font;
}
+ (UIFont*)fontXLarge {
	UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:28.f];
  return font;
}
+ (UIFont*)fontRegular {
  UIFont* font = [UIFont fontWithName:@"Futura-Medium" size:18.f];
  return font;
}


//gradients
+ (CAGradientLayer*)blueGradient:(UIColor*)color {
  UIColor* blueColor = color; //[UIColor colorWithRed:0.f/255.f green:122.f/255.f blue:255.f/255.f alpha:1.f];
  
  UIColor* colorOne = blueColor; 
  UIColor* colorTwo = [UIColor whiteColor];
  UIColor* colorThree = [UIColor whiteColor];
  NSArray* colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, nil];
  
  NSNumber* stopOne = [NSNumber numberWithFloat:0.0];
  NSNumber* stopTwo = [NSNumber numberWithFloat:0.70];
  NSNumber* stopThree = [NSNumber numberWithFloat:1.0];
  NSArray<NSNumber*>* locations = @[stopOne, stopTwo, stopThree];
  
  CAGradientLayer* gradientlayer = [CAGradientLayer layer];
  gradientlayer.colors = colors;
  gradientlayer.locations = locations;
  
  return gradientlayer;
}

@end
