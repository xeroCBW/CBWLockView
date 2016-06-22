//
//  TestView.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/15.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "TestView.h"
#import "LockInfoView.h"

@interface TestView ()
/** infoView*/
@property (nonatomic ,weak) LockInfoView *infoView;

@end
@implementation TestView


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    LockInfoView *infoView = [[LockInfoView alloc]init];
    infoView.frame = CGRectMake(0, 0, 150,150);
    infoView.center = self.view.center;
    self.infoView = infoView;
   
    [self.view addSubview:infoView];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
   
    self.infoView.selectedButtonsArray = [NSMutableArray arrayWithArray:@[
                                                                     @"0",
                                                                     @"1",
                                                                     @"2",
                                                                     @"5",
                                                                     @"8"]];
}
@end
