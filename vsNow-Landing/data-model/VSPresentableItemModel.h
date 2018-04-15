//
//  VSPresentableItemModel.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VSItemStateType) {
	VSItemStateTypeDefault,
	VSItemStateTypeNew,
	VSItemStateTypeSold,
	VSItemStateTypePriceDecreased
};

@interface VSPresentableItemModel : NSObject
@property (nonatomic, copy, readonly) NSString* imageUrl;
@property (nonatomic, copy, readonly) NSString* name;
@property (nonatomic, copy, readonly) NSString* price;
@property (nonatomic, readonly) VSItemStateType state;
@property (nonatomic) float cellWidth;

- (instancetype)initWithImageUrl:(NSString*)imageUrl
												name:(NSString*)name
												price:(NSString*)price
												state:(VSItemStateType)state;
@end
