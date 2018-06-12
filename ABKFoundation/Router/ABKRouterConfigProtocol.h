//
//  ABKRouterConfigProtocol.h
//  ABKUser
//
//  Created by Bengang on 2018/4/27.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABKRouterConfigProtocol <NSObject>

@property (nonatomic, strong, readonly) NSDictionary<NSString *, Class> *routerClassMapper;
@property (nonatomic, strong, readonly) NSArray<NSString *> *schemes;

@end
