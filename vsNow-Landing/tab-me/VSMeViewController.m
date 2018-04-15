//
//  VSMeViewController.m
//  ssi
//
//  Created by Virendra Shakya on 5/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSMeViewController.h"

@interface VSMeViewController ()

@end

@implementation VSMeViewController

+ (UIViewController*)viewController {
	VSMeViewController* meVC = [[VSMeViewController alloc] init];
	UINavigationController* navvc = [[UINavigationController alloc] initWithRootViewController:meVC];
	return navvc;
}

-(instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
			self.title = @"Me";
			self.tabBarItem.image = [self tabBarIcon];
    }
    return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
}

- (UIImage*)tabBarIcon {
	UIImage* img = [UIImage imageNamed:@"tab-user"];
	img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return img;
}


@end
