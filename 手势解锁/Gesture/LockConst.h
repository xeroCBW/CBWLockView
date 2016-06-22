//
//  LockConst.h
//  手势解锁
//
//  Created by 陈博文 on 16/5/12.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <Foundation/Foundation.h>

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
static NSString *inputTips = @"请绘制解锁图案";
static NSString *lengthTips = @"最少连接4个点，请重新绘制";
static NSString *firstTips = @"再次绘制解锁图案";
static NSString *setKeyerrorTips = @"与上次绘制不一致,请重新设置";
//static NSString *verifyKeyTips = @"密码绘制错误！还可以绘制2次";

static NSString *gestureKey = @"gestureKey";
static const float circleViewWH = 60;
static const float circleInfoRadius = 5;
static const float errorDisplayTime = 0.6f;

static const float outerCircleWidth = 2;
static const float innerCircleRadius = 10;//infoView 的内圈比外圈大,就不会显示出来了
static const float innerCircleWidth = 10;//设置宽度等于半径,就会等于实心圆

static const float lineWidth = 4.0f;
static const int   errorCount = 5;//验证密码可以错误的次数
/**三角形边长*/
#define kTrangleLength 10.0f

#define lockViewBackgroupColor [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:246.0/255.0 alpha:1.0]
#define lockViewLineColorNormal [UIColor colorWithRed:112.0/255.0 green:182.0/255.0 blue:255.0/255.0 alpha:1.0]
#define lockViewLineColorError [UIColor redColor]

#define mainScreenW [UIScreen mainScreen].bounds.size.width
//225 241 254
#define circleViewBackgroupColorSelected [UIColor colorWithRed:225.0/255.0 green:241.0/255.0 blue:254.0/255.0 alpha:1.0]
#define circleViewBackgroupColorSelectedError [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:0.2];

#define outerCircleColorNormal [UIColor whiteColor]
#define outerCircleColorSelected lockViewLineColorNormal
#define outerCircleColorError [UIColor redColor]

#define outerCircleColorInfoNormal [UIColor whiteColor]
#define outerCircleColorInfoSelect [UIColor redColor]

#define innnerCircleColorNormal [UIColor clearColor]
#define innnerCircleColorSelected lockViewLineColorNormal
#define innnerCircleColorError [UIColor redColor]

#define innerCircleColorInfoNormal [UIColor clearColor]
#define innerCircleColorInfoSelect [UIColor greenColor]

#define trangleColorNormal [UIColor clearColor]
#define trangleColorSelected lockViewLineColorNormal
#define trangleColorError [UIColor redColor]

#define trangleColorInfoNormal trangleColorNormal
#define trangleColorInfoSelect trangleColorNormal
@interface LockConst : NSObject

//保存密码
+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key;
//获取密码
+ (NSString *)getGestureWithKey:(NSString *)key;

+ (void)deleteGestureWithKey:(NSString *)key;
@end
