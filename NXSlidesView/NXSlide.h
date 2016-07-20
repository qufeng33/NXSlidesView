//
//  NXSlide.h
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/7/20.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NXSlide : NSObject

/** 图片的URL地址  */
@property (strong, nonatomic) NSURL              *imageURL;

/** 需要展示的图片  */
@property (strong, nonatomic) UIImage            *image;

/** 需要显示的文字  */
@property (strong, nonatomic) NSAttributedString *title;

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (assign, nonatomic) UIViewContentMode  imageViewContentMode;

+ (instancetype)slideWithImageURL:(NSURL *)imageURL
                            image:(UIImage *)image
                            title:(NSAttributedString *)title;

@end
