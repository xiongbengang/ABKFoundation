//
//  UIViewController+ABKAdditions.m
//  ABKUser
//
//  Created by Bengang on 2018/6/13.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "UIViewController+ABKAdditions.h"
#import <objc/runtime.h>

static char ABKViewControllerTapGestureKey;

@interface UIViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *abk_tapGesutre;

@end

@implementation UIViewController (ABKAdditions)

- (UITapGestureRecognizer *)abk_tapGesutre
{
    return objc_getAssociatedObject(self, &ABKViewControllerTapGestureKey);
}

- (void)setAbk_tapGesutre:(UITapGestureRecognizer *)abk_tapGesutre
{
    objc_setAssociatedObject(self, &ABKViewControllerTapGestureKey, abk_tapGesutre, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hideKeyboardWhenTapped:(BOOL)hide
{
    if (!hide) {
        [self.view removeGestureRecognizer:self.abk_tapGesutre];
        return;
    }
    if (!self.abk_tapGesutre) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGesture.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGesture];
        self.abk_tapGesutre = tapGesture;
    }
}

- (void)viewTapped:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

- (void)backToPreviousViewController
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)configBackBarButtonItemWithImage:(UIImage *)image
{
    image = image ?: [UIImage imageNamed:@"ic_fanhui"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = image;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
}

- (void)customBackBarButtonItemImage:(UIImage *)image
{
    [self customBackBarButtonItemWithImage:image selector:nil];
}

- (void)customBackBarButtonItemSelector:(SEL)selector
{
    [self customBackBarButtonItemWithImage:nil selector:selector];
}

- (void)customBackBarButtonItemWithImage:(UIImage *)image selector:(SEL)selector
{
    selector = selector ?: @selector(backToPreviousViewController);
    image = image ?: [UIImage imageNamed:@"ic_fanhui"];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)backToEntryWithFlag:(NSString *)flag
{
    UIViewController *entryViewController = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc respondsToSelector:@selector(viewControllerEntryFlag)]) {
            NSString *entryFlag = [(id<ABKViewControllerEntryProtocol>)vc viewControllerEntryFlag];
            if ([entryFlag isEqualToString:flag]) {
                entryViewController = vc;
                break;
            }
        }
    }
    if (entryViewController && self.navigationController) {
        [self.navigationController popToViewController:entryViewController animated:YES];
    }
}

@end
