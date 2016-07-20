//
//  NXSlide.m
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/7/20.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import "NXSlide.h"

@implementation NXSlide

+ (instancetype)slideWithImageURL:(NSURL *)imageURL
                            image:(UIImage *)image
                            title:(NSAttributedString *)title{
    NXSlide *slide             = [[NXSlide alloc] init];
    slide.imageURL             = imageURL;
    slide.image                = image;
    slide.title                = title;
    slide.imageViewContentMode = UIViewContentModeScaleToFill;
    return slide;
}

@end
