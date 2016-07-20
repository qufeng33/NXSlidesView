//
//  NXSlideCell.h
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/7.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXSlideCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel     *titleLabel;
@property (weak, nonatomic) UIView      *titlebackgroundView;

+ (NSString *)cellIdentifier;

@end
