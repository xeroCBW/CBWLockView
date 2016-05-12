//
//  LockConst.h
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *firstTips = @"请再次输入密码";
static NSString *setKeyerrorTips = @"与上次不统一,需要重新设置";
static NSString *verifyKeyTips = @"密码错误,请重新输入";
static NSString *gestureKey = @"gestureKey";
static const float circleViewWH = 60;
static const float errorDisplayTime = 0.6f;

static const float innerCircleRadius = 20;
static const float innerCircleWidth = 10;

#define mainScreenW [UIScreen mainScreen].bounds.size.width

@interface LockConst : NSObject

//保存密码
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key;
//获取密码
+ (NSString *)getGestureWithKey:(NSString *)key;

@end
