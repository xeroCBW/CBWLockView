//
//  LockInfoView.m
//  手势解锁
//
//  Created by 陈博文 on 16/5/14.
//  Copyright © 2016年 陈波文. All rights reserved.
//

#import "LockInfoView.h"
#import "CBWCircleView.h"

@implementation LockInfoView
- (instancetype)init
{
    if (self = [super init]) {
        // 解锁视图准备
        [self lockViewPrepare];
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
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    for (NSUInteger i=0; i<9; i++) {
        
        CBWCircleView *circle = [[CBWCircleView alloc] init];
        circle.state = CircleViewStateInfoNormal;
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
    
    [super drawRect:rect];
    
//    NSLog(@"-----");
}

@end
