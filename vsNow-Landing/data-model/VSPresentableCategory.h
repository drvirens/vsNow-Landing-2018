//
//  VSPresentableCategory.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/22/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VSPresentableCategoryType) {
	VSPresentableCategoryTypeAll,
	VSPresentableCategoryTypeMen,
	VSPresentableCategoryTypeWomen,
	VSPresentableCategoryTypeKids,
	VSPresentableCategoryTypeElectronics
};
@interface VSPresentableCategory : NSObject

@property (nonatomic, copy, readonly) NSString* categoryName;
@property (nonatomic, copy, readonly) NSString* categoryIcon;
@property (nonatomic, readonly) VSPresentableCategoryType type;
@property (nonatomic, readonly) UIColor* categoryBgColor;

- (instancetype)initWithCategoryName:(NSString*)name
												categoryIcon:(NSString*)icon
												categoryType:(VSPresentableCategoryType)categoryType;
@end
