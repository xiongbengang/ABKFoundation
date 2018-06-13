//
//  UINavigationBar+ABKAdditions.h
//  ABKUser
//
//  Created by Bengang on 2018/5/3.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ABKAdditions)

@property (nonatomic, assign) CGFloat abk_alpha;

- (void)abk_setBottomLineHidden:(BOOL)hidden;

- (void)abk_setTintColor:(UIColor *)tintColor;

@end
