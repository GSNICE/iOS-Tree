//
//  Person.m
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// void(*)()
// 默认方法都有两个隐式参数，
void eat(id self,SEL _cmd)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(_cmd));
}

void run (id self, SEL _cmd, NSNumber *number) {
    NSLog(@"run for %@", number);
}

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    #pragma GCC diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(eat)) {
        // 动态添加eat方法

        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), eat, "v@:");
    }else if(sel == NSSelectorFromString(@"run:")) {
        class_addMethod(self, @selector(run:), run, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

// 重写系统方法? 1.想给系统方法添加额外功能 2.不想要系统方法实现
// 系统找不到就会调用这个方法,报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"UndefinedKey: %@ Key:%@ Value:%@",self,key,value);
}

@end
