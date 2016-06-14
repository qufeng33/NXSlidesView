//
//  NXSlidesView.m
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/6.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import "NXSlidesView.h"
#import <Masonry/Masonry.h>
#import "NXSlideCell.h"

@interface NXSlidesView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak  , nonatomic) UICollectionView *mainView;
@property (weak  , nonatomic) UIPageControl    *pageControl;
@property (strong, nonatomic) NSArray          *items;
@property (weak  , nonatomic) NSTimer          *timer;
@property (assign, nonatomic) BOOL             loaded;

@end

@implementation NXSlidesView

- (instancetype)initWithFrame:(CGRect)frame
                    ImageURLs:(NSArray<NSURL *> *)imageURLs
             placeholderImage:(UIImage *)placeholderImage
                   autoScroll:(BOOL)autoScroll
                 infiniteLoop:(BOOL)infiniteLoop
                didSelectItemBlock:(DidSelectItemBlock)block{
    self = [self initWithFrame:frame];
    if (self) {
        self.autoScroll         = autoScroll;
        self.infiniteLoop       = infiniteLoop;
        self.didSelectItemBlock = block;
        _imageURLs              = imageURLs;
        _placeholderImage       = placeholderImage;
        [self reload];
    }
    return self;
}

- (void)awakeFromNib{
    [self defaultSetting];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (void)dealloc{
    self.mainView.dataSource = nil;
    self.mainView.delegate   = nil;
}

- (void)defaultSetting{
    self.autoScrollTimeInterval = 3;
    self.bounces                = YES;
    self.showPageControl        = YES;
    self.autoScroll             = NO;
    self.infiniteLoop           = NO;
    self.contentMode            = UIViewContentModeScaleToFill;
    self.backgroundColor        = [UIColor whiteColor];
}

#pragma mark - setupUI
- (void)setupMainView{
    if (self.mainView) {
        self.mainView.delegate = nil;
        self.mainView.dataSource = nil;
        [self.mainView removeFromSuperview];
    }
    
    UICollectionViewFlowLayout *flowLayout        = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing                 = 0;
    flowLayout.scrollDirection                    = UICollectionViewScrollDirectionHorizontal;

    UICollectionView *collectionView              = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor                = [UIColor clearColor];
    collectionView.pagingEnabled                  = YES;
    collectionView.scrollEnabled                  = self.imageURLs.count > 1;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator   = NO;
    [collectionView registerClass:[NXSlideCell class] forCellWithReuseIdentifier:[NXSlideCell cellIdentifier]];
    collectionView.dataSource                     = self;
    collectionView.delegate                       = self;
    collectionView.autoresizingMask               = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:collectionView];
    
    self.mainView = collectionView;
}

- (void)setupPageControl{
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    
    UIPageControl *pageControl         = [[UIPageControl alloc] init];
    pageControl.numberOfPages          = self.imageURLs.count;
    pageControl.currentPage            = 0;
    pageControl.hidesForSinglePage     = YES;
    pageControl.userInteractionEnabled = NO;
    [pageControl sizeToFit];
    [self addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainView);
        make.bottom.equalTo(self.mainView);
    }];
    self.pageControl = pageControl;
}

- (void)setupTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.autoScroll && self.items.count > 1) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(showNextSlides) userInfo:nil repeats:YES];
        self.timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - IBAction
- (void)showNextSlides{
    if (self.imageURLs.count < 2) {
        return;
    }
    
    NSIndexPath *indexPath = [[self.mainView indexPathsForVisibleItems] lastObject];
    NSInteger currentIndex = indexPath.item;
    NSInteger toIndex = currentIndex + 1;
    if (currentIndex == self.items.count - 2) {
        toIndex = 1;
    }
    
    indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
    [self.mainView scrollToItemAtIndexPath:indexPath
                          atScrollPosition:UICollectionViewScrollPositionLeft
                                  animated:YES];
    
    self.pageControl.currentPage = toIndex - 1;
}

- (void)updateImageURLs:(NSArray<NSURL *> *)imageURLs placeholderImage:(UIImage *)placeholderImage{
    _imageURLs = imageURLs;
    _placeholderImage = placeholderImage;
    [self reload];
}

- (void)reload{
    self.items = [self resetDatasouce:self.imageURLs];
    
    [self setupMainView];
    [self setupPageControl];
    [self setupTimer];

    if (self.imageURLs.count > 1) {
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)resetPosition{
    NSIndexPath *indexPath = [[self.mainView indexPathsForVisibleItems] lastObject];
    NSInteger currentIndex = indexPath.item;
    NSInteger toItem = 0;
    if (currentIndex == 0) {
        toItem = self.items.count - 2;
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toItem inSection:0]
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:NO];
        currentIndex = toItem;
    }else if (currentIndex == self.items.count - 1) {
        toItem = 1;
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toItem inSection:0]
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:NO];
        currentIndex = toItem;
    }
    
    self.pageControl.currentPage = currentIndex - 1;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [(UICollectionViewFlowLayout *)self.mainView.collectionViewLayout setItemSize:self.bounds.size];
    self.pageControl.hidden = !(self.showPageControl && self.imageURLs.count > 1);
    if (!self.loaded && self.imageURLs.count > 1) {
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.loaded = YES;
    }else{
        NSIndexPath *indexPath = [self.mainView indexPathsForVisibleItems].lastObject;
        [self.mainView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (NSArray *)resetDatasouce:(NSArray *)dataArray {
    if (dataArray.count < 2) {
        return dataArray;
    }
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
    [resultArray addObject:dataArray.lastObject];
    
    for (id object in dataArray) {
        [resultArray addObject:object];
    }
    
    [resultArray addObject:dataArray.firstObject];
    return resultArray;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NXSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NXSlideCell cellIdentifier] forIndexPath:indexPath];
    [cell configCellWithImageURL:[self.items objectAtIndex:indexPath.row] placeholderImage:self.placeholderImage contentMode:self.contentMode];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(self, self.imageURLs, indexPath.row);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self resetPosition];
}

#pragma mark - Get/Setter
- (void)setBounces:(BOOL)bounces{
    _bounces = bounces;
    self.mainView.bounces = self.bounces;
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [self setupTimer];
}

@end
