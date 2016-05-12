//
//  LockView.m
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "LockView.h"
#import "CBWCircleView.h"


#define ViewWH self.bounds.size.width
#define margin 30

@interface LockView ()

@end

@implementation LockView

#pragma mark - lazy

-(NSMutableArray *)selectedButtonArray{
    if (_selectedButtonArray == nil) {
        _selectedButtonArray = [NSMutableArray array];
    }
    return _selectedButtonArray;
}


#pragma mark - init

-(instancetype)init{
    if (self = [super init]) {
        
        [self setUpButton];
    }
    return self;
}


-(void)dealloc{
    
    NSLog(@"%s",__func__);
}

#pragma mark - initUI

-(void)setUpButton{
    
    NSInteger count = 9;
    
    for (int i = 0; i < count ; i++) {
        
         CBWCircleView *circleView = [[CBWCircleView alloc]init];
        [self addSubview:circleView];
        
        
        circleView.tag = i;
    }

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setUpButtonFrame];
}

-(void)setUpButtonFrame{
    
    NSInteger numOfRow = 3;//行
    NSInteger numofColumn = 3; //列
    NSInteger count = self.subviews.count;//总数量
    
    CGFloat buttonWH = (ViewWH - (numOfRow - 1) *margin)/numOfRow;
    
    
    for (int i = 0; i < count ; i++) {
        
        NSInteger indexOfRow = i % numofColumn;//每行的索引
        NSInteger indexOfColumn = i / numOfRow;//第几列
        
        UIView *view = self.subviews[i];
        
        view.frame = CGRectMake(indexOfRow * (buttonWH + margin), indexOfColumn * (buttonWH + margin), buttonWH, buttonWH);
        
    }
    
}

#pragma mark - touch --begin && move && end

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.进行判断
    UITouch *touch = [touches anyObject];
    //2.转换点的位置
    CGPoint point = [touch locationInView:self];
    //3.判断button是否存在
    CBWCircleView *view = [self buttonContainPoint:point];
    //如果button存在就放在数组中保存
    if (view != nil) {
        view.state  = CircleViewStateSeleted;
        [self.selectedButtonArray addObject:view];
    }
    
    
}


-(CBWCircleView *)buttonContainPoint:(CGPoint)point{
    
    for (CBWCircleView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.进行判断
    UITouch *touch = [touches anyObject];
    //2.转换点的位置
    CGPoint point = [touch locationInView:self];
    //3.判断button是否存在
    CBWCircleView *circleView = [self buttonContainPoint:point];
    
    if (circleView != nil && circleView.state != CircleViewStateSeleted) {
        
        circleView.state = CircleViewStateSeleted;
        [self.selectedButtonArray addObject:circleView];
    }
    
    //调用重绘命令
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //打印选中的button
    
    NSMutableString *str = [NSMutableString string];
    
    for (CBWCircleView *circleView in self.selectedButtonArray) {
        [str appendFormat:@"%ld,",circleView.tag];
        circleView.state = CircleViewStateNormal;
    }

    if (_lockViewHandle) {
        _lockViewHandle(str,self);
        
        
    //是否错误,在这里暂停几秒
        if ([self getCircleState] == CircleViewStateError) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(errorDisplayTime* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (CBWCircleView *circleView in self.selectedButtonArray) {
                    circleView.state = CircleViewStateNormal;
                }

                [self resetView];
                
            });
        }else{
            [self resetView];
        }
        
        
    }
    
}

#pragma mark - private

- (CircleViewState)getCircleState
{
    return [(CBWCircleView *)[self.selectedButtonArray firstObject] state];
}

- (void)resetView{
    //清空所有的选中按钮--重绘
    [self.selectedButtonArray removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - drawRect

/**
 *  画连线
 */
-(void)drawRect:(CGRect)rect{
    
    
    //设置颜色
    CircleViewState state = [self getCircleState];
    NSLog(@"连线颜色%zd",state);
    UIColor *color;
    if (state == CircleViewStateError) {
        color = [UIColor redColor];
    }else{
        color = [UIColor yellowColor];
    }

    
    //创建路径.
    UIBezierPath *path = [UIBezierPath bezierPath];
    //取出所有保存的选中按钮连线.
    for(int i = 0; i < self.selectedButtonArray.count;i++){
        UIView *circleView = self.selectedButtonArray[i];
        //判断当前按钮是不是第一个,如果是第一个,把它的中心设置为路径的起点.
        if(i == 0){
            //设置起点.
            [path moveToPoint:circleView.center];
        }else{
            //添加一根线到当前按钮的圆心.
            [path addLineToPoint:circleView.center];
        }
    }
    
    [color set];
    
    //设置线宽
    [path setLineWidth:5];
    //设置线的连接样式
    [path setLineJoinStyle:kCGLineJoinRound];
    //设置连线的透明度
    [path strokeWithBlendMode:kCGBlendModeColor alpha:0.3];
    //绘制路径.
    [path stroke];
}

@end
