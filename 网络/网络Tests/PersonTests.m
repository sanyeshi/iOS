//
//  PersonTests.m
//  网络
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Person.h"

/*
    1.目标:模型类
    2.用处:在不基于UI的情况下，确保模型类逻辑的正确性；
    3.命名:模型类+Tests
 */
@interface PersonTests : XCTestCase

@end

@implementation PersonTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
    测试驱动开发
    写测试用例，通过断言的方式，来测试模型数据的正确性；
 */

- (void)testExample
{
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    Person * person=[[Person alloc] init];
    //边界测试
    person.age=17;
    person.age=19;
    person.age=59;
    person.age=60;
    person.age=61;
    XCTAssertTrue(person.age>=18,@"年龄必须大于或等于18");
    XCTAssertTrue(person.age<=60,@"年龄必须小于等于60");
    XCTAssertEqual(person.age,18,@"");
}

-(void) testName
{
    Person * p=[[Person alloc] init];
    p.name=@"aaaa";
    XCTAssertNotNil(p.name,@"姓名不能为空");
    //XCTAssertTrue(p.name!=nil,@"用户姓名不能为空");
    //XCTAssertFalse(p.name==nil,"用户姓名不能为空");
    //p.name=@"aa";
    //XCTAssertTrue(p.name.length>=3,@"用户名长度必须大于等于3");
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
