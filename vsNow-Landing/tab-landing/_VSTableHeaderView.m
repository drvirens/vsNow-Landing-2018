//
//  VSTableHeaderView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSTableHeaderView.h"
#import "VSLandingHeaderView.h"
#import "VSLandingTheme.h"

@interface VSTableHeaderView () <VSLandingHeaderViewDelegate>
@property (nonatomic) VSLandingHeaderView* headerView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSTableHeaderView

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	[self addSubview:self.headerView];
	self.backgroundColor = [VSLandingTheme topCellBgColor];
}


+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

- (VSLandingHeaderView*)headerView {
	if (!_headerView) {
		VSLandingHeaderView* header = [[VSLandingHeaderView alloc] initWithSearchPlaceHolderText:@"Search any item here" searchIconImage:@"ic_search" rhsIconImage:@"dotted-logo" delegate:self];
		header.translatesAutoresizingMaskIntoConstraints = NO;
		_headerView = header;
	}
	return _headerView;
}

#pragma mark - layout constraints
+ (BOOL)requiresConstraintBasedLayout {
	return YES;
}

- (void)updateConstraints {
	if (!self.hasAppliedConstraints) {
		self.hasAppliedConstraints = YES;
		[self applyConstraints];
	}
	[super updateConstraints];
}

- (void)applyConstraints {
	UIView* parent = self;
	
	NSLayoutConstraint* leadingCollectionView = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:0];
	NSLayoutConstraint* trailingCollectionView = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0];
	NSLayoutConstraint* topCollectionView = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
	NSLayoutConstraint* bottomCollectionView = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingCollectionView, trailingCollectionView, topCollectionView, bottomCollectionView]];
}

//- (void)drawRect:(CGRect)rect {
//	//
//	// outer
//	//
//		CGContextRef outer = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(outer, 1.5);
//    CGContextSetFillColorWithColor(outer, [VSLandingTheme redColorInnerColor].CGColor);
//		CGFloat w = rect.size.height;
//		CGFloat width = (w/2) + 200;
//		CGFloat x = rect.origin.x - 100;
//		CGFloat y = rect.origin.y - 100;
//		CGRect outerRect = CGRectMake(x, y, width, width);
//	
//		//CGRect outerRect = CGRectMake(rect.origin.x + 5, rect.origin.y + 5, rect.size.width - 10, rect.size.height - 10);
//    CGContextAddEllipseInRect(outer, outerRect);
//    CGContextFillPath(outer);
//	
//	//
//	//middle
//	//
//		CGContextRef middle = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(middle, 1.5);
//    CGContextSetFillColorWithColor(middle, [VSLandingTheme redColorMiddleColor].CGColor);
////		CGRect middleRect = CGRectMake(rect.origin.x + 5, rect.origin.y + 5, rect.size.width - 20, rect.size.height - 20);
//		CGRect middleRect = CGRectMake(x - 20, y - 20, width - 25, width - 25 );
//	
//    CGContextAddEllipseInRect(middle, middleRect);
//    CGContextFillPath(middle);
//
//
//
//	//
//	// inner
//	//
//    CGContextRef inner = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(inner, 1.5);
//    CGContextSetFillColorWithColor(inner, [VSLandingTheme redColorOuterColor].CGColor);
//		//CGRect innerRect = CGRectMake(rect.origin.x + 15, rect.origin.y + 15, rect.size.width - 30, rect.size.height - 30);
//		CGRect innerRect = CGRectMake(x - 60, y - 60, width - 70, width - 70 );
//    CGContextAddEllipseInRect(inner, innerRect);
//    CGContextFillPath(inner);
//}

@end
