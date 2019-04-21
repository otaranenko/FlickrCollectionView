//
//  SLLMainInteractor.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 19/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLLNetworkServiceProtocol.h"
#import "SLLMainInteractorProtocol.h"



NS_ASSUME_NONNULL_BEGIN


@interface SLLMainInteractor : NSObject <SLLNetworkServiceOutputProtocol, SLLMainInteractorInputProtocol>

@property (nonatomic, weak, nullable) id<SLLNetworkServiceIntputProtocol> serviceHttp;
@property (nonatomic, weak, nullable) id<SLLMainInteractorOutputProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
