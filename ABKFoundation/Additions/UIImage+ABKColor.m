//
//  UIImage+ABKColor.m
//  ABKUser
//
//  Created by Bengang on 2018/4/28.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "UIImage+ABKColor.h"

@implementation UIImage (ABKColor)

+ (instancetype)abk_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
