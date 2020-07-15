//
//  ViewController.m
//  Block
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Block 链式编程
    [self blockAsChainProgramming1];
    
    //  Block 函数式编程
    [self blockAsFunctionalProgramming];
    
    //  Block 链式编程
    [self blockAsChainProgramming2];
    
    //  Block 函数式编程
    [self blockAsFunctionalProgramming];
}

#pragma mark - Block 链式编程1
- (void)blockAsChainProgramming1 {
    self.person.name(@"Gavin").age(28).gender(PersonGender_Man);
}

#pragma mark - Block 链式编程2
- (void)blockAsChainProgramming2 {
    self.person.name(@"Juliet").age(27).gender(PersonGender_Woman);
}

#pragma mark - Block 函数式编程
- (void)blockAsFunctionalProgramming {
    [self.person getPersonInfo:^(NSString * _Nonnull info) {
        NSLog(@"个人信息：%@",info);
    }];
}

#pragma mark - Lazying...
- (Person *)person {
    if (!_person) {
        _person = [Person new];
    }
    return _person;
}

@end
