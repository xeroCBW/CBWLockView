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
#import "LockInfoView.h"

@interface SettingKeyVC ()<LockViewDelegate>

/** 手势密码字符串*/
@property (nonatomic ,copy) NSString *keyStr;
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;
/** 选中的小9宫格 view*/
@property (nonatomic ,weak)  LockInfoView *infoView;
@end

@implementation SettingKeyVC


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"设置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pay_btn_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = right;
    
    LockView *lockView = [[LockView alloc]init];
    lockView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, 200, 300, 300);
    lockView.backgroundColor = lockViewBackgroupColor;
    lockView.delegate = self;
    lockView.index = self.index;
    [self.view addSubview:lockView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2.0, CGRectGetMinY(lockView.frame) - 60, 300,40);
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.tipsLabel = label;
    self.tipsLabel.text = inputTips;
    
    LockInfoView *infoView = [[LockInfoView alloc]init];
    infoView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2.0, CGRectGetMinY(label.frame) - 60, 50,50);
    self.infoView = infoView;
    
    [self.view addSubview:infoView];

}
-(void)dealloc{
//    NSLog(@"%s",__func__);
}

#pragma mark -  delegate

- (void)lockView:(LockView *)lockView setKeyActionEndStr:(NSString *)str{
    
    NSLog(@"%@",str);
    [self handleWithStr:str lockView:lockView];
    
}



#pragma mark - private
- (void)handleWithStr:(NSString *)str lockView:(LockView *)lockView{
    
      __weak typeof(self) weakSelf = self;
    
    //由于中间加了",",所以长度要 X2
    NSLog(@"%@",str);
    
    if (str.length < 7) {
        
        weakSelf.tipsLabel.text = lengthTips;
        [weakSelf.tipsLabel.layer shake];
        
        for (int i = 0;i < lockView.selectedButtonArray.count ; i ++) {
            CBWCircleView *circleView = lockView.selectedButtonArray[i];
            circleView.state = CircleViewStateError;
            
            if (i == lockView.selectedButtonArray.count - 1) {
                circleView.state = CircleViewStateLastOneError;
            }
        }

        [lockView  setNeedsDisplay];
        
        
        return;

    }
    
    
    //第一次进来直接保存
    if (weakSelf.keyStr == nil) {
         weakSelf.keyStr = str;
        weakSelf.tipsLabel.text = firstTips;
        
        // infoView选中状态下按钮
       
        NSMutableArray *array = [NSMutableArray array];
        for (CBWCircleView *circleView in lockView.selectedButtonArray) {
            
            NSString *buttonIndex = [NSString stringWithFormat:@"%ld",circleView.tag];
            
            [array addObject:buttonIndex];
            
        }
         weakSelf.infoView.selectedButtonsArray = array;

        
        
    }else{
        //后面进来
        
        if ([weakSelf.keyStr isEqualToString:str]) {
            //将密码保存到本地
            [LockConst saveGesture:str Key:gestureKey];
            //就返回
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            //不返回,需要提示
            NSLog(@"两次不统一,需要重新设置");
             weakSelf.tipsLabel.text = setKeyerrorTips;
            [weakSelf.tipsLabel.layer shake];
            //将选中状态变成错误,动画延迟一会
//            for (CBWCircleView *circleView in lockView.selectedButtonArray) {
//                circleView.state = CircleViewStateError;
//            }
            
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
    
}


- (void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
