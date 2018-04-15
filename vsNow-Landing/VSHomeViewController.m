//
//  VSHomeViewController.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/26/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "VSHomeViewController.h"

@interface VSHomeViewController ()

@end

@implementation VSHomeViewController

+ (UIViewController*)viewController {
	VSHomeViewController* vc = [[VSHomeViewController alloc] init];
	return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
		self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
