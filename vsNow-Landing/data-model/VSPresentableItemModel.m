//
//  VSPresentableItemModel.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/20/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSPresentableItemModel.h"

@interface VSPresentableItemModel ()
@property (nonatomic, copy, readwrite) NSString* imageUrl;
@property (nonatomic, copy, readwrite) NSString* name;
@property (nonatomic, copy, readwrite) NSString* price;
@property (nonatomic, readwrite) VSItemStateType state;

@end

@implementation VSPresentableItemModel

- (instancetype)initWithImageUrl:(NSString*)imageUrl
												name:(NSString*)name
												price:(NSString*)price
												state:(VSItemStateType)state {
	if (self = [super init]) {
		_imageUrl = imageUrl;
		_name = name;
		_price = price;
		_state = state;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
}

@end
