//
//  SettingKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "SettingKeyVC.h"
#import "LockView.h"
#import "CBWCircleView.h"
#import "CALayer+Anim.h"
#import "LockConst.h"
@interface SettingKeyVC ()

/** 手势密码字符串*/
@property (nonatomic ,copy) NSString *keyStr;
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;
@end

@implementation SettingKeyVC


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"设置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LockView *lockView = [[LockView alloc]init];
    lockView.frame = CGRectMake(0, 0, 300, 300);
    lockView.backgroundColor = [UIColor lightGrayColor];
    lockView.center = self.view.center;
    
   __weak typeof(self) weakSelf = self;
    lockView.lockViewHandle = ^(NSString *str,LockView *lockView){
        NSLog(@"选中的button编号为:%@",str);
        [weakSelf handleWithStr:str lockView:lockView];
        
    };
    
    [self.view addSubview:lockView];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, CGRectGetMinY(lockView.frame) - 60, 300,40);
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.tipsLabel = label;

}
-(void)dealloc{
    NSLog(@"%s",__func__);
}
#pragma mark - private
- (void)handleWithStr:(NSString *)str lockView:(LockView *)lockView{
    
      __weak typeof(self) weakSelf = self;
    
    //第一次进来直接保存
    if (weakSelf.keyStr == nil) {
         weakSelf.keyStr = str;
        weakSelf.tipsLabel.text = firstTips;
    }else{
        //后面进来
        
        if ([weakSelf.keyStr isEqualToString:str]) {
            //将密码保存到本地
            //就返回
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            //不返回,需要提示
            NSLog(@"两次不统一,需要重新设置");
             weakSelf.tipsLabel.text = errorTips;
            [weakSelf.tipsLabel.layer shake];
            //将选中状态变成错误,动画延迟一会
            for (CBWCircleView *circleView in lockView.selectedButtonArray) {
                circleView.state = CircleViewStateError;
            }
            [lockView  setNeedsDisplay];
        }
        
        
    }
    
}

@end
