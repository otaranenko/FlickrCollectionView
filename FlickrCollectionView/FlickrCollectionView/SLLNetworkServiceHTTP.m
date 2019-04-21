//
//  SLLNetworkServiceHTTP.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 18/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLNetworkServiceHTTP.h"

@interface SLLNetworkServiceHTTP () <NSURLSessionDownloadDelegate>

@property(nonatomic,strong) NSURLSessionDownloadTask *taskDownloadImage;
@property(nonatomic,strong) NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic,strong) NSURLSession *urlSession;
@property(nonatomic,strong) NSArray<NSString *> *listUrls;

@end


@implementation SLLNetworkServiceHTTP


- (void)findPhotoWithSearchString:(NSString *)searchSrting
{
    NSString *urlString = [self  urlForSearchString:searchSrting];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"Get list result search!");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *photosResultMap = [temp copy];
            self.listUrls = [self parseJsonToUrls:photosResultMap];
            [self.interactor loadingImageWithImageCount:self.listUrls.count];
            [self startDownloadImage:self.listUrls];
        });
    }];
    [sessionDataTask resume];
}


- (NSArray<NSString *> *)parseJsonToUrls: (NSDictionary *)jsonPhotos
{
    NSDictionary *photosContainer = jsonPhotos[@"photos"];
    NSDictionary *receivedPhotos = photosContainer[@"photo"];
    NSMutableArray *listPhotosUrls = [NSMutableArray new];
    
    for (NSDictionary *photoInfo in receivedPhotos)
    {
        [listPhotosUrls addObject:[self buildStringDownloadImage:photoInfo[@"farm"] andWithServer:photoInfo[@"server"] andWithPicture:photoInfo[@"id"] andWithSecret:photoInfo[@"secret"]]];
    }
    return [listPhotosUrls copy];
}

- (void) startDownloadImage:(NSArray<NSString *> *)listUrls
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSString *urlString in listUrls)
        {
            NSLog(@"URL = %@", urlString);
            self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
            self.urlSession = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:nil];
            self.taskDownloadImage = [self.urlSession downloadTaskWithURL:[NSURL URLWithString:urlString]];
            [self.taskDownloadImage resume];
        }
    });
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    NSData *dataWithImage = [NSData dataWithContentsOfURL:location];
    NSLog(@"Download Complition!");
    [self.interactor loadingIsDoneWithDataRecieved:dataWithImage];
}


#pragma mark -  Build String URL
- (NSString *)buildStringDownloadImage:(NSString *)idFarm andWithServer:(NSString *)serverId andWithPicture:(NSString *)pictureId andWithSecret:(NSString *)secret
{
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", idFarm, serverId, pictureId, secret];
}

- (NSString *)urlForSearchString:(NSString *)searchString
{
    NSString *key = @"fe3f851fb56c3916a4ef3aa6772c236b";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=24&format=json&nojsoncallback=1", key, searchString];
}

@end
