//
//  ABKJSONWrapper.h
//  ABKFoundation
//
//  Created by Bengang on 2018/8/8.
//

#import <Foundation/Foundation.h>

@interface ABKJSONWrapper : NSObject

@property (nonatomic, strong, readonly) id rawJSON;

@property (nonatomic, copy, readonly) NSString *stringValue;
@property (nonatomic, assign, readonly) NSInteger integerValue;
@property (nonatomic, assign, readonly) double doubleValue;
@property (nonatomic, assign, readonly) BOOL boolValue;

+ (instancetype)wrapperWithJSON:(id)JSON;

- (instancetype)initWithJSON:(id)rawJSON;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end
