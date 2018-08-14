//
//  ABKViewControllerBottomView.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/25.
//

#import <UIKit/UIKit.h>

@interface ABKViewControllerBottomView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, assign, readonly) CGFloat excludeSafeAreaHeight;
@property (nonatomic, assign) BOOL keepInFront;

- (instancetype)initWithContentView:(UIView *)contentView
                      contentHeight:(CGFloat)contentHeight
                      contentInsets:(UIEdgeInsets)contentInsets;

@end
