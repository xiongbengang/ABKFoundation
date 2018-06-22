//
//  ABKOrderSegmentView.h
//  ABKUser
//
//  Created by Bengang on 2018/5/4.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABKOrderSegmentView;

@protocol ABKOrderSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(ABKOrderSegmentView *)segmentView didSelectAtIndex:(NSInteger)index;

- (NSArray<NSString *> *)itemsForSegmentView:(ABKOrderSegmentView *)segmentView;

@end

@interface ABKOrderSegmentView : UIView

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIColor *flagColor;
@property (nonatomic, assign) CGFloat flagHeight;
@property (nonatomic, assign) BOOL flagEqualToText;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIFont *selectedTextFont;

@property (nonatomic, assign) BOOL showVirticalSeparator;
@property (nonatomic, assign) UIEdgeInsets virticalSeparatorEdgeInsets;

@property (nonatomic, weak) id<ABKOrderSegmentViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end
