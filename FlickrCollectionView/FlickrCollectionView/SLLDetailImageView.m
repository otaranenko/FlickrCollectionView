//
//  SLLDetailImageView.m
//  FlickrCollectionView
//
//  Created by Oleg Taranenko on 20/04/2019.
//  Copyright © 2019 Oleg Taranenko. All rights reserved.
//

#import "SLLDetailImageView.h"

@interface SLLDetailImageView ()

@property (nonatomic, strong) UIImageView *detailImage;
@property (nonatomic, strong) UISlider *sliderFilter;
@property (nonatomic, strong) UISlider *sliderFilter2;
@property (nonatomic, strong) UIButton *buttonBackToMain;

@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *filterSepiaTone;
@property (nonatomic, strong) CIFilter *filterBlur;
@property (nonatomic, strong) CIImage *beginImage;

@end


@implementation SLLDetailImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        CGRect rectScreen = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, CGRectGetWidth(rectScreen)/2, CGRectGetWidth(rectScreen)/2);
        self.center = CGPointMake(CGRectGetWidth(rectScreen)/2, CGRectGetHeight(rectScreen)/2);
        
        _detailImage = [[UIImageView alloc] init];
        _detailImage.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) - 10*6);
        _detailImage.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 - 30);
        _detailImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_detailImage];
        
        _sliderFilter = [UISlider new];
        CGRect rectSliderFilter = CGRectMake(0, 0, CGRectGetWidth(self.frame), 10);
        _sliderFilter.frame = rectSliderFilter;
        _sliderFilter.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 10*5);
        _sliderFilter.minimumValue = 0;
        _sliderFilter.maximumValue = 1.0;
        _sliderFilter.continuous = NO;
        _sliderFilter.value = 0;;
        [_sliderFilter addTarget:self action:@selector(filterTypeSepiaTone) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_sliderFilter];
        
        _sliderFilter2 = [UISlider new];
        CGRect rectSliderFilter2 = CGRectMake(0, 0, CGRectGetWidth(self.frame), 10);
        _sliderFilter2.frame = rectSliderFilter2;
        _sliderFilter2.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 10*3);
        _sliderFilter2.minimumValue = 0;
        _sliderFilter2.maximumValue = 10;
        _sliderFilter2.continuous = NO;
        _sliderFilter2.value = 0;
        [_sliderFilter2 addTarget:self action:@selector(filterTypeBlur) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_sliderFilter2];
     
        CGRect rectButton = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, 10);
        _buttonBackToMain = [[UIButton alloc] initWithFrame:rectButton];
        _buttonBackToMain.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 10);
        [_buttonBackToMain setTitle:@"Закрыть" forState:UIControlStateNormal];
//        _buttonBackToMain.font = [UIFont italicSystemFontOfSize:9.0];
        [_buttonBackToMain.titleLabel setFrame:CGRectMake(0,0, 25, 10)];
        [_buttonBackToMain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonBackToMain.layer.cornerRadius = 10.0;
        [_buttonBackToMain addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonBackToMain];
        
    }
    return self;
}

- (void) backView
{
    [self removeFromSuperview];
}

- (void) resetState
{
    self.sliderFilter2.value = 0;
    self.sliderFilter.value = 0;
    [self backView];
}

- (void)setImage:(UIImage *)image forTitle:(NSString *)string
{
    self.detailImage.image = image;
    [self resetState];
    
    self.beginImage = [[CIImage alloc] initWithCGImage:self.detailImage.image.CGImage];
    self.context = [CIContext contextWithOptions:nil];
    self.filterSepiaTone = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, _beginImage, @"inputIntensity", @0.8, nil];
    self.filterBlur = [CIFilter filterWithName:@"CIDiscBlur" keysAndValues:kCIInputImageKey, _beginImage, @"inputRadius", @0.8, nil];
}


- (void) filterTypeSepiaTone
{
    [self.filterSepiaTone setValue:@(self.sliderFilter.value) forKey:@"inputIntensity"];
    CIImage *outputImage = [self.filterSepiaTone outputImage];
    
    CGImageRef cgimg = [self.context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.detailImage.image = newImage;

    CGImageRelease(cgimg);
}

- ( void) filterTypeBlur
{
    [self.filterBlur setValue:@(self.sliderFilter2.value) forKey:@"inputRadius"];
    CIImage *outputImage = [self.filterBlur outputImage];
    
    CGImageRef cgimg = [self.context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.detailImage.image = newImage;
    
   CGImageRelease(cgimg);
}

@end
