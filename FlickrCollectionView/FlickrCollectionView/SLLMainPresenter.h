//
//  SLLMainPresenter.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 19/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLLMainPresenterProtocol.h"
#import "SLLMainInteractorProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface SLLMainPresenter : NSObject <SLLMainPresenterInputProtocol , SLLMainInteractorOutputProtocol>

@property (nonatomic, weak, nullable) id<SLLMainPresenterOutputProtocol> viewOutput;
@property (nonatomic, weak, nullable) id<SLLMainInteractorInputProtocol> iteractor;

@end

NS_ASSUME_NONNULL_END
