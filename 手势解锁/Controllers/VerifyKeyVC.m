//
//  VerifyKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "VerifyKeyVC.h"
#import "LockView.h"
#import "LockConst.h"
#import "CALayer+Anim.h"
#import "CBWCircleView.h"

@interface VerifyKeyVC()
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;
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
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, CGRectGetMinY(lockView.frame) - 60, 300,40);
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.tipsLabel = label;

    
    
    __weak typeof(self) weakSelf = self;
    lockView.lockViewHandle = ^(NSString *str,LockView *lockView){
        
        NSString *gestureKeyStr = [LockConst getGestureWithKey:gestureKey];
        if (gestureKeyStr == nil) {
            //值为空,还没有设置
        }else{
            //不为空值
            if ([gestureKeyStr isEqualToString:str]) {
                //相等直接返回
                [self.navigationController popViewControllerAnimated:YES];
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
    };
    
    
    [self.view addSubview:lockView];

}





@end
