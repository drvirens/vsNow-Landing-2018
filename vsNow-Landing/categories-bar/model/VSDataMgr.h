//
//  VSDataMgr.h
//  vsNow-Landing
//
//  Created by Virendra Shakya on 7/16/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSItemModel.h"

typedef NS_ENUM(NSInteger, VSCategoryType) {
	VSCategoryType_Begin = 69,
	VSCategoryType_End = 100
};

@interface VSDataMgr : NSObject
- (BOOL)isValidCategory:(NSInteger)tag;
- (BOOL)isPagerCell:(NSInteger)tag;
- (NSInteger)totalItemsInCategory:(NSInteger)tag;
- (VSItemModel*)getItemAtIndex:(NSInteger)index category:(NSInteger)category;
@end
