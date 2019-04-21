//
//  SLLNotificationService.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "SLLNotificationService.h"


@implementation SLLNotificationService

- (void)sheduleLocalNotification:(SLLTypeNotificationForUser)type
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUInteger timeRepeat = 0;
    NSString *stringSearch;
    if (type == SLLTypeCat)
    {
        stringSearch = @"cat";
        timeRepeat = 10;
    }
    if (type == SLLTypeDog)
    {
        stringSearch = @"dog";
        timeRepeat = 20;
    }
    
    
UNMutableNotificationContent *content = [UNMutableNotificationContent new];
content.title = @"Напоминание!";
content.body = [NSString stringWithFormat:@"Вы давно не искали >> %@ <<", stringSearch] ;
content.sound = [UNNotificationSound defaultSound];


[dict setObject:stringSearch forKey:@"search"];
content.userInfo = dict ;


//Добавляем кастомную категорию
content.categoryIdentifier = [NSString stringWithFormat:@"SBLReminderCategory%@", stringSearch];

//Создаем запрос на выполнение
NSString *identifier = [NSString stringWithFormat:@"NotificationID%@", stringSearch];
UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:[self intervalTrigger:timeRepeat]];



UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
[center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    if (error)
    {
        NSLog(@"Что то пошло не так... %@", error);
    }
}];
}


#pragma mark - Triggers

- (UNTimeIntervalNotificationTrigger *)intervalTrigger:(NSUInteger)time
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
}


@end
