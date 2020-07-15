//
//  ViewController.m
//  HitTest
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //  如调用此方法则代表触摸事件没有被 hitTest 判断拦截（触摸了视图上的按钮点）
    NSLog(@"ViewController->%s",__func__);
}

@end
