//
//  ABKNetwokWeakAccessory.h
//  ABKFoundation
//
//  Created by Bengang on 2018/7/6.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

@interface ABKNetwokWeakAccessory : NSObject <YTKRequestAccessory>

@property (nonatomic, weak) NSObject<YTKRequestAccessory> *accessory;

- (instancetype)initWithAccessory:(NSObject<YTKRequestAccessory> *)accessory;

@end
