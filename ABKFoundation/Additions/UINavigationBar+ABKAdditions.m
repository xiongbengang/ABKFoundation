//
//  UINavigationBar+ABKAdditions.m
//  ABKUser
//
//  Created by Bengang on 2018/5/3.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "UINavigationBar+ABKAdditions.h"
#import <objc/runtime.h>

static char ABKNavigationBarBakgroundViewKey;
static char ABKNavigationBarAlphaKey;

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *abk_backgroundView;

@end

@implementation UINavigationBar (ABKAdditions)

- (void)setAbk_backgroundView:(UIView *)abk_backgroundView
{
    objc_setAssociatedObject(self, &ABKNavigationBarBakgroundViewKey, abk_backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)abk_backgroundView
{
    UIView *backgroundView = objc_getAssociatedObject(self, &ABKNavigationBarBakgroundViewKey);
    if (!backgroundView) {
        backgroundView = self.subviews.firstObject;
        [self setAbk_backgroundView:backgroundView];
    }
    return backgroundView;
}

- (void)setAbk_alpha:(CGFloat)abk_alpha
{
    self.abk_backgroundView.alpha = abk_alpha;
    [self abk_setBottomLineHidden:abk_alpha == 0];
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.abk_backgroundView.subviews) {
            view.alpha = abk_alpha;
        }
    }
    objc_setAssociatedObject(self, &ABKNavigationBarAlphaKey, @(abk_alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)abk_alpha
{
    CGFloat alpha = [objc_getAssociatedObject(self, &ABKNavigationBarAlphaKey) floatValue];
    return alpha;
}

- (void)abk_setBottomLineHidden:(BOOL)hidden
{
    if (hidden) {
        self.shadowImage = [UIImage new];
    } else {
        self.shadowImage = nil;
    }
}

- (void)abk_setTintColor:(UIColor *)tintColor
{
    self.tintColor = tintColor ?: [UIColor blackColor];
    NSMutableDictionary *titleAttributes = [NSMutableDictionary dictionaryWithDictionary:self.titleTextAttributes];
    [titleAttributes setObject:self.tintColor forKey:NSForegroundColorAttributeName];
    self.titleTextAttributes = titleAttributes;
}

@end
