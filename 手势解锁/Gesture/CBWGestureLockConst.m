//
//  LockConst.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "CBWGestureLockConst.h"

@implementation CBWGestureLockConst

+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:gesture forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getGestureWithKey:(NSString *)key
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)deleteGestureWithKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
