//
//  SLLNetworkServiceHTTP.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 18/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLLNetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface SLLNetworkServiceHTTP : NSObject <SLLNetworkServiceIntputProtocol>

@property (nonatomic, weak, nullable) id<SLLNetworkServiceOutputProtocol> interactor;

@end

NS_ASSUME_NONNULL_END
