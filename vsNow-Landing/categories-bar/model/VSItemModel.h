//
//  VSItemModel.h
//  vsNow-Landing
//
//  Created by Nate on 7/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSItemModel : NSObject
@property (nonatomic, copy, readonly) NSString* imageUrl;
@property (nonatomic, copy, readonly) NSString* itemPrice;
@property (nonatomic, copy, readonly) NSString* itemWasPrice;
@property (nonatomic, readonly) BOOL isNewItem;
@property (nonatomic, readonly) BOOL hasWasPrice;
@property (nonatomic, readonly) NSInteger itemsLeft;

- (instancetype)initWithImageURL:(NSString*)imageUrl
                      itemPrice:(NSString*)itemPrice
                      itemWasPrice:(NSString*)itemWasPrice
                      isNewItem:(BOOL)isNewItem
                      itemsLeft:(NSInteger)itemsLeft;
@end
