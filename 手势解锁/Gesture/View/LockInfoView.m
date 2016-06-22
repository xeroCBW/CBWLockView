//
//  LockInfoView.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/14.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "LockInfoView.h"
#import "CBWCircleView.h"

@interface LockInfoView ()
/** j*/
@property (nonatomic ,assign) NSInteger j;
@end

@implementation LockInfoView
- (instancetype)init
{
    if (self = [super init]) {
        // 解锁视图准备
        [self lockViewPrepare];
        _j = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 解锁视图准备
        [self lockViewPrepare];
    }
    return self;
}



-(void)dealloc{
    
    NSLog(@"%s",__func__);
}
/*
 *  解锁视图准备
 */
-(void)lockViewPrepare{
    
    self.backgroundColor = lockViewBackgroupColor;
    
    for (NSUInteger i=0; i<9; i++) {
        
        CBWCircleView *circle = [[CBWCircleView alloc] init];
        circle.state = CircleViewStateInfoNormal;
        circle.normalViewType = NO;
        circle.tag = i;
     
        [self addSubview:circle];
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat itemViewWH = circleInfoRadius * 2;
    CGFloat marginValue = (self.frame.size.width - 3 * itemViewWH) / 3.0f;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        
        NSUInteger row = idx % 3;
        
        NSUInteger col = idx / 3;
        
        CGFloat x = marginValue * row + row * itemViewWH + marginValue/2;
        
        CGFloat y = marginValue * col + col * itemViewWH + marginValue/2;
        
        CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
    
        subview.frame = frame;
        
        subview.layer.cornerRadius = itemViewWH * 0.5;
        
        subview.layer.masksToBounds = YES;
    }];
}

#pragma mark - setter && getter 

- (void)setSelectedButtonsArray:(NSMutableArray *)selectedButtonsArray{
    
    _selectedButtonsArray = selectedButtonsArray;

    for (CBWCircleView *circle in self.subviews) {
        
        for (NSString *str in selectedButtonsArray) {
            NSInteger index = [str integerValue];
            if (index == circle.tag) {
                circle.state = CircleViewStateInfoSelected;
               
            }
        }

    }
    
    [self setNeedsDisplay];
    
    
}

-(void)drawRect:(CGRect)rect{
    

    UIColor *color;
   
        color = [UIColor blueColor];
    
    //创建路径.
    UIBezierPath *path = [UIBezierPath bezierPath];
    //取出所有保存的选中按钮连线.

    
            
            for (NSString *str in self.selectedButtonsArray) {
                NSInteger index = [str integerValue];
                for (CBWCircleView *circle in self.subviews) {

                if (index == circle.tag) {
                    circle.state = CircleViewStateInfoSelected;
                    
                    if(_j == 0){
                        //设置起点.
                        [path moveToPoint:circle.center];
                    }else{
                        //添加一根线到当前按钮的圆心.
                        [path addLineToPoint:circle.center];
                    }
                    ++_j;
                }
        
                }
        
        
//        UIView *circleView = self.selectedButtonArray[i];
//        //判断当前按钮是不是第一个,如果是第一个,把它的中心设置为路径的起点.
//        if(i == 0){
//            //设置起点.
//            [path moveToPoint:circleView.center];
//        }else{
//            //添加一根线到当前按钮的圆心.
//            [path addLineToPoint:circleView.center];
//        }

    
    [color set];
    
    //设置线宽
    [path setLineWidth:lineWidth];
    //设置线的连接样式
    [path setLineJoinStyle:kCGLineJoinRound];
    //设置连线的透明度
    [path strokeWithBlendMode:kCGBlendModeColor alpha:0.3];
    //绘制路径.
    [path stroke];
}
}


@end
