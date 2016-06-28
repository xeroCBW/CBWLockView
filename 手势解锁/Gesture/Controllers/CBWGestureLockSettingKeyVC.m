//
//  SettingKeyVC.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "CBWGestureLockSettingKeyVC.h"
#import "CBWGestureLockView.h"
#import "CBWCircleView.h"
#import "CBWGestureLockInfoView.h"

@interface CBWGestureLockSettingKeyVC ()<LockViewDelegate>

/** 手势密码字符串*/
@property (nonatomic ,copy) NSString *keyStr;
/** 提示的 label*/
@property (nonatomic ,weak) UILabel *tipsLabel;
/** 选中的小9宫格 view*/
@property (nonatomic ,weak)  CBWGestureLockInfoView *infoView;
@end

@implementation CBWGestureLockSettingKeyVC


-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.title = @"设置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pay_btn_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = right;
    
    CBWGestureLockView *lockView = [[CBWGestureLockView alloc]init];
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
    label.text = inputTips;
    self.tipsLabel = label;
    
    CBWGestureLockInfoView *infoView = [[CBWGestureLockInfoView alloc]init];
    infoView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2.0, CGRectGetMinY(label.frame) - 60, 50,50);
    [self.view addSubview:infoView];
    self.infoView = infoView;
   

}


#pragma mark -  delegate

- (void)lockView:(CBWGestureLockView *)lockView setKeyActionEndStr:(NSString *)str{
    
    NSLog(@"%@",str);
    [self handleWithStr:str lockView:lockView];
    
}

#pragma mark - private
- (void)handleWithStr:(NSString *)str lockView:(CBWGestureLockView *)lockView{
    
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
            
            NSString *buttonIndex = [NSString stringWithFormat:@"%zd",circleView.tag];
            
            [array addObject:buttonIndex];
            
        }
         weakSelf.infoView.selectedButtonsArray = array;
        
    }else{
        //后面进来
        
        if ([weakSelf.keyStr isEqualToString:str]) {
            //将密码保存到本地
            [CBWGestureLockConst saveGesture:str Key:gestureKey];
            //就返回
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            //不返回,需要提示
            NSLog(@"两次不统一,需要重新设置");
             weakSelf.tipsLabel.text = setKeyerrorTips;
            [weakSelf.tipsLabel.layer shake];
            
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
