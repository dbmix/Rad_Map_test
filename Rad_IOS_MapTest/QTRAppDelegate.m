//
//  QTRAppDelegate.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//



#import "QTRAppDelegate.h"

    //#ifdef IS_IOS
#import "QTRViewController.h"
    //#endif

    //#ifdef IS_OSX
    //#import "QTROSXViewController.h"
    //#endif

@implementation QTRAppDelegate


#ifdef IS_OSX
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
        // Insert code here to initialize your application
        //NSLog(@"target is %@",[[[NSProcessInfo processInfo] environment] objectForKey:@"TARGET"]);

    [self.window setFrame:NSRectFromCGRect(CGRectMake(300, 300, 1000, 1000)) display:YES];
    NSRect windoh = self.window.frame;
    self.QTRMapController = [[QTRViewController alloc] initWithNibName:nil bundle:nil windowFrame:windoh];
    [self.window.contentView addSubview:self.QTRMapController.view];
    NSDictionary *views = @{@"contentView": self.window.contentView, @"mapView": self.QTRMapController.view};
    [self.QTRMapController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[mapView]-5-|" options:0 metrics:nil views:views];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[mapView]-5-|" options:0 metrics:nil views:views]];
    [self.window.contentView addConstraints:constraints];
    self.window.delegate = self.QTRMapController;
    
}
#endif

#ifdef IS_IOS

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NSLog(@"target is %@",[[[NSProcessInfo processInfo] environment] objectForKey:@"TARGET"]);
        // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.QTRMapController = [[QTRViewController alloc] init];
    self.window.rootViewController = self.QTRMapController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#endif

@end
