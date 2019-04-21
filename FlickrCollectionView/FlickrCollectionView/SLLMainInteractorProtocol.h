//
//  SLLMainInteractorProtocol.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//


@protocol SLLMainInteractorOutputProtocol <NSObject>
@optional

- (void)loadingImageImageCount:(NSInteger)count;
- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;

@end


@protocol SLLMainInteractorInputProtocol <NSObject>
@optional

- (void)getImageWithString:(NSString *)searcSrting;

@end
