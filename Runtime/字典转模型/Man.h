//
//  Man.h
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Man : NSObject
{
    NSString *IDCard;
    NSString *birthday;
    NSString *hobby;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *address;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (void)class_copyPropertyListAndclass_copyIvarList;

@end

NS_ASSUME_NONNULL_END
