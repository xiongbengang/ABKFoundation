//
//  ViewController.h
//  PopoverWindow
//
//  Created by Bengang on 4/13/16.
//  Copyright © 2016 JDB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MDFAlertViewButtonActionBlock)(UIView *alertView, NSUInteger buttonIndex);

typedef NS_ENUM(NSUInteger, MDFPresentAnimationType){
    MDFPresentAnimationTypeTansform = 0,
    MDFPresentAnimationTypeFade = 1,
};

@protocol MDFPresentViewProtocol <NSObject>

@optional
@property (nonatomic, assign) MDFPresentAnimationType animationType;
@property (nonatomic, strong) UIColor *backgroundControlColor;
@property (nonatomic, assign) NSTimeInterval presentDuration;
@property (nonatomic, assign) NSTimeInterval dismissDuration;
@property (nonatomic, assign) BOOL dismissOnTappedBackground;

@end

@interface MDFPresentViewHelper : NSObject

+ (MDFPresentViewHelper *)sharedHelper;

- (BOOL)hasPresentedContentView:(UIView *)contentView;

- (void)presentContentView:(UIView *)contentView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock;

- (void)presentContentView:(UIView *)contentView fromView:(UIView *)fromView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock;

- (void)presentContentView:(UIView *)contentView fromRect:(CGRect)fromRect inView:(UIView *)inView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock;

- (void)presentContentView:(UIView *)contentView inRect:(CGRect)inRect animated:(BOOL)animated complete:(dispatch_block_t)completeBlock;

- (void)dismissContentView:(UIView *)contentView animated:(BOOL)animated;

- (void)dismissContentView:(UIView *)contentView animated:(BOOL)animated complete:(void(^)(void))completedBlock;

@end
