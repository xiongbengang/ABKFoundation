//
//  ABKAlertTool.m
//  ABKUser
//
//  Created by Bengang on 2018/5/15.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKAlertHelper.h"
#import "UIViewController+ABKTopMost.h"

@implementation ABKAlertHelper

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               actionItems:(NSArray<UIAlertAction *> *)actions
              inController:(UIViewController *)controller
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (!controller || ![controller isKindOfClass:[UIViewController class]]) {
        controller = [UIViewController abk_topMostViewController];
    }
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
