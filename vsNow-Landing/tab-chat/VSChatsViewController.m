//
//  VSChatsViewController.m
//  ssi
//
//  Created by Virendra Shakya on 5/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSChatsViewController.h"

@interface VSChatsViewController ()

@end

@implementation VSChatsViewController

+ (UIViewController*)viewController {
	VSChatsViewController* chatsVC = [[VSChatsViewController alloc] init];
	UINavigationController* navvc = [[UINavigationController alloc] initWithRootViewController:chatsVC];
	return navvc;
}

-(instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
			self.title = @"Chat";
			self.tabBarItem.image = [self tabBarIcon];
    }
    return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
}

- (UIImage*)tabBarIcon {
	UIImage* img = [UIImage imageNamed:@"tab-chat"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return img;
}


@end
