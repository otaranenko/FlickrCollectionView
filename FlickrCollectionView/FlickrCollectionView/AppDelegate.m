//
//  AppDelegate.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 15/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "AppDelegate.h"
#import "SLLViewController.h"
#import "SLLMainPresenterProtocol.h"
#import "SLLNotificationService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    SLLViewController *controller = [SLLViewController new];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    [self addNotificationCenter];
    return YES;
}


-(void)addNotificationCenter
{
    UNUserNotificationCenter *center =[UNUserNotificationCenter currentNotificationCenter];
    
    //Устанавливаем делегат
    center.delegate = self;
    
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted)
        {
            NSLog(@"Доступ не дали");
        }
        else
        {
            NSLog(@"Доступ есть");
        }
    }];
}

#pragma mark - User Notification Center Delegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"search"])
    {
        NSString *stringInfo = content.userInfo[@"search"];
        id<SLLMainPresenterOutputProtocol>view =  (SLLViewController*)self.window.rootViewController;
        [view needSearchForString:stringInfo];
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    SLLNotificationService *serviceNotification = [SLLNotificationService new];
    [serviceNotification sheduleLocalNotification:SLLTypeCat];
    [serviceNotification sheduleLocalNotification:SLLTypeDog];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
