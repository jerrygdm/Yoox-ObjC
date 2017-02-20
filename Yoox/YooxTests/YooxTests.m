//
//  YooxTests.m
//  YooxTests
//
//  Created by Gianmaria Dal Maistro on 19/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageUrlGenerator.h"

#define kBaseImageUrlString @"http://cdn.yoox.biz/"

@interface YooxTests : XCTestCase

@property (nonatomic, strong) ImageUrlGenerator *urlGenerator;

@end

@implementation YooxTests

- (void)setUp
{
    [super setUp];
    
    self.urlGenerator = [[ImageUrlGenerator alloc] initWithBaseUrl:kBaseImageUrlString];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUrlGenerator
{
    NSString *result = [self.urlGenerator generateUrlFromString:@"39432350JM"];
    
    XCTAssertTrue([result isEqualToString:@"http://cdn.yoox.biz/39/39432350JM_11_f.jpg"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
