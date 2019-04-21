//
//  SLLMainAssambly.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLLNetworkServiceHTTP;
@class SLLNotificationService;
@class SLLMainInteractor;
@class SLLMainPresenter;
@class SLLViewController;

NS_ASSUME_NONNULL_BEGIN


@interface SLLMainAssambly : NSObject

@property (nonatomic, strong) SLLNetworkServiceHTTP *serviceNetwork;
@property (nonatomic, strong) SLLMainInteractor *mainIteractor;
@property (nonatomic, strong) SLLMainPresenter *mainPresenter;

+ (SLLMainAssambly *) assemblyMainScreen:(SLLViewController *)view;

@end

NS_ASSUME_NONNULL_END
