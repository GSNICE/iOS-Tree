//
//  Dog.m
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

@implementation Dog

+ (void) load {
    Method eatMethod = class_getInstanceMethod(self, @selector(eat));
    Method shirtMethod = class_getInstanceMethod(self, @selector(shirt));

    method_exchangeImplementations(eatMethod, shirtMethod);
}

- (void)eat {
    NSLog(@"- Dog eat...!");
}

- (void)shirt {
    //  要想还执行 eat 方法，则调用交换 eat 方法的方法
    [self shirt];
    NSLog(@"- Dog shirt...!");
}

@end
