//
//  SLLViewController.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 15/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLViewController.h"
#import "SLLImageCollectionViewCell.h"
#import "SLLDetailImageView.h"
#import "SLLMainAssambly.h"


static const CGFloat heightSearch = 60.f;
static const CGFloat marginTop = 30.f;


@interface SLLViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger numberOfItem;
@property (nonatomic, strong) SLLMainAssambly *ass;
@property (nonatomic, strong) NSArray<UIImage*> *images;
@property (nonatomic, strong) SLLDetailImageView *detail;

@end


@implementation SLLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ass = [SLLMainAssambly assemblyMainScreen:self];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rectSearchBar = CGRectMake(0, marginTop, CGRectGetWidth(self.view.frame), heightSearch);
    self.searchBar = [[UISearchBar alloc] initWithFrame:rectSearchBar];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    CGRect rectFlowLayout = CGRectMake(0, marginTop+heightSearch, CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.view.frame) - marginTop - heightSearch);
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:rectFlowLayout collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[SLLImageCollectionViewCell class] forCellWithReuseIdentifier:@"SLLImageCell"];
    
    self.detail = [SLLDetailImageView new];
}


#pragma mark -  UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.presenter getImageWithString:searchBar.text];
    self.images = [NSMutableArray new];
}


#pragma mark -  UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SLLImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SLLImageCell" forIndexPath:indexPath];
    if (cell)
    {
        [cell setImageCell: self.images[indexPath.row]];
        return cell;
    }
    return [UICollectionViewCell new];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfItem;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.frame)/2 - 10, CGRectGetWidth(self.view.frame)/2 - 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.detail setImage:self.images[indexPath.row] forTitle:@"TEST"];
    [self.view addSubview:self.detail];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.detail.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.detail.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.9, 1.9);
        } completion:^(BOOL finished) {
        }];
    }];
}


#pragma mark -  SLLMainPresenterOutputProtocol

- (void)loadingImageWithImageCount:(NSInteger)count
{
    self.numberOfItem = count;
}

- (void)needSearchForString:(NSString *)string
{
    self.searchBar.text = string;
    [self.detail removeFromSuperview];
    [self searchBarSearchButtonClicked:self.searchBar];
    
}

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    NSMutableArray *mutableImages = [NSMutableArray arrayWithArray:self.images];
    [mutableImages addObject:[UIImage imageWithData:dataRecieved]];
    self.images = [mutableImages copy];
    if (self.images.count >= self.numberOfItem)
    {
        [self.collectionView reloadData];
    }
}
@end
