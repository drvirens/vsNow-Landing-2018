//
//  VSDataMgr.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 7/16/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSDataMgr.h"

@interface VSDataMgr ()
@property (nonatomic) NSMutableArray<NSMutableArray<VSItemModel*>*>* dataArray;
@end

@implementation VSDataMgr
- (instancetype)init {
	if (self = [super init]) {
		[self populateDataArray];
	}
	return self;
}

- (BOOL)isValidCategory:(NSInteger)tag {
	BOOL ret = (tag >= VSCategoryType_Begin) &&
				(tag < VSCategoryType_End);
	return ret;
}

- (BOOL)isPagerCell:(NSInteger)tag {
	BOOL ret = tag == 0;
	return ret;
}

- (NSInteger)totalItemsInCategory:(NSInteger)tag {
	NSInteger index = tag - VSCategoryType_Begin;
	NSInteger ret = 2;
	switch (tag) {
  case 69:
    ret = self.dataArray[index].count;
    break;
  case 70:
    ret = self.dataArray[index].count;
    break;
  case 71:
    ret = self.dataArray[index].count;
    break;
  default:
		ret = self.dataArray[index].count;
    break;
	}
	return ret;
}

- (VSItemModel*)getItemAtIndex:(NSInteger)index category:(NSInteger)category {
	VSItemModel* model = nil;
	NSInteger categoryIndex = category - VSCategoryType_Begin;
	model = self.dataArray[categoryIndex][index];
	return model;
}

- (void)populateDataArray {
	self.dataArray = [NSMutableArray array];
	
	[self addCategory:69];
	[self addCategory:70];
	[self addCategory:71];
	[self addCategory:72];
	[self addCategory:73];
	[self addCategory:74];
	[self addCategory:75];
	[self addCategory:76];
}

- (void)addCategory:(NSInteger)category {
	if (category == 69) {
		[self addCategory69];
	}
	if (category == 70) {
		[self addCategory70];
	}
	if (category == 71) {
		[self addCategory71];
	}
	if (category == 72) {
		[self addCategory72];
	}
	if (category == 73) {
		[self addCategory73];
	}
	if (category == 74) {
		[self addCategory74];
	}
	if (category == 75) {
		[self addCategory75];
	}
	if (category == 76) {
		[self addCategory76];
	}
}

- (void)addCategory69 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sku_195333_1_small.jpg"
				itemPrice:@"$9.76" itemWasPrice:@"$35.89" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_398622_1_small.jpg"
				itemPrice:@"$30.14" itemWasPrice:@"$31.31" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_416602_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_152345_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_188954_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_378701_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_385371_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_398552_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_406105_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_413349_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_396047_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_417673_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_436380_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory70 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sku_269042_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_318558_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_336529_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_339464_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_44134_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_339592_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_346396_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	model = [[VSItemModel alloc] initWithImageURL:@"sku_346700_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_362719_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_339466_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_46898_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_48755_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_82148_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	model = [[VSItemModel alloc] initWithImageURL:@"sku_108134_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_110355_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_331592_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_332050_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_300552_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_339438_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory71 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sku_160494_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_179593_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_245083_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_381336_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_390748_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_392713_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_393315_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_413681_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_415426_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_415431_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_418645_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_422521_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_426464_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_426471_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_426476_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_426491_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_426532_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_426686_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_437356_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_438391_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_440179_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory72 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sku_186465_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_220815_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_222540_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_247301_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_250382_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_260021_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_260224_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_304950_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_396136_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_399029_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_220815_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_222540_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_247301_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_250382_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sku_260021_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_260224_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_304950_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_396136_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sku_399029_1_small.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:NO itemsLeft:10];
	[dataarray addObject:model];
	
}

- (void)addCategory73 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory74 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory75 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
}

- (void)addCategory76 {
	NSMutableArray<VSItemModel*>* dataarray = [NSMutableArray array];
	[self.dataArray addObject:dataarray];
	
	VSItemModel* model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];
	
	model = [[VSItemModel alloc] initWithImageURL:@"sample_item_2_200x200.jpg"
				itemPrice:@"$69" itemWasPrice:@"$78" isNewItem:YES itemsLeft:10];
	[dataarray addObject:model];

}

@end
