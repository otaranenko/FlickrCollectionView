//
//  SLLMainAssambly.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLMainAssambly.h"

#import "SLLNetworkServiceHTTP.h"
#import "SLLMainInteractor.h"
#import "SLLMainPresenter.h"
#import "SLLViewController.h"


@implementation SLLMainAssambly

+ (SLLMainAssambly *) assemblyMainScreen:(SLLViewController *)view
{
    SLLMainAssambly *assembly = [SLLMainAssambly new];
    
    assembly.serviceNetwork = [SLLNetworkServiceHTTP new];
    assembly.mainIteractor = [SLLMainInteractor new];
    assembly.mainPresenter = [SLLMainPresenter new];

    assembly.serviceNetwork.interactor = assembly.mainIteractor;
    
    assembly.mainIteractor.serviceHttp = assembly.serviceNetwork;
    assembly.mainIteractor.presenter = assembly.mainPresenter;
    
    assembly.mainPresenter.iteractor = assembly.mainIteractor;
    assembly.mainPresenter.viewOutput = view;
    
    view.presenter = assembly.mainPresenter;
    
    
    return assembly;
}

@end
