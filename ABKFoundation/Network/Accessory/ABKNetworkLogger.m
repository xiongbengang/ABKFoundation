//
//  ABKNetworkLogger.m
//  ABKFoundation
//
//  Created by Bengang on 2018/7/3.
//

#import "ABKNetworkLogger.h"

@interface ABKNetworkLogger ()

@property (nonatomic, strong) NSDate *startTime;

@end

@implementation ABKNetworkLogger

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }
    return formatter;
}

- (void)requestWillStart:(id)request
{
    self.startTime = [NSDate date];
}

- (void)requestDidStop:(id)request
{
    if (![request isKindOfClass:[YTKBaseRequest class]]) {
        return;
    }
    YTKBaseRequest *rq = (YTKBaseRequest *)request;
    NSLog(@"*******************************");
    NSString *startTime = [[self dateFormatter] stringFromDate:self.startTime];
    NSString *endTime = [[self dateFormatter] stringFromDate:[NSDate date]];
    NSTimeInterval cost = [[NSDate date] timeIntervalSinceDate:self.startTime];
    
    NSLog(@"===startTime:%@ endTime:%@ cost:%@", startTime, endTime, @(cost));
    NSLog(@"------- token: %@", rq.currentRequest.allHTTPHeaderFields[@"Authorization"]);
    NSLog(@"------- request:%@", [rq description]);
    NSLog(@"------- response:%@", [rq abk_responseDescription]);
    NSLog(@"*******************************");
}

@end

@implementation YTKBaseRequest (ABKNetwokLog)

- (NSString *)abk_responseDescription
{
    if ([NSJSONSerialization isValidJSONObject:self.responseJSONObject]) {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self.responseJSONObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    return @"";
}

@end
