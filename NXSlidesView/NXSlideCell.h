//
//  NXSlideCell.h
//  NXSlidesViewDemo
//
//  Created by 蒋瞿风 on 16/6/7.
//  Copyright © 2016年 nightx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXSlideCell : UICollectionViewCell

- (void)configCellWithImageURL:(NSURL *)imageURL
              placeholderImage:(UIImage *)placeholderImage
                   contentMode:(UIViewContentMode)mode
                         title:(NSString *)title;

+ (NSString *)cellIdentifier;

@end
