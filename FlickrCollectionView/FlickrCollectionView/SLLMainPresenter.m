//
//  SLLMainPresenter.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 19/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLMainPresenter.h"
#import "SLLMainPresenterProtocol.h"


@implementation SLLMainPresenter

- (void) getImageWithString:(NSString *)stringSearch
{
    [self.iteractor getImageWithString:stringSearch];
}

- (void) showViewDetailImage:(NSString *)stringId {
    // GOTO ROUTE
}


#pragma mark -  SLLMainInteractorOutputProtocol

- (void)loadingImageImageCount:(NSInteger)count {
    NSLog(@"LOAD IMAGE %lu", count);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewOutput loadingImageWithImageCount:count];
    });
    
}

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewOutput loadingIsDoneWithDataRecieved:dataRecieved];
    });
}

@end
