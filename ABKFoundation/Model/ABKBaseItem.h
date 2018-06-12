//
//  BGBaseItem.h
//  Run
//
//  Created by Bengang on 23/11/2017.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface ABKBaseItem : NSObject <YYModel, NSCoding, NSCopying>

+ (instancetype)modelWithJSON:(id)JSON;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;

- (void)mergeItemValue:(ABKBaseItem *)item;

@end
