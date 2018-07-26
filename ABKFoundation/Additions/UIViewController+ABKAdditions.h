//
//  UIViewController+ABKAdditions.h
//  ABKUser
//
//  Created by Bengang on 2018/6/13.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABKViewControllerEntryProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *viewControllerEntryFlag; // 返回标识

@end

@interface UIViewController (ABKAdditions)

- (void)hideKeyboardWhenTapped:(BOOL)hide;

- (void)backToPreviousViewController;

- (void)backToEntryWithFlag:(NSString *)flag;

- (void)configBackBarButtonItemWithImage:(UIImage *)image;

- (void)customBackBarButtonItemImage:(UIImage *)image;

- (void)customBackBarButtonItemSelector:(SEL)selector;

- (void)customBackBarButtonItemWithImage:(UIImage *)image selector:(SEL)selector;

@end
