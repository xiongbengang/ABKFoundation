//
//  UIView+ABKAdditions.h
//  ABKUser
//
//  Created by Bengang on 2018/4/27.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size):NO)

#define ABKScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ABKScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ABKStatusBarHeight (ABKGetStatusBarHeight())
#define ABKNavigationBarHeight (44)
#define ABKTabbarBarHeight (49)
#define ABKTabbarBarBottomHeight ([[UIApplication sharedApplication].keyWindow abk_safeAreaInsets].bottom+ABKTabbarBarHeight)
#define ABKNavigationTopHeight (ABKStatusBarHeight+ABKNavigationBarHeight)
#define ABKSeparatorHeight (1.0/[UIScreen mainScreen].scale)

UIKIT_EXTERN CGFloat ABKGetStatusBarHeight(void);

@interface UIView (ABKAdditions)

@property (nonatomic, assign) CGFloat abk_left;
@property (nonatomic, assign) CGFloat abk_right;
@property (nonatomic, assign) CGFloat abk_top;
@property (nonatomic, assign) CGFloat abk_bottom;
@property (nonatomic, assign) CGFloat abk_centerX;
@property (nonatomic, assign) CGFloat abk_centerY;
@property (nonatomic, assign) CGFloat abk_width;
@property (nonatomic, assign) CGFloat abk_height;
@property (nonatomic, assign) CGSize abk_size;
@property (nonatomic, assign) CGPoint abk_origin;
@property (nonatomic, assign, readonly) UIEdgeInsets abk_safeAreaInsets;

+ (instancetype)abk_viewFromXib;

@end
