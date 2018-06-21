//
//  ViewController.h
//  PopoverWindow
//
//  Created by Bengang on 4/13/16.
//  Copyright © 2016 JDB. All rights reserved.
//

#import "MDFPresentViewHelper.h"
#import <objc/runtime.h>

static const CGFloat MDFDefaultAnimationDuration = 0.2f;

static NSString *kBackgroundControlKey;

@interface MDFPresentViewHelper ()

@property (nonatomic, weak, readwrite) UIView *currentPresentingView;
@property (nonatomic, strong, readwrite) NSMutableArray *presentingViews;
@property (nonatomic, assign) CGRect originalContentViewFrame;
@property (nonatomic, weak) UIWindow *applicationKeyWindow;

@end

@implementation MDFPresentViewHelper

+ (MDFPresentViewHelper *)sharedHelper
{
    static MDFPresentViewHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[[self class] alloc] init];
    });
    return helper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _presentingViews = [NSMutableArray array];
        [self addKeyboardNotification];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [self removeKeyboardNotification];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self addKeyboardNotification];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSTimeInterval timeInterval = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:timeInterval delay:0 options:animationCurve << 16 animations:^{
        CGRect frame = self.originalContentViewFrame;
        frame.origin.y -= CGRectGetHeight(keyboardFrame) * 0.5;
        self.currentPresentingView.frame = frame;
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSTimeInterval timeInterval = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:timeInterval delay:0 options:animationCurve << 16 animations:^{
        self.currentPresentingView.frame = self.originalContentViewFrame;
    } completion:nil];
}

- (UIControl *)generateBackgroundControl
{
    UIControl *backgroundControl = [[UIControl alloc] initWithFrame:CGRectZero];
    backgroundControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [backgroundControl addTarget:self action:@selector(backgroundViewPressed:) forControlEvents:UIControlEventTouchDown];
    return backgroundControl;
}

- (UIControl *)backgroundControlOfContentView:(UIView *)contentView
{
    UIControl *backgroundControl = objc_getAssociatedObject(contentView, &kBackgroundControlKey);
    if (!backgroundControl) {
        backgroundControl = [self generateBackgroundControl];
        objc_setAssociatedObject(contentView, &kBackgroundControlKey, backgroundControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backgroundControl;
}

- (UIWindow *)applicationKeyWindow
{
    if (!_applicationKeyWindow) {
        UIApplication * application = [UIApplication sharedApplication];
        id<UIApplicationDelegate> appDelegate = [application delegate];
        if ([appDelegate respondsToSelector:@selector(window)]) {
            _applicationKeyWindow = [appDelegate window];
        } else if ([[application windows] count]) {
            _applicationKeyWindow = [[application windows] objectAtIndex:0];
        }
    }
    return _applicationKeyWindow;
}

- (CGRect)popoverRectOfSize:(CGSize)contentSize baseRect:(CGRect)baseRect
{
    CGFloat verticalMargin = 0; // popover与fromView的纵向间隔
    CGRect popoverRect = CGRectMake(0, 0, contentSize.width, contentSize.height);
    if (CGRectGetWidth(baseRect) >= contentSize.width) {
        // contentView 的宽度小于 fromView 的宽度
        popoverRect.origin.x = CGRectGetMinX(baseRect) + floorf((CGRectGetWidth(baseRect) - contentSize.width) * 0.5);
    } else {
        CGFloat fromViewLeftMargin = CGRectGetMinX(baseRect);
        CGFloat fromViewRightMargin = CGRectGetWidth([UIScreen mainScreen].bounds) - CGRectGetMaxX(baseRect);
        if (fromViewLeftMargin <= fromViewRightMargin) {
            // fromView 横向偏左，设置 popover 与之左对齐
            popoverRect.origin.x = fromViewLeftMargin;
        } else {
            // fromView 横向偏右，设置 popover 与之右对齐
            popoverRect.origin.x = CGRectGetWidth([UIScreen mainScreen].bounds) - fromViewRightMargin - contentSize.width;
        }
    }
    CGFloat fromViewTopMargin = CGRectGetMinY(baseRect);
    CGFloat fromViewBottomMargin = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetMaxY(baseRect);
    if (fromViewTopMargin <= fromViewBottomMargin) {
        // fromView 纵向偏上，设置 popover 在其下方
        popoverRect.origin.y = CGRectGetMaxY(baseRect) + verticalMargin;
    } else {
        // fromView 纵向偏下，设置 popover 在其上方
        popoverRect.origin.y = fromViewTopMargin - verticalMargin - contentSize.height;
    }
    return popoverRect;
}

- (void)presentContentView:(UIView *)contentView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock
{
    CGRect inRect = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5-CGRectGetWidth(contentView.frame) * 0.5,
                               CGRectGetHeight([UIScreen mainScreen].bounds) * 0.5 - CGRectGetHeight(contentView.frame) * 0.5,
                               contentView.frame.size.width,
                               contentView.frame.size.height);
    [self presentContentView:contentView inRect:inRect animated:animated complete:completeBlock];
}


- (void)presentContentView:(UIView *)contentView fromView:(UIView *)fromView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock
{
    [self presentContentView:contentView fromRect:fromView.frame inView:contentView.superview animated:animated complete:completeBlock];
}

- (void)presentContentView:(UIView *)contentView fromRect:(CGRect)fromRect inView:(UIView *)inView animated:(BOOL)animated complete:(dispatch_block_t)completeBlock;
{
    UIView *superView = inView;
    CGRect frameInSuperView = fromRect;
    while (superView && superView != self.applicationKeyWindow) {
        frameInSuperView = [superView.superview convertRect:frameInSuperView fromView:superView];
        superView = [superView superview];
    }
    CGRect frameToWindow = [self popoverRectOfSize:contentView.frame.size baseRect:frameInSuperView];
    [self presentContentView:contentView inRect:frameToWindow animated:animated complete:completeBlock];
}

- (BOOL)hasPresentedContentView:(UIView *)contentView
{
    return [self.presentingViews containsObject:contentView];
}

- (void)presentContentView:(UIView *)contentView inRect:(CGRect)inRect animated:(BOOL)animated complete:(dispatch_block_t)completeBlock
{
    if ([self hasPresentedContentView:contentView]) {
        return;
    }
    UIControl *backgroundControl = [self backgroundControlOfContentView:contentView];
    backgroundControl.frame = self.applicationKeyWindow.bounds;
    backgroundControl.backgroundColor = [self backgroundControlColorOfWillPresentView:contentView];
    [self.applicationKeyWindow addSubview:backgroundControl];
    contentView.frame = inRect;
    self.currentPresentingView = contentView;
    self.originalContentViewFrame = self.currentPresentingView.frame;
    [self.applicationKeyWindow addSubview:contentView];
    [self.presentingViews addObject:contentView];
    if (animated) {
        [self doPresentAnimationWithContentView:contentView animationType:[self animationTypeOfContentView:contentView] duration:[self presentDurationOfContentView:contentView] completeBlock:completeBlock];
    } else {
        if (completeBlock) {
            completeBlock();
        }
    }
}

- (void)doPresentAnimationWithContentView:(UIView *)contentView animationType:(MDFPresentAnimationType)animationType duration:(NSTimeInterval)duration completeBlock:(dispatch_block_t)completeBlock
{
    UIControl *backgroundControl = [self backgroundControlOfContentView:contentView];
    switch (animationType) {
        case MDFPresentAnimationTypeTansform:{
            contentView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            backgroundControl.alpha = 0;
            contentView.alpha = 0;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
                contentView.alpha = 1;
                backgroundControl.alpha = 1;
                contentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (completeBlock) {
                    completeBlock();
                }
            }];
            break;
        }
        case MDFPresentAnimationTypeFade:{
            contentView.alpha = .0;
            backgroundControl.alpha = 0;
            [UIView animateWithDuration:duration animations:^{
                contentView.alpha = 1;
                backgroundControl.alpha = 1;
            } completion:^(BOOL finished) {
                if (completeBlock) {
                    completeBlock();
                }
            }];
            break;
        }
    }
}

- (void)dismissContentView:(UIView *)contentView animated:(BOOL)animated
{
    [self dismissContentView:contentView animated:animated complete:nil];
}

- (void)dismissContentView:(UIView *)contentView animated:(BOOL)animated complete:(void(^)(void))completedBlock
{
    if ([self.presentingViews containsObject:contentView]) {
        [self.presentingViews removeObject:contentView];
    }
    self.currentPresentingView = [self.presentingViews lastObject];
    self.originalContentViewFrame = self.currentPresentingView.frame;
    
    if (animated) {
        [self doDismissAnimationWithContentView:contentView duration:[self dismissDurationOfContentView:contentView] complete:completedBlock];
    } else {
        [self didDismissedContentView:contentView];
        if (completedBlock) {
            completedBlock();
        }
    }
}

- (void)doDismissAnimationWithContentView:(UIView *)contentView duration:(NSTimeInterval)duration complete:(void(^)(void))completedBlock
{
    UIControl *backgroundControl = [self backgroundControlOfContentView:contentView];
    [UIView animateWithDuration:duration animations:^{
        backgroundControl.alpha = 0;
        contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self didDismissedContentView:contentView];
        if (completedBlock) {
            completedBlock();
        }
    }];
}

- (void)didDismissedContentView:(UIView *)contentView
{
    UIControl *backgroundControl = [self backgroundControlOfContentView:contentView];
    [backgroundControl removeFromSuperview];
    [contentView removeFromSuperview];
}

- (void)backgroundViewPressed:(id)sender
{
    if ([self.currentPresentingView conformsToProtocol:@protocol(MDFPresentViewProtocol)]) {
        id<MDFPresentViewProtocol> viewProtocol = (id<MDFPresentViewProtocol>)self.currentPresentingView;
        if ([viewProtocol respondsToSelector:@selector(dismissOnTappedBackground)]) {
            if ([viewProtocol dismissOnTappedBackground]) {
                [self dismissContentView:self.currentPresentingView animated:YES];
            }
        }
    }
}

- (NSTimeInterval)dismissDurationOfContentView:(UIView *)contentView
{
    if ([contentView conformsToProtocol:@protocol(MDFPresentViewProtocol)]) {
        id<MDFPresentViewProtocol> viewProtocol = (id<MDFPresentViewProtocol>)contentView;
        if ([viewProtocol respondsToSelector:@selector(dismissDuration)]) {
            return [viewProtocol dismissDuration];
        }
    }
    return MDFDefaultAnimationDuration;
}

- (NSTimeInterval)presentDurationOfContentView:(UIView *)contentView
{
    if ([contentView conformsToProtocol:@protocol(MDFPresentViewProtocol)]) {
        id<MDFPresentViewProtocol> viewProtocol = (id<MDFPresentViewProtocol>)contentView;
        if ([viewProtocol respondsToSelector:@selector(presentDuration)]) {
            return [viewProtocol presentDuration];
        }
    }
    return MDFDefaultAnimationDuration;
}

- (MDFPresentAnimationType)animationTypeOfContentView:(UIView *)contentView
{
    if ([contentView conformsToProtocol:@protocol(MDFPresentViewProtocol)]) {
        id<MDFPresentViewProtocol> viewProtocol = (id<MDFPresentViewProtocol>)contentView;
        if ([viewProtocol respondsToSelector:@selector(animationType)]) {
            return [viewProtocol animationType];
        }
    }
    return MDFDefaultAnimationDuration;
}

- (UIColor *)backgroundControlColorOfWillPresentView:(UIView *)willPresentContentView
{
    if ([willPresentContentView conformsToProtocol:@protocol(MDFPresentViewProtocol)]) {
        id<MDFPresentViewProtocol> viewProtocol = (id<MDFPresentViewProtocol>)willPresentContentView;
        if ([viewProtocol respondsToSelector:@selector(backgroundControlColor)]) {
            return [viewProtocol backgroundControlColor];
        }
    }
    if (self.currentPresentingView) {
        return [UIColor clearColor];
    }
    return [UIColor colorWithWhite:0 alpha:0.4];
}

@end
