//
//  ViewController.m
//  Runtime
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+propertyTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  关联属性
    [self associatedAttributes];
}

- (void)associatedAttributes {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.name = @"关联属性";
    NSLog(@"%@",button.name);
}

@end
