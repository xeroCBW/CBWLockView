//
//  ViewController.m
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
#import "CBWCircleView.h"

#define ScreenHW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    LockView *lockView = [[LockView alloc]init];
    lockView.frame = CGRectMake(0, 0, 300, 300);
    lockView.backgroundColor = [UIColor lightGrayColor];
    lockView.center = self.view.center;
    lockView.block = ^(NSString *str){
        NSLog(@"选中的button编号为:%@",str);
    };

    
    [self.view addSubview:lockView];
    
    
    }

@end
