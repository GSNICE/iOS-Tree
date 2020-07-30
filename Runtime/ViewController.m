//
//  ViewController.m
//  Runtime
//
//  Created by Gavin on 2020/7/15.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"

#import <objc/message.h>
#import <objc/runtime.h>

#import "Cat.h"
#import "Dog.h"
#import "Panda.h"
#import "Bird.h"
#import "Person.h"
#import "Man.h"
#import "UIButton+Property.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *associatedButton;

- (IBAction)didClickToAssociatedButton:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  消息机制
//    [self messageMechanism];
    //  发送消息
//    [self sendMessage];
    //  交换方法
//    [self changeMethod];
    //  关联属性
//    [self associatedAttributes];
    //  动态添加方法
//    [self addFanDynamically];
    //  字典转模型
//    [self dictionaryToModel];
    //  消息转发
    [self messageForwarding];
}
#pragma mark - 消息机制
- (void)messageMechanism {
    // 通过类名获取类
    Class catClass = objc_getClass("Cat");

    //注意Class实际上也是对象，所以同样能够接受消息，向Class发送alloc消息
    Cat *cat = objc_msgSend(catClass, @selector(alloc));

    //发送init消息给Cat实例cat
    cat = objc_msgSend(cat, @selector(init));

    //发送eat消息给cat，即调用eat方法
    objc_msgSend(cat, @selector(eat));

    //汇总消息传递过程
    objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass("Cat"), sel_registerName("alloc")), sel_registerName("init")), sel_registerName("eat"));
}

#pragma mark - 发送消息
- (void)sendMessage {
    // 创建person对象
    Panda *panda = [[Panda alloc] init];

    // 1.调用对象方法
    [panda eat];

    // 2.本质：让对象发送消息
    objc_msgSend(panda, @selector(eat));

    // 调用类方法的方式：两种
    // 3.第一种通过类名调用
    [Panda eat];
    // 4.第二种通过类对象调用
    [[Panda class] eat];

    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 5.本质：让类对象发送消息
    objc_msgSend([Panda class], @selector(eat));
}

#pragma mark - 交换方法
- (void)changeMethod {
    // ===================== 案例一 =====================
    // 需求：给 imageNamed 方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法 + (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换 imageNamed 和 imageWithNamed 的实现，就能调用 imageWithNamed，间接调用 imageWithNamed 的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
    if (image == nil) {
        NSLog(@"在 ViewController 中判断 image 未加载成功");
    }
    // ===================== 案例二 =====================
    objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass("Dog"), sel_registerName("alloc")), sel_registerName("init")), sel_registerName("eat"));
}

#pragma mark - 类\对象的关联对象(动态关联属性)
- (void)associatedAttributes {
    // ===================== 案例一 =====================
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.name = @"关联属性";
    NSLog(@"%@",button.name);
    // ===================== 案例二 =====================
    // 传递多参数
    objc_setAssociatedObject(self.associatedButton, "suppliers_id", @"1", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self.associatedButton, "warehouse_id", @"2", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (IBAction)didClickToAssociatedButton:(UIButton *)sender {
    NSString *warehouse_id = objc_getAssociatedObject(sender, "warehouse_id");
    NSString *suppliers_id = objc_getAssociatedObject(sender, "suppliers_id");
    NSLog(@"AssociatedButton=>[warehouse_id]:%@,[suppliers_id]:%@",warehouse_id,suppliers_id);
}

#pragma mark - 动态添加方法
- (void)addFanDynamically {
    Person *person = [[Person alloc] init];
    // ===================== 案例一 =====================
    // 默认 person，没有实现 eat 方法，可以通过 performSelector 调用，但是会报错。
    // 动态添加方法就不会报错
    [person performSelector:@selector(eat)];
    // ===================== 案例二 =====================
    #pragma GCC diagnostic ignored "-Wundeclared-selector"
    [person performSelector:@selector(run:) withObject:@20];
}

#pragma mark - 字典转模型 KVC
- (void)dictionaryToModel {
    // ===================== 案例一 ======================
    Man *man1 = [[Man alloc] init];
    NSDictionary *dic1 = @{
        @"name":@"Gavin",
        @"user_id":@"009",
        @"address:":@"北京市朝阳区",
        @"tel":@"18300000000"
    };
    [dic1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [man1 setValue:obj forKey:key];
    }];
    NSLog(@"Person1 Dic1=>Name:%@,UserID:%@,Address:%@",man1.name,man1.user_id,man1.address);
    // ===================== 案例二 =====================
    NSDictionary *dic2 = @{
        @"name":@"Juliet",
        @"user_id":@"006",
        @"address:":@"北京市海淀区",
        @"tel":@"15700000000"
    };
    Man *man2 = [Man modelWithDict:dic2];
    NSLog(@"Person2 Dic2=>Name:%@,UserID:%@,Address:%@",man2.name,man2.user_id,man2.address);
}

#pragma mark - 消息转发
- (void)messageForwarding{
    Bird *bird = [[Bird alloc] init];
    [bird performSelector:@selector(eat)];
}

@end
