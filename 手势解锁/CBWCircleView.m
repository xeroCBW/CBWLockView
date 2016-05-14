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
/**
 *  三角形颜色
 */
@property (nonatomic, strong) UIColor *trangleColor;
@end

@implementation CBWCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = circleViewBackgroupColor;
        self.state = CircleViewStateNormal;
        self.arrow = YES;
    }
    return self;
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
}

#pragma mark - private

//重写 drawRect 方法

-(void)drawRect:(CGRect)rect{
    
  CGContextRef ctx = UIGraphicsGetCurrentContext();
    
   
    //画外圆
    [self drawCircleWithContext:ctx radius:0 lineWidth:outerCircleWidth rect:rect color:self.outerCircleColor];
    //画内圆
    
    [self drawCircleWithContext:ctx radius:innerCircleRadius lineWidth:innerCircleWidth rect:rect color:self.innerCirCleColor];

    //画内圆的 border

    
    //画三角形状
    if (self.arrow) {
         [self transFormCtx:ctx rect:rect];
        // 画三角形箭头
        [self drawTrangleWithContext:ctx topPoint:CGPointMake(rect.size.width/2, 10) length:kTrangleLength color:self.trangleColor];
    }

}

- (void)drawCircleWithContext:(CGContextRef)ctx radius:(float )radius lineWidth:(float )lineWidth rect:(CGRect )rect color:(UIColor *)color{
#warning 是否要释放 release 上下文
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
#pragma mark - 画三角形
/**
 *  画三角形
 *
 *  @param ctx    图形上下文
 *  @param point  顶点
 *  @param length 边长
 *  @param color  绘制颜色
 */
- (void)drawTrangleWithContext:(CGContextRef)ctx topPoint:(CGPoint)point length:(CGFloat)length color:(UIColor *)color
{
    
    CGMutablePathRef trianglePathM = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePathM, NULL, point.x, point.y);
    CGPathAddLineToPoint(trianglePathM, NULL, point.x - length/2, point.y + length/2);
    CGPathAddLineToPoint(trianglePathM, NULL, point.x + length/2, point.y + length/2);
    CGContextAddPath(ctx, trianglePathM);
    [color set];
    CGContextFillPath(ctx);
    CGPathRelease(trianglePathM);
    

}
/*
 *  上下文旋转
 */
-(void)transFormCtx:(CGContextRef)ctx rect:(CGRect)rect{
//    if(self.angle == 0) return;
    CGFloat translateXY = rect.size.width * .5f;
    //平移
    CGContextTranslateCTM(ctx, translateXY, translateXY);
    CGContextRotateCTM(ctx, self.angle);
    //再平移回来
    CGContextTranslateCTM(ctx, -translateXY, -translateXY);
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
    }else if (self.state == CircleViewStateLastOneError){
        _outerCircleColor = outerCircleColorError;
    }else if (self.state == CircleViewStateLastOneSelected){
        _outerCircleColor = outerCircleColorSelected;
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
    }else if (self.state == CircleViewStateLastOneError){
        _innerCirCleColor = innnerCircleColorError;
    }else if (self.state == CircleViewStateLastOneSelected){
        _innerCirCleColor = innnerCircleColorSelected;
    }
    
    return _innerCirCleColor;
}
-(UIColor *)trangleColor{
    
    if (self.state == CircleViewStateNormal) {
        _trangleColor = trangleColorNormal;
    }else if (self.state == CircleViewStateSeleted){
        _trangleColor = trangleColorSelected;
    }else if (self.state == CircleViewStateError){
        _trangleColor = trangleColorError;
    }else if (self.state == CircleViewStateInfoNormal){
        _trangleColor = trangleColorInfoNormal;
    }else if (self.state == CircleViewStateInfoSelected){
        _trangleColor = trangleColorInfoSelect;
    }else if (self.state == CircleViewStateLastOneError){
        _trangleColor = trangleColorNormal;
    }else if (self.state == CircleViewStateLastOneSelected){
        _trangleColor = trangleColorNormal;
    }

    return _trangleColor;
}
#pragma mark - setter && getter
/**
 *  重写angle的setter
 */
- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
  
    [self setNeedsDisplay];
}
@end
