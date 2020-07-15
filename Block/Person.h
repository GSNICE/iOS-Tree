//
//  Person.h
//  Block
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PersonGender) {
    PersonGender_Man,       //  男性
    PersonGender_Woman      //  女性
};

@interface Person : NSObject

/// 名字
- (Person *(^)(NSString *))name;

/// 年龄
- (Person *(^)(NSInteger))age;

/// 性别
- (Person *(^)(PersonGender))gender;

/// 获取个人信息
/// @param personInfo 个人信息
- (void)getPersonInfo:(void(^)(NSString *info))personInfo;

@end

NS_ASSUME_NONNULL_END
