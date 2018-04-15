//
//  VSPresentableCategory.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/22/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSPresentableCategory.h"
#import "VSLandingTheme.h"

@interface VSPresentableCategory ()
@property (nonatomic, copy, readwrite) NSString* categoryName;
@property (nonatomic, copy, readwrite) NSString* categoryIcon;
@property (nonatomic, readwrite) VSPresentableCategoryType type;
@property (nonatomic, readwrite) UIColor* categoryBgColor;

@end

@implementation VSPresentableCategory
- (instancetype)initWithCategoryName:(NSString*)name
												categoryIcon:(NSString*)icon
												categoryType:(VSPresentableCategoryType)categoryType {
	if (self = [super init]) {
		_categoryName = name;
		_categoryIcon = icon;
		_type = categoryType;
		
		UIColor* c = nil;
		switch (_type) {
			case VSPresentableCategoryTypeAll: {
				c = [VSLandingTheme categoryAllColor];
			} break;
			case VSPresentableCategoryTypeMen: {
				c = [VSLandingTheme categoryMenColor];
			} break;
			case VSPresentableCategoryTypeWomen: {
				c = [VSLandingTheme categoryWomenColor];
			} break;
			case VSPresentableCategoryTypeKids: {
				c = [VSLandingTheme categoryAllColor];
			} break;
			case VSPresentableCategoryTypeElectronics: {
				c = [VSLandingTheme categoryElectronicsColor];
			} break;
			default: {
				c = [VSLandingTheme categoryAllColor];
			} break;
		}
		_categoryBgColor = c;
	}
	return self;
}
@end
