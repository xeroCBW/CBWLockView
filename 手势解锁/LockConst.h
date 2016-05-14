//
//  LockConst.h
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <Foundation/Foundation.h>

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
static NSString *lengthTips = @"长度必须大于4";
static NSString *firstTips = @"请再次输入密码";
static NSString *setKeyerrorTips = @"与上次绘制不一致,请重新设置";
static NSString *verifyKeyTips = @"密码错误,请重新输入";
static NSString *gestureKey = @"gestureKey";
static const float circleViewWH = 60;
static const float circleInfoRadius = 5;
static const float errorDisplayTime = 0.6f;

static const float outerCircleWidth = 1;
static const float innerCircleRadius = 10;//infoView 的内圈比外圈大,就不会显示出来了
static const float innerCircleWidth = 10;//设置宽度等于半径,就会等于实心圆

static const float lineWidth = 1.0f;
/**
 *  三角形边长
 */
#define kTrangleLength 10.0f

#define mainScreenW [UIScreen mainScreen].bounds.size.width
#define circleViewBackgroupColor [UIColor clearColor]


#define outerCircleColorNormal [UIColor whiteColor]
#define outerCircleColorSelected [UIColor yellowColor]
#define outerCircleColorError [UIColor redColor]

#define outerCircleColorInfoNormal [UIColor whiteColor]
#define outerCircleColorInfoSelect [UIColor redColor]

#define innnerCircleColorNormal [UIColor clearColor]
#define innnerCircleColorSelected [UIColor yellowColor]
#define innnerCircleColorError [UIColor redColor]

#define innerCircleColorInfoNormal [UIColor greenColor]
#define innerCircleColorInfoSelect [UIColor yellowColor]

#define trangleColorNormal [UIColor clearColor]
#define trangleColorSelected [UIColor yellowColor]
#define trangleColorError [UIColor redColor]

#define trangleColorInfoNormal trangleColorNormal
#define trangleColorInfoSelect trangleColorNormal
@interface LockConst : NSObject

//保存密码
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key;
//获取密码
+ (NSString *)getGestureWithKey:(NSString *)key;

@end
