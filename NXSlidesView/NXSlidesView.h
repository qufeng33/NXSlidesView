//
//  NXSlidesView.h
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/6.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXSlide.h"

@class NXSlidesView;

typedef void(^DidSelectItemBlock)(NXSlidesView *slidesView, NSInteger index);

@interface NXSlidesView : UIView

/** 需要展示的幻灯片列表 */
@property (copy  , nonatomic, readonly) NSArray            *slides;

/** 弹性动画 */
@property (assign, nonatomic          ) BOOL               bounces;

/** 占位图 */
@property (strong, nonatomic          ) UIImage            *placeholderImage;

/** 自动滚动间隔时间,默认3s */
@property (assign, nonatomic          ) CGFloat            autoScrollTimeInterval;

/** 是否显示分页控件 */
@property (assign, nonatomic          ) BOOL               showPageControl;

///** 是否无限循环,默认Yes */
@property (assign, nonatomic          ) BOOL               infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (assign, nonatomic          ) BOOL               autoScroll;

/** 轮播图点击后的回调 */
@property (copy, nonatomic            ) DidSelectItemBlock didSelectItemBlock;


/**
 *  初始化方法
 *
 *  @param slides           需要展示的幻灯片
 *  @param placeholderImage 占位图
 *  @param autoScroll       是否自动滚动
 *  @param infiniteLoop     是否无限循环
 *  @param block            点击图片后的回调
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                    slides:(NSArray <NXSlide *>*)slides
             placeholderImage:(UIImage *)placeholderImage
                   autoScroll:(BOOL)autoScroll
                 infiniteLoop:(BOOL)infiniteLoop
           didSelectItemBlock:(DidSelectItemBlock)block;

/**
 *  更新幻灯片
 *
 *  @param imageURLs        图片的URL地址
 */
- (void)updateSlides:(NSArray <NXSlide *>*)slides;

/**
 *  重载
 */
- (void)reload;


@end
