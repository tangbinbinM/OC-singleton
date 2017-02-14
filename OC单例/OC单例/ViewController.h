//
//  ViewController.h
//  OC单例
//
//  Created by YiGuo on 2017/2/14.
//  Copyright © 2017年 tbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
+ (ViewController *)defaultInstance;
+(NSUserDefaults *)userDefaults;
+(NSUserDefaults *)userDefaultsIsDanger;
@end

