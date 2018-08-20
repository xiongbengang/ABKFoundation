//
//  BGNetworkBaseItem.h
//  Run
//
//  Created by Bengang on 25/11/2017.
//

#import "ABKBaseItem.h"
#import "ABKJSONWrapper.h"

@interface ABKNetworkBaseItem : ABKBaseItem

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id parsedData;      // 解析后的data
@property (nonatomic, strong) ABKJSONWrapper *wrapperedData;  /// 原始的data JSON结构

@end


