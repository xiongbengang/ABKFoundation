//
//  ABKGraphqlHelper.m
//  ABKFoundation
//
//  Created by Bengang on 2018/6/12.
//

#import "ABKGraphqlHelper.h"
#import "ABKNetworkResponseGraph.h"
#import "ABKBaseItem.h"

@implementation ABKGraphqlHelper

+ (NSString *)queryStringWithRequestItems:(NSArray<ABKRequestItem *> *)requestItems apiMethod:(ABKApiMethod)apiMethod
{
    NSMutableArray *requestStrings = [NSMutableArray arrayWithCapacity:requestItems.count];
    for (ABKRequestItem *requestItem in requestItems) {
        NSString *rs = [self requestStringWithApiName:requestItem.api parameters:requestItem.parameters graph:requestItem.graph];
        [requestStrings addObject:rs];
    }
    NSString *method = ABKApiMethodDesc(apiMethod);
    NSString *queryString = [NSString stringWithFormat:@"%@{%@}", method, [requestStrings componentsJoinedByString:@","]];
    return queryString;
}

+ (NSString *)requestStringWithApiName:(NSString *)apiName parameters:(NSDictionary *)parameters graph:(NSString *)graph
{
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:apiName];
    if (parameters) {
        NSString *parametersString = [self keyValuePairsStringWithDictionary:parameters addFlag:NO];
        if (parametersString.length) {
            [requestString appendFormat:@"(%@)", parametersString];
        }
    }
    if (graph.length) {
        NSString *str = [NSString stringWithFormat:@"%@{%@}", requestString, graph];
        return str;
    } else {
        return requestString;
    }
}

+ (NSString *)keyValuePairsStringWithDictionary:(NSDictionary *)parameters addFlag:(BOOL)addFlag
{
    NSMutableArray *keyValuePairs = [NSMutableArray arrayWithCapacity:parameters.count];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *keyPair = [NSString stringWithFormat:@"%@:\"%@\"",key, obj];
            [keyValuePairs addObject:keyPair];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            NSString *keyPair = [NSString stringWithFormat:@"%@:%@",key, obj];
            [keyValuePairs addObject:keyPair];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *keyPair = [NSString stringWithFormat:@"%@:%@", key, [self keyValuePairsStringWithDictionary:obj addFlag:YES]];
            [keyValuePairs addObject:keyPair];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSString *keyPair = [NSString stringWithFormat:@"%@:%@", key, [self keyValuePairsStringWithArray:obj]];
            [keyValuePairs addObject:keyPair];
        }
    }];
    NSString *valueString = nil;
    if (!addFlag) {
        valueString = [keyValuePairs componentsJoinedByString:@","];
    } else {
        valueString = [NSString stringWithFormat:@"{%@}", [keyValuePairs componentsJoinedByString:@","]];
    }
    return valueString;
}

+ (NSString *)keyValuePairsStringWithArray:(NSArray *)array
{
    NSMutableArray *keyValueParis = [NSMutableArray arrayWithCapacity:array.count];
    for (id obj in array) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *valueString = [NSString stringWithFormat:@"\"%@\"", obj];
            [keyValueParis addObject:valueString];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            [keyValueParis addObject:obj];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [keyValueParis addObject:[self keyValuePairsStringWithDictionary:obj addFlag:YES]];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [keyValueParis addObject:[self keyValuePairsStringWithArray:obj]];
        }
    }
    NSString *valueString = [NSString stringWithFormat:@"[%@]", [keyValueParis componentsJoinedByString:@","]];
    return valueString;
}

+ (NSSet *)graphBlacklistForClass:(Class)cls blacklist:(NSArray<NSString *> *)blacklist
{
    NSMutableArray *graphBlacklist = [NSMutableArray arrayWithArray:@[@"debugDescription", @"description", @"hash", @"superclass"]];
    if ([cls respondsToSelector:@selector(graphBlacklist)]) {
        NSArray *customerBlacklist = [cls graphBlacklist];
        if (customerBlacklist.count) {
            [graphBlacklist addObjectsFromArray:customerBlacklist];
        }
    }
    if (blacklist.count) {
        [graphBlacklist addObjectsFromArray:blacklist];
    }
    return [NSSet setWithArray:graphBlacklist];
}

+ (NSString *)graphForClass:(Class)cls
{
    return [self graphForClass:cls blacklist:nil];
}

+ (NSString *)graphForClass:(Class)cls blacklist:(NSArray<NSString *> *)aBlacklist
{
    NSDictionary *modelCustomMapper = nil;
    if ([cls respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        modelCustomMapper = [cls modelCustomPropertyMapper];
    }
    NSSet *graphBlacklist = [self graphBlacklistForClass:cls blacklist:aBlacklist];
    
    YYClassInfo *classInfo = [YYClassInfo classInfoWithClass:cls];
    NSMutableArray *properties = [NSMutableArray arrayWithCapacity:classInfo.propertyInfos.count];
    for (YYClassPropertyInfo *property in classInfo.propertyInfos.allValues) {
        if ([cls respondsToSelector:@selector(graphForProperty:)]) {
            NSString *graph = [(id<ABKNetworkResponseGraph>)cls graphForProperty:property.name];
            if (graph) {
                [properties addObject:graph];
            }
        } else if ([graphBlacklist containsObject:property.name]) {
            continue;
        } else {
            NSString *propertyGraph = property.name;
            if (modelCustomMapper) {
                NSString *mapperValue = modelCustomMapper[property.name];
                if (mapperValue.length) {
                    propertyGraph = mapperValue;
                }
            }
            if ([property.cls isSubclassOfClass:[NSArray class]] && [cls respondsToSelector:@selector(modelContainerPropertyGenericClass)]) {
                NSDictionary *genericClassDic = [cls modelContainerPropertyGenericClass];
                Class elementClass = genericClassDic[property.name];
                if (elementClass) {
                    NSString *elementGraph = [self graphForClass:elementClass];
                    propertyGraph = [NSString stringWithFormat:@"%@{%@}", propertyGraph, elementGraph];
                }
            } else if ([property.cls isSubclassOfClass:[ABKBaseItem class]]) {
                NSString *elementGraph = [self graphForClass:property.cls];
                propertyGraph = [NSString stringWithFormat:@"%@{%@}", propertyGraph, elementGraph];
            }
            [properties addObject:propertyGraph];
        }
    }
    return [properties componentsJoinedByString:@","];
}

@end
