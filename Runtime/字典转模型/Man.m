//
//  Man.m
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "Man.h"
#import <objc/runtime.h>

@implementation Man

// Ivar:成员变量 以下划线开头
// Property:属性
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    //  class_copyPropertyList与class_copyIvarList区别    
    id objc = [[self alloc] init];
    
    // runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
    // 1.获取模型中所有成员变量 key
    // 获取哪个类的成员变量
    // count:成员变量个数
    unsigned int count = 0;
    // 获取成员变量数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 获取成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        // 获取key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 去字典中查找对应value
        // key:user  value:NSDictionary
        
        id value = dict[key];
        
        // 二级转换:判断下 value 是否是字典,如果是,字典转换成对应的模型
        // 并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            // 字典转换成模型 userDict => User模型
            // 转换成哪个模型

            // 获取类
            Class modelClass = NSClassFromString(ivarType);
            
            value = [modelClass modelWithDict:value];
        }
        
        // 给模型中属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
        
    return objc;
}

- (void)class_copyPropertyListAndclass_copyIvarList{
    id classObject = objc_getClass([@"Man" UTF8String]);
    
    unsigned int count = 0;
    unsigned int icount = 0;
    
    //  获取属性列表
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    //  获取成员变量列表
    Ivar *ivars = class_copyIvarList(classObject, &icount);
    
    NSLog(@"Count:%d,ICount:%d",count,icount);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        //  获取属性名称
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName:%@",propertyName);
    }
    
    for (int i = 0; i < icount; i++) {
        NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        NSLog(@"ivarName:%@",memberName);
    }
}

// 重写系统方法? 1.想给系统方法添加额外功能 2.不想要系统方法实现
// 系统找不到就会调用这个方法,报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"UndefinedKey: %@ Key:%@ Value:%@",self,key,value);
}

@end
