//
//  VSItemModel.m
//  vsNow-Landing
//
//  Created by Nate on 7/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSItemModel.h"

@interface VSItemModel ()
@property (nonatomic, copy, readwrite) NSString* imageUrl;
@property (nonatomic, copy, readwrite) NSString* itemPrice;
@property (nonatomic, copy, readwrite) NSString* itemWasPrice;
@property (nonatomic, readwrite) BOOL isNewItem;
@property (nonatomic, readwrite) BOOL hasWasPrice;
@property (nonatomic, readwrite) NSInteger itemsLeft;
@end

@implementation VSItemModel
- (instancetype)initWithImageURL:(NSString*)imageUrl
                      itemPrice:(NSString*)itemPrice
                      itemWasPrice:(NSString*)itemWasPrice
                      isNewItem:(BOOL)isNewItem
                      itemsLeft:(NSInteger)itemsLeft {
  if (self = [super init]) {
    _imageUrl = imageUrl;
    _itemPrice = itemPrice;
    _itemWasPrice = itemWasPrice;
    _isNewItem = isNewItem;
		_hasWasPrice = isNewItem;
    _itemsLeft = itemsLeft;
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
}
@end

