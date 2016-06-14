//
//  NXSlideCell.m
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/7.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import "NXSlideCell.h"
#import <Masonry/Masonry.h>
#import <YYWebImage/YYWebImage.h>

@interface NXSlideCell ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation NXSlideCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)configCellWithImageURL:(NSURL *)imageURL
              placeholderImage:(UIImage *)placeholderImage
                   contentMode:(UIViewContentMode)mode{
    self.imageView.contentMode = mode;
    [self.imageView yy_setImageWithURL:imageURL placeholder:placeholderImage options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - lazyload
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
