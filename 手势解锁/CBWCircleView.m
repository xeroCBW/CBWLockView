//
//  CBWCircleView.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/11.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "CBWCircleView.h"


@interface CBWCircleView ()
/** 外圈圆颜色*/
@property (nonatomic , strong) UIColor *outerCircleColor;

/** 内圈圆颜色*/
@property (nonatomic ,strong) UIColor *innerCirCleColor;
@end

@implementation CBWCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = circleViewBackgroupColor;
        self.state = CircleViewStateNormal;
    }
    return self;
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
}

#pragma mark - private

//重写 drawRect 方法

-(void)drawRect:(CGRect)rect{
  
    //画外圆
    [self drawCircleWithRadius:0 lineWidth:outerCircleWidth rect:rect color:self.outerCircleColor];
    //画内圆
    
    [self drawCircleWithRadius:innerCircleRadius lineWidth:innerCircleWidth rect:rect color:self.innerCirCleColor];

    //画内圆的 border

}

- (void)drawCircleWithRadius:(float )radius lineWidth:(float )lineWidth rect:(CGRect )rect color:(UIColor *)color{
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 画圆--默认是方形的,
    radius = radius ? radius:rect.size.width / 2.0;
    lineWidth = lineWidth ? lineWidth : 3.0;
    
    CGContextAddArc(ctx, rect.size.width / 2.0, rect.size.height / 2.0, radius - lineWidth / 2.0, 0, 2 * M_PI, 0);
    //设置颜色
    [color set];
    //设置线宽
    CGContextSetLineWidth(ctx, lineWidth);
    // 3.渲染 (注意, 画线只能通过空心来画)
    //    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);

    
}


#pragma mark - setter && getter

-(void)setState:(CircleViewState)state{
    
    _state = state;
    
    [self setNeedsDisplay];
}

/**
 *  应该重写 getter 方法,不是重写 setter 方法
 */
-(UIColor *)outerCircleColor{
    //getter 方法返回成员属性
    
    if (self.state == CircleViewStateNormal) {
        _outerCircleColor = outerCircleColorNormal;
    }else if (self.state == CircleViewStateSeleted){
        _outerCircleColor = outerCircleColorSelected;
    }else if (self.state == CircleViewStateError){
         _outerCircleColor = outerCircleColorError;
    }else if (self.state == CircleViewStateInfoNormal){
        _outerCircleColor = outerCircleColorInfoNormal;
    }else if (self.state == CircleViewStateInfoSelected){
        _outerCircleColor = outerCircleColorInfoSelect;
    }
    return _outerCircleColor;
}
-(UIColor *)innerCirCleColor{
    
    if (self.state == CircleViewStateNormal) {
        _innerCirCleColor = innnerCircleColorNormal;
    }else if (self.state == CircleViewStateSeleted){
        _innerCirCleColor = innnerCircleColorSelected;
    }else if (self.state == CircleViewStateError){
        _innerCirCleColor = innnerCircleColorError;
    }else if (self.state == CircleViewStateInfoNormal){
        _innerCirCleColor = innerCircleColorInfoNormal;
    }else if (self.state == CircleViewStateInfoSelected){
        _innerCirCleColor = innerCircleColorInfoSelect;
    }
    
    return _innerCirCleColor;
}
@end
