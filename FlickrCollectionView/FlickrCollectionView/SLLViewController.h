//
//  SLLViewController.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 15/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLMainPresenterProtocol.h"


@interface SLLViewController : UIViewController <SLLMainPresenterOutputProtocol>

@property (nonatomic, weak, nullable) id<SLLMainPresenterInputProtocol> presenter;

@end

