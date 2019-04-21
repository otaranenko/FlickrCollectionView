//
//  SLLMainInteractor.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 19/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLMainInteractor.h"
#import "SLLNetworkServiceHTTP.h"


@interface SLLMainInteractor ()

@property (nonatomic, strong) NSArray<NSString *> *arrayUrls;

@end


@implementation SLLMainInteractor

- (void)getImageWithString:(NSString *)string
{
    [self.serviceHttp findPhotoWithSearchString:string];
}

- (void)loadingImageWithImageCount:(NSInteger)count
{
    NSLog(@"Iteractor working! - will download IMAGE count is %lu!!", count);
    [self.presenter loadingImageImageCount:count];
    
}

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    NSLog(@"Iteractor working! - complition download IMAGE!!");
    [self.presenter loadingIsDoneWithDataRecieved:dataRecieved];
}

@end
