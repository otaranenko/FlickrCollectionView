//
//  SLLNotificationServiceProtocol.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//


/**
 Перечисление типа PushNotification

 - SLLTypeCat: Тип уведомления с Котами
 - SLLTypeDog: Тип уведомления с собаками
 */
typedef NS_ENUM(NSInteger, SLLTypeNotificationForUser){
    SLLTypeCat = 0,
    SLLTypeDog = 1,
};

@protocol SLLNotificationInputProtocol <NSObject>
@optional

/**
 Запустить нотификацию в зависимости от типа

 @param type тип нотификации
 */
- (void)sheduleLocalNotification:(SLLTypeNotificationForUser)type;


@end
