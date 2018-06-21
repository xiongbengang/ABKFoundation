//
//  ABKAlertTool.h
//  ABKUser
//
//  Created by Bengang on 2018/5/15.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABKAlertHelper : NSObject

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               actionItems:(NSArray<UIAlertAction *> *)actions
              inController:(UIViewController *)controller;

@end
