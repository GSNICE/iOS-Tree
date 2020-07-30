//
//  Bird.m
//  Runtime
//
//  Created by Gavin on 2020/7/30.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "Bird.h"

@implementation Bird

//  第一步，消息接收者没有找到对应的方法时候，会先调用此方法，可在此方法实现中动态添加新的方法
//  返回 YES 表示相应 selector 的实现已经被找到，或者添加新方法到了类中，否则返回 NO
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

//  第二步， 如果第一步的返回NO或者直接返回了 YES 而没有添加方法，该方法被调用
//  在这个方法中，我们可以指定一个可以返回一个可以响应该方法的对象， 注意如果返回self就会死循环
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

//  第三步， 如果 forwardingTargetForSelector: 返回了 nil，则该方法会被调用，系统会询问我们要一个合法的『类型编码(Type Encoding)』
//  若返回 nil，则不会进入下一步，而是无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 当实现了此方法后，- doesNotRecognizeSelector: 将不会被调用
// 在这里进行消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 在这里可以改变方法选择器
    [anInvocation setSelector:@selector(unknown)];
    // 改变方法选择器后，需要指定消息的接收者
    [anInvocation invokeWithTarget:self];
}

- (void)unknown {
    NSLog(@"unkown method.......");
}

// 如果没有实现消息转发 forwardInvocation  则调用此方法
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"unresolved method ：%@", NSStringFromSelector(aSelector));
}

@end
