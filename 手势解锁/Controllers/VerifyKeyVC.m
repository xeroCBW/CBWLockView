//
//  VerifyKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "VerifyKeyVC.h"
#import "LockView.h"
#import "CBWCircleView.h"

@interface VerifyKeyVC()<LockViewDelegate>
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;
@end

@implementation VerifyKeyVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"验证密码";
    self.view.backgroundColor = [UIColor whiteColor];
    //判断是否
    [self checkHasSetKey];
    
    LockView *lockView = [[LockView alloc]init];
    lockView.frame = CGRectMake(0, 0, 300, 300);
    lockView.backgroundColor = [UIColor lightGrayColor];
    lockView.center = self.view.center;
    lockView.delegate = self;
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, CGRectGetMinY(lockView.frame) - 60, 300,40);
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.tipsLabel = label;
    
    
//    lockView.lockViewHandle = ^(NSString *str,LockView *lockView){
//        
//        [self handleKeyWith:lockView str:str];
//        
//    };
    
    
    [self.view addSubview:lockView];

}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
    
}

#pragma mark - delegate

-(void)lockView:(LockView *)lockView setKeyActionEndStr:(NSString *)str{
    
    [self handleKeyWith:lockView str:str];
}

#pragma mark - 判断是否设置过密码

- (void)handleKeyWith:(LockView *)lockView str:(NSString *)str{
    NSString *gestureKeyStr = [LockConst getGestureWithKey:gestureKey];
    __weak typeof(self) weakSelf = self;
    //不为空值
    if ([gestureKeyStr isEqualToString:str]) {
        //相等直接返回
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }else{
        
        //不返回,需要提示
        NSLog(@"两次不统一,需要重新设置");
        weakSelf.tipsLabel.text = verifyKeyTips;
        [weakSelf.tipsLabel.layer shake];
        //将选中状态变成错误,动画延迟一会
        for (CBWCircleView *circleView in lockView.selectedButtonArray) {
            circleView.state = CircleViewStateError;
        }
        [lockView  setNeedsDisplay];
        
        
    }

}

- (void)checkHasSetKey{
    
    NSString *gestureKeyStr = [LockConst getGestureWithKey:gestureKey];
    
    if ([self isBlankString:gestureKeyStr]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您还没有设置密码,请返回首页设置密码" message: nil preferredStyle:UIAlertControllerStyleAlert];
                
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
       
        [alertVC addAction:yes];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }

}

@end
