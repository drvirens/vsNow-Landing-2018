//
//  VSCollectionViewFlowLayout.m
//  vsNow-Landing
//
//  Created by Nate on 7/12/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSCollectionViewFlowLayout.h"

@implementation VSCollectionViewFlowLayout
#if 0
- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];

    for(int i = 0; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = kMaxInterItemSpacing;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);

        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}
#endif

- (CGFloat)pageWidth {
	CGFloat pw = [UIScreen mainScreen].bounds.size.width ;
	return pw;
}

 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
 {           
        CGFloat rawPageValue = self.collectionView.contentOffset.x / self.pageWidth;
        CGFloat currentPage = (velocity.x > 0.0) ? floor(rawPageValue) : ceil(rawPageValue);
        CGFloat nextPage = (velocity.x > 0.0) ? ceil(rawPageValue) : floor(rawPageValue);

        BOOL pannedLessThanAPage = fabs(1 + currentPage - rawPageValue) > 0.5;
        BOOL flicked = fabs(velocity.x) > [self flickVelocity];
        if (pannedLessThanAPage && flicked) {
            proposedContentOffset.x = nextPage * self.pageWidth;
        } else {
            proposedContentOffset.x = round(rawPageValue) * self.pageWidth;
        }

        return proposedContentOffset;
 }

 - (CGFloat)flickVelocity {
     return 0.3;
 }

@end
