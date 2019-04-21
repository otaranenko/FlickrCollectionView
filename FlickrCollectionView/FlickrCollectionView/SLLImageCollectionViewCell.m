//
//  ImageCollectionViewCell.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 19/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLImageCollectionViewCell.h"


@interface SLLImageCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation SLLImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setImageCell:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
}

@end
