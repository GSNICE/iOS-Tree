//
//  ShelterView.m
//  HitTest
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ShelterView.h"

@implementation ShelterView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    /**
     * 需求：不管点击按钮还是view都交给button处理
     * 思路：在 view 的 hitTest 方法中寻找最合适的 view，那么返回 nil 告诉系统 view 不是最合适的 view，那么系统则认为按钮是最合适的 view
     * return nil;
     */
    
    // 需求，在 view 上点击，如果点击范围在 Button 上则由 Button 进行处理事件，否则交给 view 处理事件。
    
    UIView *button = nil;
    for (UIView *subView in self.superview.subviews) {
        // 判断事件点是否在按钮上
        if ([subView isKindOfClass:[UIButton class]]) {
            button = subView;
        }
        
        CGPoint btnPoint = [self convertPoint:point toView:button];
        if ([button pointInside:btnPoint withEvent:event]) {
            return button;
        }else {
            // 此时代表事件触摸点不在 Button 上，但是也不能写 nil，写 nil 的话点击屏幕上的其他地方系统会寻找最合适的 view，此时返回 nil（ return nil;），则代表 view 不是最合适的 view,那么此时点击屏幕上除了按钮之外的区域，最合适的 view 就是控制器上面的 view
            return [super hitTest:point withEvent:event];
        }
    }
    return nil;
}

@end
