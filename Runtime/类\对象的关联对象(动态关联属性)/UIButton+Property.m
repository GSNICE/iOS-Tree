//
//  UIButton+Property.m
//  Runtime
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "UIButton+Property.h"
#import <objc/runtime.h>

static char UIButtonName;

@implementation UIButton (Property)

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &UIButtonName, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, &UIButtonName);
}

@end
