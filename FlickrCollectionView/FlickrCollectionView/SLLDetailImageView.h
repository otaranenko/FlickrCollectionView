//
//  SLLDetailImageView.h
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface SLLDetailImageView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UILabel *titleImage;

- (void)setImage:(UIImage *)image forTitle:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
