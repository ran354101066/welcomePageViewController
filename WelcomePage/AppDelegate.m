//
//  AppDelegate.m
//  WelcomePage
//
//  Created by wr on 15/8/4.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WelcomePageView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    
    //根据版本号加载
    NSString *versionNumber = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    NSString *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsShow"];
    if (isShow == nil || ![isShow isEqualToString:versionNumber]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:versionNumber forKey:@"IsShow"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        WelcomePageView * welcomeView = [[WelcomePageView alloc]initWithFrame:self.window.bounds];
        [self.window addSubview:welcomeView];
        
    }else
    {
        ViewController * vc = [[ViewController alloc]init];
        self.window.rootViewController = vc;
    }
    
    
    
    
    
    return YES;
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
