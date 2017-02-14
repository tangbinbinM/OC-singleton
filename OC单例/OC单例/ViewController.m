//
//  ViewController.m
//  OC单例
//
//  Created by YiGuo on 2017/2/14.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "ViewController.h"
#import "testStandardViewControllerA.h"
@interface ViewController ()

@end

@implementation ViewController
static NSUserDefaults *defaultsIsDanger;
//线程不安全的写法
///* 单线程下运行正常，但是在多线程下就有问题了。如果两个线程同时运行到判断defaultsIsDanger是否为nil的if语句，且defaultsIsDanger没有创建时候，那么2个线程都会创建一个实例，此时单例就不在满足单例模式的要求了。为了保证多线程环境下我们还是只能得到类型的一个实例，需要加上一个同步锁。即第一种实现方法 互斥锁方式*/
+(NSUserDefaults *)userDefaultsIsDanger{
    if (defaultsIsDanger == nil) {
        defaultsIsDanger = [[NSUserDefaults alloc] init];
    }
    return defaultsIsDanger;
}
/*
 1.什么是单例模式
 保证一个类有且仅有一个实例对像，并提供一个公开的访问接口
 2.单例的应用场景
 1.封装一个共享的资源
 2.提共一个固定的实例创建方法
 3.提供一个标准的实例访问接口
 */

//第一种实现方法 互斥锁方式
static ViewController *instance;
+ (ViewController *)defaultInstance{
    //    （用到了关键字@synchronized是为了保证我们的单例的线程级别的安全，可以适用于多线程模式下。）static变量sharedCLDelegate用于存储一个单例的指针
    //    @synchronized 的作用是创建一个互斥锁，保证此时没有其它线程对self对象进行修改。这个是objective-c的一个锁定令牌，防止self对象在同一时间内被其它线程访问，起到线程的保护作用。
    @synchronized (self){
        if (instance == nil) {
            instance = [[ViewController alloc] init];
        }
    }
    //线程安全(逻辑复杂)但更安全
    //  这里还不是很完美。我们还是设想两个线程同时想创建一个实例，由于同一时刻只能有一个能得到同步锁，每当第一个线程锁加上锁，第二个线程只能等待，当第一个线程发现实例还没有创建时，它创建一个实例。接着第一个线程释放同步锁，此时第二个线程可以加上同步锁，并运行接下来的 代码。我们每次得到单例实例，都会试图加上一个线程锁，而加锁是一个非常耗时的操作，在没有必要的时候，我们尽量要避免。
    //    if (defaultsIsDanger == nil) {
    //        @synchronized (self){
    //            if (instance == nil) {
    //                instance = [[ViewController alloc] init];
    //            }
    //        }
    //    }
    return instance;
}


//第二种方法 GCD 最优算法(官方推荐)
/**单例模式对外的唯一接口，用到的dispatch_once函数在一个应用程序内只会执行一次，且dispatch_once能确保线程安全
 */
static NSUserDefaults *defaults;
+(NSUserDefaults *)userDefaults{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] init];
    });
    return defaults;
}

//重写allocWithZone方法，用来保证其他人直接使用alloc和init试图获得一个新实力的时候不产生一个新实例，
//+(id)allocWithZone:(NSZone *)zone{
//    @synchronized(self){
//        if (!test) {
//            test = [super allocWithZone:zone]; //确保使用同一块内存地址
//            return test;
//        }
//        return nil;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    btn.frame = CGRectMake(100, 100, 50, 40);
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(test01:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)test01:(UIButton *)sender{
    testStandardViewControllerA *vc = [[testStandardViewControllerA alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
