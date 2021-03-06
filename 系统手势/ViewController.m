//
//  ViewController.m
//  系统手势
//
//  Created by Gavin on 2020/7/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setupTapGestue];
//    [self setupLongPress];
    [self setupSwipe];
}

#pragma mark - TapGestue
- (void)setupTapGestue{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    tap.delegate = self;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
}
- (void)tapEvent:(UITapGestureRecognizer *)gesture{
    NSLog(@"%s",__func__);
}

#pragma mark - LongPressGesture
- (void)setupLongPress{
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:longpress];
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%s",__func__);
    }
}

#pragma mark - SwipeGesture
- (void)setupSwipe{
    //系统默认一个UISwipeGestureRecognizer手势只有1个方向
    //如果要为1个控件监听多个不同方向的轻扫，则可以添加多个手势
    self.imageView.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeGest1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGest1.direction = UISwipeGestureRecognizerDirectionUp;
    [self.imageView addGestureRecognizer:swipeGest1];
    
    UISwipeGestureRecognizer *swipeGest2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGest2.direction = UISwipeGestureRecognizerDirectionDown;
    [self.imageView addGestureRecognizer:swipeGest2];
    
    UISwipeGestureRecognizer *swipeGest3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGest3.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeGest3];
    
    UISwipeGestureRecognizer *swipeGest4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeGest4.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeGest4];
}
- (void)swipe:(UISwipeGestureRecognizer *)gesture{
    NSLog(@"%s",__func__);
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

@end
