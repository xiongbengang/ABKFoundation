//
//  ABKNetworkErrorItem.h
//  ABKUser
//
//  Created by Bengang on 2018/4/26.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKBaseItem.h"

@interface ABKNetworkErrorItem : ABKBaseItem

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *errDescription;
@property (nonatomic, copy) NSString *errorType;
@property (nonatomic, copy) NSString *validationErrorType;

@end
