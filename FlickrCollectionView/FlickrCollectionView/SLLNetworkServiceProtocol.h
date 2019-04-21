//
//  NetworkServiceProtocol.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 18/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//


@protocol SLLNetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingImageWithImageCount:(NSInteger)count;
- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;

@end


@protocol SLLNetworkServiceIntputProtocol <NSObject>
@optional

- (void)findPhotoWithSearchString:(NSString *)searcSrting;
- (void)startDownloadImage:(NSArray<NSString *>*)listUrls;

@end
