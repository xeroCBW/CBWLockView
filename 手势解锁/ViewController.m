//
//  ViewController.m
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "ViewController.h"
#import "SettingKeyVC.h"
#import "VerifyKeyVC.h"
#import "TestView.h"



#define ScreenHW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    
    [LockConst saveGesture:nil Key:gestureKey];
    
}


- (IBAction)settingKeyAction:(id)sender {
    
    SettingKeyVC *settingVC = [[SettingKeyVC alloc]init];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    [self presentViewController:navi animated:YES completion:nil];

    
}


- (IBAction)verifyKeyAction:(id)sender {
    
    
    VerifyKeyVC *verifyVC = [[VerifyKeyVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:verifyVC];
    [self presentViewController:nav animated:YES completion:nil];

}

- (IBAction)test:(id)sender {
    TestView *test = [[TestView alloc]init];
    
    
    [self.navigationController pushViewController:test animated:YES];
    
}

@end
