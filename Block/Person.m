//
//  Person.m
//  Block
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "Person.h"

@interface Person()

@property (nonatomic, copy) NSString *personName;
@property (nonatomic, assign) NSInteger personAge;
@property (nonatomic, assign) PersonGender personGender;

@end

@implementation Person

#pragma mark - 名字
- (Person *(^)(NSString *))name {
    Person *(^block)(NSString *) = ^Person *(NSString *name) {
        self.personName = name;
        NSLog(@"Name:%@\n",name);
        return self;
    };
    return block;
}
#pragma mark - 年龄
- (Person *(^)(NSInteger))age {
    return ^Person *(NSInteger age) {
        self.personAge = age;
        NSLog(@"Age:%ld\n",(long)age);
        return self;
    };
}
#pragma mark - 性别
- (Person *(^)(PersonGender))gender {
    return ^Person *(PersonGender gender) {
        self.personGender = gender;
        [self analysisOfGenderWithGender:gender];
        return self;
    };
}
#pragma mark 解析性别
- (void)analysisOfGenderWithGender:(PersonGender)gender {
    switch (gender) {
        case PersonGender_Man:
            NSLog(@"Gender:Man\n");
            break;
        case PersonGender_Woman:
            NSLog(@"Gender:Woman\n");
            break;
        default:
            break;
    }
}
#pragma mark - 获取个人信息
- (void)getPersonInfo:(void(^)(NSString *info))personInfo {
    NSString *gender;
    switch (self.personGender) {
        case PersonGender_Man:
            gender = @"Man";
            break;
        case PersonGender_Woman:
            gender = @"Woman";
            break;
        default:
            break;
    }
    NSString *info = [NSString stringWithFormat:@"Person:%@,Age:%ld,Gender:%@",self.personName,self.personAge,gender];
    personInfo(info);
}

@end
