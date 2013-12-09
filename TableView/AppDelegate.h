//
//  AppDelegate.h
//  TableView
//
//  Created by James Miller on 21/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UIToolbarDelegate,UIBarPositioningDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UINavigationController *aboutNav;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationBar *navBar;

@property(nonatomic, retain) UIStatusBar *statBar;

@property(nonatomic, retain) UIColor *tintColor;
@property (nonatomic) BOOL allowRotation;
@property (nonatomic) BOOL forceLandscapeRight;


@end
