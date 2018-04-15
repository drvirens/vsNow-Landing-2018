//
//  VSLabel.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSLabel.h"

@implementation VSLabel
- (CGSize)intrinsicContentSize {
	CGSize size = [super intrinsicContentSize];
	CGSize newSize = CGSizeMake(size.width * 2.f, size.height + (size.height * .25f) );
	return newSize;
}
@end
