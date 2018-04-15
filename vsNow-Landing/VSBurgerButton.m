//
//  VSBurgerButton.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/10/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSBurgerButton.h"

@implementation VSBurgerButton
- (instancetype)initWithImage:(NSString*)imgName {
	if (self = [super init]) {
		UIImage* img = [UIImage imageNamed:imgName];
		img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		[self setBackgroundImage:img forState:UIControlStateNormal];
		
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self setBackgroundColor:[UIColor redColor]];
}
@end
