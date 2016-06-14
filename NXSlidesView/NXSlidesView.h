//
//  NXSlidesView.h
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/6.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NXSlidesView;

typedef void(^DidSelectItemBlock)(NXSlidesView *slidesView, NSArray *imageURLs, NSInteger index);

@interface NXSlidesView : UIView

/** 需要展示的图片列表 */
@property (copy  , nonatomic, readonly) NSArray            *imageURLs;

/** 弹性动画 */
@property (assign, nonatomic          ) BOOL               bounces;

/** 占位图 */
@property (strong, nonatomic, readonly) UIImage            *placeholderImage;

/** 自动滚动间隔时间,默认3s */
@property (assign, nonatomic          ) CGFloat            autoScrollTimeInterval;

/** 是否显示分页控件 */
@property (assign, nonatomic          ) BOOL               showPageControl;

///** 是否无限循环,默认Yes */
@property (assign, nonatomic          ) BOOL               infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (assign, nonatomic          ) BOOL               autoScroll;

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (assign, nonatomic          ) UIViewContentMode  bannerImageViewContentMode;

/** 轮播图点击后的回调 */
@property (copy, nonatomic            ) DidSelectItemBlock didSelectItemBlock;


/**
 *  初始化方法
 *
 *  @param imageURLs        图片的URL地址
 *  @param placeholderImage 占位图
 *  @param autoScroll       是否自动滚动
 *  @param infiniteLoop     是否无限循环
 *  @param block            点击图片后的回调
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                    ImageURLs:(NSArray <NSURL *>*)imageURLs
             placeholderImage:(UIImage *)placeholderImage
                   autoScroll:(BOOL)autoScroll
                 infiniteLoop:(BOOL)infiniteLoop
           didSelectItemBlock:(DidSelectItemBlock)block;

/**
 *  更新图片信息
 *
 *  @param imageURLs        图片的URL地址
 *  @param placeholderImage 占位图
 */
- (void)updateImageURLs:(NSArray <NSURL *>*)imageURLs
       placeholderImage:(UIImage *)placeholderImage;


/**
 *  重载
 */
- (void)reload;


@end
