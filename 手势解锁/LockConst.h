//
//  LockConst.h
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockConst : NSObject

//保存密码
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key;
//获取密码
+ (NSString *)getGestureWithKey:(NSString *)key;

@end
