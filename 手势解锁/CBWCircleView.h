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
    
} CircleViewState;


@interface CBWCircleView : UIView

/** 状态*/
@property (nonatomic ,assign)  CircleViewState state;


@end
