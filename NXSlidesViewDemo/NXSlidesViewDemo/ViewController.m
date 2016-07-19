//
//  ViewController.m
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/6.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "NXSlidesView.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *imagesURLStrings;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesURLStrings = @[[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"]
                                  ,
                                  [NSURL URLWithString:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"],
                                  [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]
                                  ];
    
    NXSlidesView *slidesView = [[NXSlidesView alloc] initWithFrame:CGRectMake(0, 0, 100, 120) ImageURLs:self.imagesURLStrings placeholderImage:nil autoScroll:YES infiniteLoop:YES didSelectItemBlock:^(NXSlidesView *slidesView, NSArray *imageURLs, NSInteger index) {
        NSLog(@"点击了第%@张图片",[NSNumber numberWithInteger:index]);
        [slidesView updateImageURLs:imageURLs placeholderImage:nil];
    }];
    [self.view addSubview:slidesView];
    [slidesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
