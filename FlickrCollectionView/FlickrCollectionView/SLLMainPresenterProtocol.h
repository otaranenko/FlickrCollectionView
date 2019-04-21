//
//  SLLMainPresenterProtocol.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

@protocol SLLMainPresenterOutputProtocol <NSObject>
@optional

- (void)loadingImageWithImageCount:(NSInteger)count;
- (void)needSearchForString:(NSString *)string;
- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;

@end


@protocol SLLMainPresenterInputProtocol <NSObject>
@optional

- (void) getImageWithString:(NSString *)stringSearch;
- (void) showViewDetailImage:(NSString *)stringId;

@end
