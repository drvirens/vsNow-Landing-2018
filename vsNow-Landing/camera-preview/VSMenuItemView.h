//
//  VSMenuItemView.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSMenuItemView : UICollectionViewCell
- (void)configureWithImageUrl:(NSString*)imageUrl;
+ (NSString*)reusableID;
@end
