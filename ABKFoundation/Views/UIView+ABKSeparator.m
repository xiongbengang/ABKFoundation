//
//  UIView+ABKSeparator.m
//  ABKUser
//
//  Created by Bengang on 2018/5/4.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "UIView+ABKSeparator.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

static UIColor *ABKSeparatorColor = nil;

static char ABKSeparatorTypeKey;

@implementation UIView (ABKSeparator)

+ (void)setAbk_separatorColor:(UIColor *)abk_separatorColor
{
    ABKSeparatorColor = abk_separatorColor;
}

+ (UIColor *)abk_separatorColor
{
    if (!ABKSeparatorColor) {
        ABKSeparatorColor = [UIColor colorWithRed:206/255. green:206/255. blue:206/255. alpha:1];
    }
    return ABKSeparatorColor;
}

- (UIView *)abk_addBottomHorizontalSeparatorWithInsets:(UIEdgeInsets)insets
{
    return [self abk_addHorizontalSeparatorWithInsets:insets defaultBottom:YES];
}

- (UIView *)abk_addTopHorizontalSeparatorWithInsets:(UIEdgeInsets)insets
{
    return [self abk_addHorizontalSeparatorWithInsets:insets defaultBottom:NO];
}

- (UIView *)abk_addHorizontalSeparatorWithInsets:(UIEdgeInsets)insets defaultBottom:(BOOL)defaultBottom
{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIView abk_separatorColor];
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1.0/[UIScreen mainScreen].scale);
        make.leading.equalTo(self).offset(insets.left);
        make.trailing.equalTo(self).offset(-insets.right);
        if (defaultBottom) {
            if (insets.top > 0) {
                make.top.equalTo(self).offset(insets.top);
            } else {
                make.bottom.equalTo(self).offset(-insets.bottom);
            }
        } else {
            if (insets.bottom > 0) {
                make.bottom.equalTo(self).offset(-insets.bottom);
            } else {
                make.top.equalTo(self).offset(insets.top);
            }
        }
    }];
    return separator;
}

- (UIView *)abk_addLeftVerticalSeparatorWithInsets:(UIEdgeInsets)insets
{
    return [self abk_addVerticalSeparatorWithInsets:insets defaultRight:NO];
}

- (UIView *)abk_addRightVerticalSeparatorWithInsets:(UIEdgeInsets)insets
{
    return [self abk_addVerticalSeparatorWithInsets:insets defaultRight:YES];
}

- (UIView *)abk_addVerticalSeparatorWithInsets:(UIEdgeInsets)insets defaultRight:(BOOL)defaultRight
{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIView abk_separatorColor];
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1.0/[UIScreen mainScreen].scale);
        make.top.equalTo(self).offset(insets.top);
        make.bottom.equalTo(self).offset(-insets.bottom);
        if (defaultRight) {
            if (insets.left > 0) {
                make.leading.equalTo(self).offset(insets.left);
            } else {
                make.trailing.equalTo(self).offset(-insets.right);
            }
        } else {
            if (insets.right > 0) {
                make.trailing.equalTo(self).offset(-insets.right);
            } else {
                make.leading.equalTo(self).offset(insets.left);
            }
        }
    }];
    return separator;
}

- (void)abk_remakeLeadingConstraints:(CGFloat)constaint
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.superview).offset(constaint);
    }];
}

- (void)abk_remakeTrailingConstraints:(CGFloat)constaint
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.superview).offset(-constaint);
    }];
}

@end
