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



#define ScreenHW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)settingKeyAction:(id)sender {
    
    SettingKeyVC *settingVC = [[SettingKeyVC alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];

    
}


- (IBAction)verifyKeyAction:(id)sender {
    
    
    VerifyKeyVC *verifyVC = [[VerifyKeyVC alloc]init];
    
    [self.navigationController pushViewController:verifyVC animated:YES];

}


@end
