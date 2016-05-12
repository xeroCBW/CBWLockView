//
//  VerifyKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "VerifyKeyVC.h"
#import "LockView.h"

@interface VerifyKeyVC()

@end

@implementation VerifyKeyVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"验证密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    LockView *lockView = [[LockView alloc]init];
    lockView.frame = CGRectMake(0, 0, 300, 300);
    lockView.backgroundColor = [UIColor lightGrayColor];
    lockView.center = self.view.center;
    
    
    lockView.lockViewHandle = ^(NSString *str,LockView *lockView){
        NSLog(@"选中的button编号为:%@",str);
    };
    
    
    [self.view addSubview:lockView];

}





@end
