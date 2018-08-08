//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Bengang on 2018/8/8.
//  Copyright © 2018 Bengang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ABKFoundation/ABKJSONWrapper.h>

@interface ExampleTests : XCTestCase

@property (nonatomic, strong) NSDictionary *json;

@end

@implementation ExampleTests

- (void)setUp {
    [super setUp];
    self.json = @{@"name": @"zhanbgsan",
                  @"age": @(24),
                  @"address": @[@{@"name": @"beijing",
                                  @"id": @"123"},
                                @{@"name": @"beijing",
                                  @"id": @"123"}]};
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    ABKJSONWrapper *jsonWrapper = [ABKJSONWrapper wrapperWithJSON:self.json];
    NSString *name = jsonWrapper[@"address"][0][@"name"].string;
    NSInteger age = ((ABKJSONWrapper *)jsonWrapper[@"age"]).integerValue;
    XCTAssertEqual(name, @"beijing");
    XCTAssertEqual(age, 24);
    
    NSArray *arr = jsonWrapper[@"address"].array;
    NSLog(@"arr: %@", arr);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
