//
//  LockView.m
//  手势解锁
//
//  Created by 陈波文 on 16/3/7.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "CBWGestureLockView.h"
#import "CBWCircleView.h"

@interface CBWGestureLockView ()
// 当前点
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation CBWGestureLockView

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
    
        circleView.normalViewType = YES;
        [self addSubview:circleView];
        circleView.tag = i;
    }

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setUpButtonFrame];
}

-(void)setUpButtonFrame{
    
    CGFloat itemViewWH = circleViewWH;
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
        
        CBWCircleView *circle = (CBWCircleView *)subview;
        circle.arrow = self.index == 0 ? YES :NO;
    }];
    
}

#pragma mark - touch --begin && move && end

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.进行判断
    UITouch *touch = [touches anyObject];
    //2.转换点的位置
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    //3.判断button是否存在
    CBWCircleView *view = [self buttonContainPoint:point];
    //如果button存在就放在数组中保存
    if (view != nil) {
        view.state  = CircleViewStateSeleted;
        [self.selectedButtonArray addObject:view];
    }
    
    // 数组中最后一个对象的处理
    [self circleSetLastObjectWithState:CircleViewStateLastOneSelected];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.进行判断
    UITouch *touch = [touches anyObject];
    //2.转换点的位置
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    //3.判断button是否存在
    CBWCircleView *circleView = [self buttonContainPoint:point];
    //将状态设置为移动
    circleView.normalStateMove = YES;
    
    if (circleView != nil && circleView.state != CircleViewStateSeleted && circleView.state != CircleViewStateLastOneSelected) {
        
        circleView.state = CircleViewStateSeleted;
        [self.selectedButtonArray addObject:circleView];
        
        [self calAngleAndconnectTheJumpedCircle];
    }
    
    
    [self.selectedButtonArray enumerateObjectsUsingBlock:^(CBWCircleView *circle, NSUInteger idx, BOOL *stop) {
        
        [circle setState:CircleViewStateSeleted];
    }];

    // 数组中最后一个对象的处理
    [self circleSetLastObjectWithState:CircleViewStateLastOneSelected];

    //调用重绘命令
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //打印选中的button
    
    NSMutableString *str = [NSMutableString string];
    
    for (CBWCircleView *circleView in self.selectedButtonArray) {
        [str appendFormat:@"%zd,",circleView.tag];
        circleView.state = CircleViewStateNormal;
    }
    
    if ([self isBlankString:str]) {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(lockView:setKeyActionEndStr:)]) {
        
        [_delegate lockView:self setKeyActionEndStr:str]; // 通知执行协议方法
        
        [self checkState];
        
    }
    
    
    if (_lockViewHandle) {
        
        _lockViewHandle(str,self);
        
        [self checkState];
        
    }
    
}

#pragma mark - private


- (void)checkState{
    
    //是否错误,在这里暂停几秒
    if ([self getCircleState] == CircleViewStateError ||[self getCircleState] == CircleViewStateLastOneError) {
        
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(errorDisplayTime* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            for (CBWCircleView *circleView in self.selectedButtonArray) {
                circleView.state = CircleViewStateNormal;
            }
            
            [self resetView];
            self.userInteractionEnabled = YES;
            
        });
    }else{
        [self resetView];
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
- (CircleViewState)getCircleState
{
    return [(CBWCircleView *)[self.selectedButtonArray firstObject] state];
}

- (void)resetView{
    //清空所有的选中按钮--重绘
    [self.selectedButtonArray removeAllObjects];
    [self resetAllCirclesDirect];
    [self resetNormalStateMove];
    
    [self setNeedsDisplay];
}

#pragma mark - drawRect

/**
 *  画连线
 */
-(void)drawRect:(CGRect)rect{
    
    
    //设置颜色
    CircleViewState state = [self getCircleState];
//    NSLog(@"连线颜色%zd",state);
    UIColor *color;
    if (state == CircleViewStateError ||[self getCircleState] == CircleViewStateLastOneError) {
        color = lockViewLineColorError;
    }else{
        color = lockViewLineColorNormal;
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
    
    
    //设置连线,不在点的连线
    if (self.selectedButtonArray.count >= 1) {
        if (state == CircleViewStateError || state == CircleViewStateLastOneError) {
            
        }else{
            [path addLineToPoint:self.currentPoint];
        }
        
    }
   
    
    [color set];
    
    //设置线宽
    [path setLineWidth:lineWidth];
    //设置线的连接样式
    [path setLineJoinStyle:kCGLineJoinRound];
    //设置连线的透明度
    [path strokeWithBlendMode:kCGBlendModeColor alpha:1.0];
    //绘制路径.
    [path stroke];
    
}
#pragma mark - 每添加一个圆，就计算一次方向
-(void)calAngleAndconnectTheJumpedCircle{
    
    if(self.selectedButtonArray == nil || [self.selectedButtonArray count] <= 1) return;
    
    //取出最后一个对象
    CBWCircleView *lastOne = [self.selectedButtonArray lastObject];
    
    //倒数第二个
    CBWCircleView *lastTwo = [self.selectedButtonArray objectAtIndex:(self.selectedButtonArray.count -2)];
    
    //计算倒数第二个的位置
    CGFloat last_1_x = lastOne.center.x;
    CGFloat last_1_y = lastOne.center.y;
    CGFloat last_2_x = lastTwo.center.x;
    CGFloat last_2_y = lastTwo.center.y;
    
    // 1.计算角度（反正切函数）
    CGFloat angle = atan2(last_1_y - last_2_y, last_1_x - last_2_x) + M_PI_2;
    [lastTwo setAngle:angle];
    
//    // 2.处理跳跃连线
//    CGPoint center = [self centerPointWithPointOne:lastOne.center pointTwo:lastTwo.center];
//
//    CBWCircleView *centerCircle = [self enumCircleSetToFindWhichSubviewContainTheCenterPoint:center];
//    
//    if (centerCircle != nil) {
//        
//        // 把跳过的圆加到数组中，它的位置是倒数第二个
//        if (![self.selectedButtonArray containsObject:centerCircle]) {
//            [self.selectedButtonArray insertObject:centerCircle atIndex:self.selectedButtonArray.count - 1];
//        }
//    }
}

#pragma mark - 提供两个点，返回一个它们的中点
- (CGPoint)centerPointWithPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo
{
    CGFloat x1 = pointOne.x > pointTwo.x ? pointOne.x : pointTwo.x;
    CGFloat x2 = pointOne.x < pointTwo.x ? pointOne.x : pointTwo.x;
    CGFloat y1 = pointOne.y > pointTwo.y ? pointOne.y : pointTwo.y;
    CGFloat y2 = pointOne.y < pointTwo.y ? pointOne.y : pointTwo.y;
    
    return CGPointMake((x1+x2)/2, (y1 + y2)/2);
}

#pragma mark - 给一个点，判断这个点是否被圆包含，如果包含就返回当前圆，如果不包含返回的是nil
/**
 *  给一个点，判断这个点是否被圆包含，如果包含就返回当前圆，如果不包含返回的是nil
 *
 *  @param point 当前点
 *
 *  @return 点所在的圆
 */
- (CBWCircleView *)enumCircleSetToFindWhichSubviewContainTheCenterPoint:(CGPoint)point
{
    CBWCircleView *centerCircle;
    for (CBWCircleView *circle in self.subviews) {
        if (CGRectContainsPoint(circle.frame, point)) {
            centerCircle = circle;
        }
    }
    
    if (![self.selectedButtonArray containsObject:centerCircle]) {
        // 这个circle的角度和倒数第二个circle的角度一致
        centerCircle.angle = [[self.selectedButtonArray objectAtIndex:self.selectedButtonArray.count - 2] angle];
    }
    
    return centerCircle; // 注意：可能返回的是nil，就是当前点不在圆内
}


- (void)resetNormalStateMove{
    for (CBWCircleView *view in self.subviews) {
        view.normalStateMove = NO;
    }
}
- (void)resetAllCirclesDirect
{
    [self.subviews enumerateObjectsUsingBlock:^(CBWCircleView *obj, NSUInteger idx, BOOL *stop) {
        [obj setAngle:0];
    }];
}

#pragma mark - 对数组中最后一个对象的处理
- (void)circleSetLastObjectWithState:(CircleViewState)state
{
    [[self.selectedButtonArray lastObject] setState:state];
}

@end
