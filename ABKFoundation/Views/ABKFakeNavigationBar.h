//
//  BGFakeNavigationBar.h
//  Kiwi
//
//  Created by Bengang on 2018/5/28.
//

#import <UIKit/UIKit.h>

@interface ABKFakeNavigationBar : UIView

@property (nonatomic, strong, readonly) UIView *statusBarView;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIButton *backButton;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIView *bottomLine;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *titleView;

@end
