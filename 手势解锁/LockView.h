//
//  LockView.h
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockView : UIView
/**
 *  selectedButtonArray
 */
@property(nonatomic,strong)NSMutableArray * selectedButtonArray;
/**
 *  buttonArray
 */
@property(nonatomic,assign)NSInteger buttonArrayCount;

/** 选中9宫格字符串*/
@property (nonatomic ,strong) void (^lockViewHandle)(NSString *str,LockView *lockView) ;


@end
