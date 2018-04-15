//
//  AppDelegate.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/6/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import "AppDelegate.h"
#import "VSLandingViewController.h"
#import "VSMeViewController.h"
#import "VSChatsViewController.h"
#import "UIColor+Branding.h"
#import "VSHomeViewController.h" //actual
#import "VSLandingTheme.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self performBranding];
	//VSLandingViewController* vc = [[VSLandingViewController alloc] init];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	UIViewController* rootVC = nil;
	rootVC = [self createTabBarVC];
	
	[self.window setRootViewController:rootVC];
	//self.window.tintColor = [UIColor vs_BrandColor];
	
	[self.window makeKeyAndVisible];
	return YES;
}

- (UIViewController*)createTabBarVC {
#if 0
	UIViewController* tabLanding = [VSLandingViewController viewController];
	//UIViewController* tabChats = [VSChatsViewController viewController];
  UIViewController* tabChats = [ViewController new];
	UIViewController* tabMe = [VSMeViewController viewController];
	
	UITabBarController* tabvc = [[UITabBarController alloc] init];
	tabvc.viewControllers = @[tabLanding, tabChats, tabMe];
	return tabvc;
#endif
	UIViewController* homevc = [VSLandingViewController viewController];
	return homevc;
}

- (void)performBranding {
	
	[[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setShadowImage:[UIImage new]];
	[[UINavigationBar appearance] setTranslucent:NO];
	[[UINavigationBar appearance] setBarTintColor:[VSLandingTheme veryLightGrayColor]];
	
//	NSShadow* shadow = [NSShadow new];
//	shadow.shadowOffset = CGSizeMake(0, 2);
//	shadow.shadowColor = [UIColor redColor];
	
	[[UINavigationBar appearance] setTitleTextAttributes:@{
		NSForegroundColorAttributeName : [VSLandingTheme redColorInnerColor],
//		NSShadowAttributeName : shadow
	}];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
