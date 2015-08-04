//
//  WelcomePageView.m
//  carcareIOS
//
//  Created by wr on 15/7/29.
//  Copyright (c) 2015年 baozun. All rights reserved.
//

#import "WelcomePageView.h"

#define __MAIN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)
#define __MAIN_RATIO_375      (([[UIScreen mainScreen] bounds].size.width)/375)
#define __MAIN_RATIO_H_667      (([[UIScreen mainScreen] bounds].size.height)/667)

@interface WelcomePageView()

@property (nonatomic , strong) UIScrollView * bodyScrollView;

@property (nonatomic , strong) UIPageControl * numPageControl;

//图片个数
@property (nonatomic , assign) NSInteger imageCountNum;


@end
@implementation WelcomePageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * welcomeBackImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcomeBackImage"]];
        welcomeBackImageV.frame = self.bounds;
        [self addSubview:welcomeBackImageV];
        self.imageCountNum = 4;
        [self createScrollView];
        [self createPageControl];
        [self.bodyScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.numPageControl.currentPage = self.bodyScrollView.contentOffset.x / __MAIN_WIDTH;

    [self.numPageControl setHidden:(self.numPageControl.currentPage + 1 == self.imageCountNum  ? YES : NO)];
}
- (void)createPageControl
{
    self.numPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 20)];
    self.numPageControl.backgroundColor = [UIColor clearColor];
    self.numPageControl.numberOfPages = self.imageCountNum;
    self.numPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.numPageControl];
}

- (void)createScrollView
{
    self.bodyScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.bodyScrollView.backgroundColor = [UIColor clearColor];
    self.bodyScrollView.pagingEnabled = YES;
    self.bodyScrollView.showsHorizontalScrollIndicator = NO;
    self.bodyScrollView.showsVerticalScrollIndicator = NO;
    [self.bodyScrollView setContentSize:CGSizeMake(self.frame.size.width * _imageCountNum, self.frame.size.height)];
    [self addSubview:self.bodyScrollView];
    for (int index = 0 ; index < _imageCountNum; index ++) {
        
        CGFloat bodyImageViewX = 83 * __MAIN_RATIO_375;
        CGFloat bodyImageViewW = self.bodyScrollView.frame.size.width - bodyImageViewX * 2;
        CGFloat bodyImageViewY = 124 * __MAIN_RATIO_H_667;
        CGFloat bodyImageViewH = self.bodyScrollView.frame.size.height - bodyImageViewY * 2;
        UIImageView * bodyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(bodyImageViewX + self.bodyScrollView.frame.size.width * index  , bodyImageViewY, bodyImageViewW, bodyImageViewH)];
        bodyImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcomeImage%d",index + 1]];
        bodyImageView.backgroundColor = [UIColor clearColor];
        bodyImageView.tag = index + 50;
        [self.bodyScrollView addSubview:bodyImageView];

        UIImage * textImage = [UIImage imageNamed:[NSString stringWithFormat:@"welcomeTextImage%d",index + 1]];
        
        UIImageView * textImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, textImage.size.width * __MAIN_RATIO_375,textImage.size.height * __MAIN_RATIO_375)];
        [textImageView setCenter:CGPointMake(self.bodyScrollView.frame.size.width / 2 + self.frame.size.width  * index, self.bodyScrollView.frame.size.height - 118 * __MAIN_RATIO_H_667)];
        textImageView.image = textImage;
        [textImageView setCenter: CGPointMake(self.bodyScrollView.frame.size.width / 2 + self.frame.size.width  * index, self.bodyScrollView.frame.size.height - 118 * __MAIN_RATIO_H_667)];
        [self.bodyScrollView addSubview:textImageView];
        
        if (index == _imageCountNum - 1) {
            CGFloat removeButtonXX = 100;
            CGFloat removeButtonX = removeButtonXX + self.frame.size.width * index;
            CGFloat removeButtonH = 44 * __MAIN_RATIO_375;
            CGFloat removeButtonW = self.bodyScrollView.frame.size.width - removeButtonXX * 2;
            CGFloat removeButtonY = textImageView.frame.origin.y + textImageView.frame.size.height + (self.bodyScrollView.frame.size.height - textImageView.frame.origin.y - textImageView.frame.size.height - removeButtonH) / 2;
            
            UIButton * removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [removeButton setFrame:CGRectMake(removeButtonX, removeButtonY, removeButtonW, removeButtonH)];
            removeButton.backgroundColor = [UIColor clearColor];
            [removeButton setTitle:@"开启3.0之旅" forState:UIControlStateNormal];
            [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [removeButton addTarget:self action:@selector(removeButtonClick) forControlEvents:UIControlEventTouchUpInside];
            removeButton.titleLabel.font = [UIFont systemFontOfSize:14];
            removeButton.layer.cornerRadius = 5;
            removeButton.layer.borderColor = [UIColor whiteColor].CGColor;
            removeButton.layer.borderWidth = 0.5;
            [self.bodyScrollView addSubview:removeButton];
        }
    }
    
}
- (void)removeButtonClick
{
    __weak __typeof(self)wself = self;
    [UIView animateWithDuration:0.8 animations:^{
        wself.alpha = 0;
    } completion:^(BOOL finished) {
        [wself.bodyScrollView removeObserver:self forKeyPath:@"contentOffset"];
        [wself removeFromSuperview];
    }];
}
@end
