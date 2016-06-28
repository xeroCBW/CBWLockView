//
//  ViewController.m
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "ViewController.h"
#import "CBWGestureLockSettingKeyVC.h"
#import "CBWGestureLockVerifyKeyVC.h"
#import "TestView.h"



#define ScreenHW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation ViewController

- (void)viewDidLoad{
    
    [CBWGestureLockConst saveGesture:nil Key:gestureKey];
    self.segment.selectedSegmentIndex = 0;
}


- (IBAction)settingKeyAction:(id)sender {
    
    CBWGestureLockSettingKeyVC *settingVC = [[CBWGestureLockSettingKeyVC alloc]init];
    settingVC.index = self.segment.selectedSegmentIndex;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    [self presentViewController:navi animated:YES completion:nil];

    
}


- (IBAction)verifyKeyAction:(id)sender {
    
    
    CBWGestureLockVerifyKeyVC *verifyVC = [[CBWGestureLockVerifyKeyVC alloc]init];
    verifyVC.index = self.segment.selectedSegmentIndex;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:verifyVC];
    [self presentViewController:nav animated:YES completion:nil];

}

- (IBAction)test:(id)sender {
    TestView *test = [[TestView alloc]init];
    
    
    [self.navigationController pushViewController:test animated:YES];
    
}


- (IBAction)segment:(UISegmentedControl *)sender {
    
    
    NSLog(@"===%zd",sender.selectedSegmentIndex);
}

@end
