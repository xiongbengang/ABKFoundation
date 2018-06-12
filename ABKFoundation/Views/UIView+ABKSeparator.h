//
//  UIView+ABKSeparator.h
//  ABKUser
//
//  Created by Bengang on 2018/5/4.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ABKSeparator)

@property(nonatomic, strong, class) UIColor *abk_separatorColor;

- (UIView *)abk_addBottomHorizontalSeparatorWithInsets:(UIEdgeInsets)insets;
- (UIView *)abk_addTopHorizontalSeparatorWithInsets:(UIEdgeInsets)insets;
- (UIView *)abk_addLeftVerticalSeparatorWithInsets:(UIEdgeInsets)insets;
- (UIView *)abk_addRightVerticalSeparatorWithInsets:(UIEdgeInsets)insets;

@end
