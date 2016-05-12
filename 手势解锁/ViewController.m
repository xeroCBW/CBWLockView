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
/// LockView
@property(nonatomic,strong)LockView * lockView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CBWCircleView *circleView = [[CBWCircleView alloc]init];
//    circleView.frame = CGRectMake(0, 0, 200,200);
//    circleView.state = CircleViewStateError;
//    [self.view addSubview:circleView];
    
    
    }

#pragma mark - lazy
-(LockView *)lockView{
    if (_lockView == nil) {
        _lockView = [[LockView alloc]init];
        [self.view addSubview:_lockView];
        self.lockView.backgroundColor = [UIColor lightGrayColor];
      
    }
    return _lockView;
}

-(void)viewDidLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.lockView.frame = CGRectMake(0, 0, ScreenHW, ScreenHW);
    self.lockView.center = self.view.center;
    
}
@end
