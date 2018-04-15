//
//  VSSearchTextField.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/10/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSSearchTextField.h"
#import "VSLandingTheme.h"

@implementation VSSearchTextField
- (instancetype)initSearchPlaceHolderText:(NSString*)searchPlaceHolderText
										searchIconImage:(NSString*)searchIconImage {
	if (self = [super init]) {
		self.placeholder = searchPlaceHolderText;
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	self.backgroundColor = [VSLandingTheme searchBgColor];
	self.layer.borderColor = [VSLandingTheme searchBorderColor].CGColor;
	self.layer.borderWidth = 1.f;
	self.layer.cornerRadius = 5.f;
}
@end
