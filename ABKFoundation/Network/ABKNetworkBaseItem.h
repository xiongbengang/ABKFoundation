//
//  BGNetworkBaseItem.h
//  Run
//
//  Created by Bengang on 25/11/2017.
//

#import "ABKBaseItem.h"
#import "ABKNetworkErrorItem.h"
#import "ABKJSONWrapper.h"

@interface ABKNetworkBaseItem : ABKBaseItem

@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *error_description;
@property (nonatomic, assign) NSInteger errcode;

@property (nonatomic, strong) id parsedData;      // 解析后的data
@property (nonatomic, strong) id dataJSON DEPRECATED_MSG_ATTRIBUTE("use wrapperedData instead");     // 原始的data JSON结构
@property (nonatomic, strong) ABKJSONWrapper *wrapperedData;
@property (nonatomic, copy) NSArray<ABKNetworkErrorItem *> *errors;

@end


@interface ABKMutationResult : ABKBaseItem

@property (nonatomic, assign) NSInteger status;

@end

