//
//  DBNetworkRequest.m
//  TheBarberClient
//
//  Created by Bengang on 2017/8/14.
//  Copyright © 2017年 董剑. All rights reserved.
//

#import "ABKNetworkRequest.h"
#import "ABKNetworkIndicatorAccessory.h"
#ifdef DEBUG
#import "ABKNetworkLogger.h"
#endif

@interface ABKNetworkRequest ()

@property (nonatomic, strong, readwrite) ABKNetworkBaseItem *responseItem;
@property (nonatomic, assign) BOOL hasPrepared;

@end

@implementation ABKNetworkRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        ABKNetworkIndicatorAccessory *networkIndicatorAccessort = [[ABKNetworkIndicatorAccessory alloc] init];
        [self addAccessory:networkIndicatorAccessort];
        
#ifdef DEBUG
        ABKNetworkLogger *logger = [[ABKNetworkLogger alloc] init];
        [self addAccessory:logger];
#endif
    }
    return self;
}

- (NSString *)requestUrl
{
    if (_requestUrl.length) {
        return _requestUrl;
    }
    return [super requestUrl];
}

- (NSString *)baseUrl
{
    if (_baseUrl.length) {
        return _baseUrl;
    }
    return [super baseUrl];
}

- (id)requestArgument
{
    NSMutableDictionary *arguments = [NSMutableDictionary dictionaryWithDictionary:[self commonParameters]];
    [arguments addEntriesFromDictionary:self.businessParameters];
    return arguments;
}

- (void)clearCompletionBlock
{
    [super clearCompletionBlock];
    self.hasPrepared = NO;
}

- (void)prepare
{
    if (self.hasPrepared) {
        return;
    }
    // Fix Me 循环引用 依赖父类的clearCompletionBlock
    YTKRequestCompletionBlock oldSuccessBlock = [self.successCompletionBlock copy];
    YTKRequestCompletionBlock successBlock = ^(ABKNetworkRequest *request) {
        if (oldSuccessBlock) {
            oldSuccessBlock(request);
        }
        if ([self isResponseSucceed]) {
            if ([request.requestHandler respondsToSelector:@selector(requestDidResponseSuccess:)]) {
                [request.requestHandler requestDidResponseSuccess:request];
            }
            if (self.responseSuccess) {
                self.responseSuccess(self);
            }
            [self toggleAccessoriesDidResponseSuccess];
        } else {
            if ([request.requestHandler respondsToSelector:@selector(requestDidResponseError:)]) {
                [request.requestHandler requestDidResponseError:request];
            }
            if (self.responseError) {
                self.responseError(self);
            }
            [self toggleAccessoriesDidResponseError];
        }
    };
    YTKRequestCompletionBlock oldFailueBlock = [self.failureCompletionBlock copy];
    YTKRequestCompletionBlock faildBlock = ^(ABKNetworkRequest *request) {
        if (oldFailueBlock) {
            oldFailueBlock(request);
        }
        if ([request.requestHandler respondsToSelector:@selector(requestDidFailed:)]) {
            [request.requestHandler requestDidFailed:request];
        }
        if (self.requestFailed) {
            self.requestFailed(self);
        }
        [self toggleAccessoriesDidRequestFailed];
    };
    [self setCompletionBlockWithSuccess:successBlock failure:faildBlock];
    self.hasPrepared = YES;
}

- (void)toggleAccessoriesDidResponseSuccess
{
    for (id<YTKRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(abk_didResponseSuccess:)]) {
            [(id<ABKNetworkAccessory>)accessory abk_didResponseSuccess:self];
        }
    }
}

- (void)toggleAccessoriesDidResponseError
{
    for (id<YTKRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(abk_didResponseError:)]) {
            [(id<ABKNetworkAccessory>)accessory abk_didResponseError:self];
        }
    }
}

- (void)toggleAccessoriesDidRequestFailed
{
    for (id<YTKRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(abk_didRequestFailed:)]) {
            [(id<ABKNetworkAccessory>)accessory abk_didRequestFailed:self];
        }
    }
}

- (void)startWithResponseSuccess:(ABKRequestReponseSuccess)success responseError:(ABKRequestReponseError)responseError requestFailed:(ABKRequestFailed)requestFailed
{
    self.responseSuccess = success;
    self.responseError = responseError;
    self.requestFailed = requestFailed;
    [self start];
}

- (void)requestCompletePreprocessor
{
    [super requestCompletePreprocessor];
    self.responseItem = [ABKNetworkBaseItem modelWithJSON:self.responseJSONObject];
    if ([self.responseJSONObject isKindOfClass:[NSDictionary class]]) {
        id dataJSON = self.responseJSONObject[@"data"];
        self.responseItem.wrapperedData = (dataJSON != (id)kCFNull) ? [ABKJSONWrapper wrapperWithJSON:dataJSON] : nil;
        if (self.dataClass) {
            if ([dataJSON isKindOfClass:[NSArray class]]) {
                self.responseItem.parsedData = [NSArray yy_modelArrayWithClass:self.dataClass json:dataJSON];
            } else if ([dataJSON isKindOfClass:[NSDictionary class]]) {
                self.responseItem.parsedData = [self.dataClass yy_modelWithJSON:dataJSON];
            }
        }
    }
}

- (void)start
{
    [self prepare];
    if (!self.executing) {
        [super start];
    }
}

- (BOOL)isResponseSucceed
{
    BOOL isResponseSuccess = YES;
    if ([self.requestHandler respondsToSelector:@selector(isResponseSuccessOfRequest:)]) {
        isResponseSuccess = [self.requestHandler isResponseSuccessOfRequest:self];
    }
    return isResponseSuccess;
}

@end
