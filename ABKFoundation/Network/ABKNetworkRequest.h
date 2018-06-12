//
//  DBNetworkRequest.h
//  TheBarberClient
//
//  Created by Bengang on 2017/8/14.
//  Copyright © 2017年 董剑. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "ABKNetworkRequestHandler.h"
#import "ABKNetworkBaseItem.h"
@class ABKNetworkRequest;

@protocol ABKNetworkAccessory <YTKRequestAccessory>

@optional
- (void)abk_didResponseSuccess:(ABKNetworkRequest *)networkRequest;
- (void)abk_didResponseError:(ABKNetworkRequest *)networkRequest;
- (void)abk_didRequestFailed:(ABKNetworkRequest *)networkRequest;

@end


typedef NS_ENUM(NSInteger, ABKRequestType) {
    ABKRequestTypeNomal = 0,
    ABKRequestTypeRefresh = 1,
    ABKRequestTypeLoadMore = 2,
};

typedef void(^ABKRequestReponseSuccess)(ABKNetworkRequest *request);
typedef void(^ABKRequestReponseError)(ABKNetworkRequest *request);
typedef void(^ABKRequestFailed)(ABKNetworkRequest *request);

@interface ABKNetworkRequest : YTKRequest

@property (nonatomic, assign) ABKRequestType requestType;
// 通用参数
@property (nonatomic, copy) NSDictionary *commonParameters;
// 业务参数
@property (nonatomic, copy) NSDictionary *businessParameters;

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, copy) NSString *requestUrl;

@property (nonatomic, copy) ABKRequestReponseSuccess responseSuccess;

@property (nonatomic, copy) ABKRequestReponseError responseError;

@property (nonatomic, copy) ABKRequestFailed requestFailed;

@property (nonatomic, weak) id<ABKNetworkRequestHandler> requestHandler;

@property (nonatomic, strong) Class dataClass;

@property (nonatomic, strong, readonly) ABKNetworkBaseItem *responseItem;

- (void)prepare;

- (void)requestCompletePreprocessor NS_REQUIRES_SUPER;

- (BOOL)isResponseSucceed;

- (void)startWithResponseSuccess:(ABKRequestReponseSuccess)success responseError:(ABKRequestReponseError)responseError requestFailed:(ABKRequestFailed)requestFailed;

@end
