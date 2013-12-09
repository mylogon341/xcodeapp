//
//  AppDelegate.m
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "AppDelegate.h"
#import "Appirater.h"
#import "HomeViewController.h"
#import "MasterViewController.h"
#import "AboutViewController.h"
#import "PushWizard.h"
#import <MediaPlayer/MediaPlayer.h>
#warning Replace AppKey
static NSString *kAppKey =@"52a3b1f9a7cd2e926f00012c";


@implementation AppDelegate
@synthesize forceLandscapeRight;
@synthesize allowRotation;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Appirater setAppId:@"664870017"];
    
    self.allowRotation = NO;
    self.forceLandscapeRight = NO;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullscreenNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullscreenNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    // Override point for customization after application launch.
    
    UIViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    UIViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.aboutNav = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    masterViewController.tabBarItem.image = [UIImage imageNamed:@"game.png"];
    

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[homeVC, self.navigationController,self.aboutNav];
    self.window.rootViewController = self.tabBarController;
    
  
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightTextColor], UITextAttributeTextColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];

    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
        // Load resources for iOS 6.1 or earlier
        
    } else {
        
        
        
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, 320, 18);
        addStatusBar.backgroundColor = [UIColor darkGrayColor];
       // addStatusBar.
        //You can give your own color pattern
        [self.window.rootViewController.view addSubview:addStatusBar];
        
    
    
         UINavigationBar* navigationBar = self.navigationController.navigationBar;
          [navigationBar setBarTintColor:[UIColor blackColor]];

        
         UINavigationBar* aboutNavBar = self.aboutNav.navigationBar;
         [aboutNavBar setBarTintColor:[UIColor blackColor]];
        
     //   aboutNavBar.frame = CGRectOffset(aboutNavBar.frame, 0, 20);
        
        
         UITabBar * tBar = self.tabBarController.tabBar;
         [tBar setBarTintColor:[UIColor blackColor]];
        
        self.navigationController.navigationBar.alpha = 0.9;
        self.aboutNav.navigationBar.alpha= 0.9;
        self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
        self.aboutNav.navigationBar.tintColor = [UIColor lightGrayColor];
                
    }
    
    /////// tab bar colour /////
    
    
 
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor darkGrayColor]];
    [[UITabBar appearance] setAlpha:0.9];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }
                                             forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightTextColor] }
                                             forState:UIControlStateSelected];
    
    
    /////////////////////
    
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home.png"];

    aboutVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];

    [Appirater appLaunched:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
    
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    NSDictionary*payload=[launchOptions valueForKey :
                          UIApplicationLaunchOptionsRemoteNotificationKey];
    if(payload)
    {
        [self application:application didReceiveRemoteNotification:payload];
    }
    
    

}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
    {
        // You can send a custom NSArray with max 100 NSString values for later filtering
            [PushWizard startWithToken :deviceToken andAppKey : kAppKey andValues : nil];
    }

-(void)applicationDidBecomeActive:(UIApplication*)application
{
    [PushWizard updateSessionWithValues:nil];
    
    application.applicationIconBadgeNumber=0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
}


-(void)applicationDidEnterBackground:(UIApplication*)application
{
    [PushWizard endSession];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}



- (void) moviePlayerWillEnterFullscreenNotification:(NSNotification*)notification {
    self.allowRotation = YES;
}

- (void) moviePlayerWillExitFullscreenNotification:(NSNotification*)notification {
    self.allowRotation = NO;
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
 {
    if (self.forceLandscapeRight) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    
    return UIInterfaceOrientationMaskPortrait;
 }



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    [Appirater appEnteredForeground:YES];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
