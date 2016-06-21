//
//  CBWCircleView.h
//  手势解锁
//
//  Created by 陈博文 on 16/5/11.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CircleViewStateNormal = 1,
    CircleViewStateSeleted,
    CircleViewStateError,
    CircleViewStateInfoNormal,
    CircleViewStateInfoSelected,
    CircleViewStateLastOneError,
    CircleViewStateLastOneSelected,
    
} CircleViewState;


@interface CBWCircleView : UIView

/** 状态*/
@property (nonatomic ,assign)  CircleViewState state;
/**
 *  是否有箭头 default is YES
 */
@property (nonatomic, assign) BOOL arrow;

/** 角度 */
@property (nonatomic,assign) CGFloat angle;
/** infoView 还是普通的 View*/
@property (nonatomic ,assign,) BOOL normalViewType;
/** 手指是否已经移动过*/
@property (nonatomic ,assign,getter=isNormalStateMove) BOOL normalStateMove;

@end
