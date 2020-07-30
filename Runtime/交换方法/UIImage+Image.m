//
//  UIImage+Image.m
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>
@implementation UIImage (Image)

#pragma mark - 加载分类到内存的时候调用
+ (void)load
{
    // ========== 交换方法 ==========
    // 获取 imageWithNamed 方法地址
    Method imageWithNamed = class_getClassMethod(self, @selector(imageWithNamed:));

    // 获取 imageWithNamed 方法地址
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));

    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageWithNamed, imageNamed);
}

// 不能在分类中重写系统方法 imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用 super。

#pragma mark - 既能加载图片又能打印
+ (instancetype)imageWithNamed:(NSString *)name
{
    // 这里调用 imageWithNamed，相当于调用 imageNamed
    UIImage *image = [self imageWithNamed:name];

    if (image == nil) {
        NSLog(@"加载空的图片");
    }

    return image;
}
@end
