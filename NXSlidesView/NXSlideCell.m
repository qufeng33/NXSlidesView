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

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel     *titleLabel;
@property (weak, nonatomic) UIView      *titlebackgroundView;

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
    UIImageView *imageView                = [[UIImageView alloc] init];
    self.imageView                        = imageView;
    self.imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    UIView *titlebackgroundView              = [[UIView alloc] init];
    self.titlebackgroundView                 = titlebackgroundView;
    self.titlebackgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self.imageView addSubview:titlebackgroundView];
    [titlebackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.imageView);
    }];

    UILabel *titleLabel           = [[UILabel alloc] init];
    self.titleLabel               = titleLabel;
    self.titleLabel.font          = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.titleLabel.textColor     = [UIColor whiteColor];
    [titlebackgroundView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titlebackgroundView).with.insets(UIEdgeInsetsMake(6, 6, 6, 6));
    }];
}

- (void)configCellWithImageURL:(NSURL *)imageURL
              placeholderImage:(UIImage *)placeholderImage
                   contentMode:(UIViewContentMode)mode
                         title:(NSString *)title{
    self.imageView.contentMode = mode;
    [self.imageView yy_setImageWithURL:imageURL placeholder:placeholderImage options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    self.titlebackgroundView.hidden = title?NO:YES;
    self.titleLabel.hidden = title?NO:YES;
    self.titleLabel.text = title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
