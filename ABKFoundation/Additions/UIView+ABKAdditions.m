//
//  UIView+ABKAdditions.m
//  ABKUser
//
//  Created by Bengang on 2018/4/27.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "UIView+ABKAdditions.h"

CGFloat ABKGetStatusBarHeight() {
    CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    return statusBarHeight;
}

@implementation UIView (ABKAdditions)

- (CGFloat)abk_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setAbk_top:(CGFloat)abk_top
{
    CGRect oldFrame = self.frame;
    oldFrame.origin.y = abk_top;
    self.frame = oldFrame;
}

- (CGFloat)abk_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setAbk_left:(CGFloat)abk_left
{
    CGRect oldFrame = self.frame;
    oldFrame.origin.x = abk_left;
    self.frame = oldFrame;
}

- (CGFloat)abk_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setAbk_right:(CGFloat)abk_right
{
    CGRect oldFrame = self.frame;
    oldFrame.origin.x = abk_right - oldFrame.size.width;
    self.frame = oldFrame;
}

- (CGFloat)abk_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setAbk_bottom:(CGFloat)abk_bottom
{
    CGRect oldFrame = self.frame;
    oldFrame.origin.y = abk_bottom - oldFrame.size.height;
    self.frame = oldFrame;
}

- (CGFloat)abk_centerX
{
    return CGRectGetMidX(self.frame);
}

- (void)setAbk_centerX:(CGFloat)abk_centerX
{
    CGPoint center = self.center;
    center.x = abk_centerX;
    self.center = center;
}

- (CGFloat)abk_centerY
{
    return CGRectGetMidY(self.frame);
}

- (void)setAbk_centerY:(CGFloat)abk_centerY
{
    CGPoint center = self.center;
    center.y = abk_centerY;
    self.center = center;
}

- (CGFloat)abk_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setAbk_width:(CGFloat)abk_width
{
    CGRect oldFrame = self.frame;
    oldFrame.size.width = abk_width;
    self.frame = oldFrame;
}

- (CGFloat)abk_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setAbk_height:(CGFloat)abk_height
{
    CGRect oldFrame = self.frame;
    oldFrame.size.height = abk_height;
    self.frame = oldFrame;
}

- (CGSize)abk_size
{
    return self.frame.size;
}

- (void)setAbk_size:(CGSize)abk_size
{
    CGRect oldFrame = self.frame;
    oldFrame.size = abk_size;
    self.frame = oldFrame;
}

- (CGPoint)abk_origin
{
    return self.frame.origin;
}

- (void)setAbk_origin:(CGPoint)abk_origin
{
    CGRect oldFrame = self.frame;
    oldFrame.origin = abk_origin;
    self.frame = oldFrame;
}

- (UIEdgeInsets)abk_safeAreaInsets
{
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

+ (instancetype)abk_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
