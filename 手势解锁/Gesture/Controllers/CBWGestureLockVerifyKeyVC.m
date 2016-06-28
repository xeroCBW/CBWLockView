//
//  VerifyKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "CBWGestureLockVerifyKeyVC.h"
#import "CBWGestureLockView.h"
#import "CBWCircleView.h"

@interface CBWGestureLockVerifyKeyVC()<LockViewDelegate>
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;

/** 累计错误次数*/
@property (nonatomic ,assign) int count;

@end

@implementation CBWGestureLockVerifyKeyVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"验证密码";
    self.view.backgroundColor = [UIColor whiteColor];

    //原理上不能设置退出,要么忘记密码

    
    //错误次数设置
    self.count = errorCount;
    //判断是否
    [self checkHasSetKey];
    
    CBWGestureLockView *lockView = [[CBWGestureLockView alloc]init];
    lockView.frame = CGRectMake(0, 0, 300, 300);
    lockView.backgroundColor = lockViewBackgroupColor;
    lockView.center = self.view.center;
    lockView.delegate = self;
    lockView.index = self.index;
    [self.view addSubview:lockView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, CGRectGetMinY(lockView.frame) - 60, 300,40);
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.tipsLabel = label;
    
    CGRect frame = CGRectMake(CGRectGetMinX(lockView.frame), CGRectGetMaxY(lockView.frame) + 20, 150, 50);
    UIButton *forgetGestureKeyButton = [[UIButton alloc]initWithFrame:frame];
    [forgetGestureKeyButton setTitle:@"忘记手势密码？" forState:UIControlStateNormal];
//    forgetGestureKeyButton.backgroundColor = [UIColor greenColor];
    forgetGestureKeyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [forgetGestureKeyButton addTarget:self action:@selector(forgetGestureKwyAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetGestureKeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetGestureKeyButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:forgetGestureKeyButton];
    
    CGRect frame1 = CGRectMake(CGRectGetMaxX(lockView.frame) - 150, CGRectGetMaxY(lockView.frame) + 20, 150, 50);
    UIButton *changeUserButton = [[UIButton alloc]initWithFrame:frame1];
    [changeUserButton setTitle:@"切换用户" forState:UIControlStateNormal];
    changeUserButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [changeUserButton addTarget:self action:@selector(ChangeUserAction) forControlEvents:UIControlEventTouchUpInside];
    [changeUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeUserButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:changeUserButton];
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
    
}

#pragma mark - delegate

-(void)lockView:(CBWGestureLockView *)lockView setKeyActionEndStr:(NSString *)str{
    
    [self handleKeyWith:lockView str:str];
}

#pragma mark - 判断是否设置过密码

- (void)handleKeyWith:(CBWGestureLockView *)lockView str:(NSString *)str{
    NSString *gestureKeyStr = [CBWGestureLockConst getGestureWithKey:gestureKey];
    __weak typeof(self) weakSelf = self;
    //不为空值
    if ([gestureKeyStr isEqualToString:str]) {
        //相等直接返回
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        self.count --;
        

        if (self.count < 1) {
            [self gestureUnlockFailed];
            return;
        }
        
        //不返回,需要提示
        weakSelf.tipsLabel.text = [NSString stringWithFormat:@"密码绘制错误！还可以绘制%d次",self.count];
        
        [weakSelf.tipsLabel.layer shake];
        //将选中状态变成错误,动画延迟一会
        
        for (int i = 0;i < lockView.selectedButtonArray.count ; i ++) {
            CBWCircleView *circleView = lockView.selectedButtonArray[i];
            circleView.state = CircleViewStateError;
            
            if (i == lockView.selectedButtonArray.count - 1) {
                circleView.state = CircleViewStateLastOneError;
            }
        }
        
        [lockView  setNeedsDisplay];
    }

}

- (void)checkHasSetKey{
    
    NSString *gestureKeyStr = [CBWGestureLockConst getGestureWithKey:gestureKey];
    
    if ([self isBlankString:gestureKeyStr]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您还没有设置密码,请返回首页设置密码" message: nil preferredStyle:UIAlertControllerStyleAlert];
                
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        [alertVC addAction:yes];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }

}



- (void)gestureUnlockFailed{
    
   
    [CBWGestureLockConst deleteGestureWithKey:gestureKey];
    
    NSString *tipsStr = [NSString stringWithFormat:@"您已经错误%d次,需要重新登入并设置手势密码",errorCount];
    
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:tipsStr message: nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertVC addAction:yes];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        

}

#pragma mark - buttonAction

- (void)forgetGestureKwyAction{
    
    
    //你需要再次登录以重新设置
   // 忘记手势密码？
        
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"忘记手势密码？" message: @"你需要再次登录以重新设置" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alertVC addAction:yes];
    [alertVC addAction:no];
[self presentViewController:alertVC animated:YES completion:nil];

    
}

- (void)ChangeUserAction{
    //切换用户
    //你需要再次登录以切换用户
 
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"切换用户" message: @"你需要再次登录以切换用户" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:yes];
    [alertVC addAction:no];
[self presentViewController:alertVC animated:YES completion:nil];
}


@end
