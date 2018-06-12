//
//  ABKNetworkRequestHandler.h
//  ABKUser
//
//  Created by Bengang on 2018/5/18.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ABKNetworkRequest;

@protocol ABKNetworkRequestHandler <NSObject>

@optional
- (void)requestDidResponseSuccess:(ABKNetworkRequest *)request;
- (void)requestDidResponseError:(ABKNetworkRequest *)request;
- (void)requestDidFailed:(ABKNetworkRequest *)request;
- (BOOL)isResponseSuccessOfRequest:(ABKNetworkRequest *)request;

@end
