//
//  testStandardViewControllerA.m
//  OC单例
//
//  Created by YiGuo on 2017/2/14.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import "testStandardViewControllerA.h"
#import "ViewController.h"
@interface testStandardViewControllerA ()

@end

@implementation testStandardViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor grayColor];
    //1.
    //判断地址是否相同如果相同则单例成功
    NSLog(@"test01 %@",[ViewController defaultInstance]);
    NSLog(@"test02 %@",[ViewController defaultInstance]);
    //2
    NSLog(@"test03 %@",[ViewController userDefaults]);
    NSLog(@"test04 %@",[ViewController userDefaults]);
    //线程不安全
    NSLog(@"testIsDanger05 %@",[ViewController userDefaultsIsDanger]);
    NSLog(@"testIsDanger06 %@",[ViewController userDefaultsIsDanger]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
