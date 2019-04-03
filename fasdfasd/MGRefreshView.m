//
//  MGRefreshView.m
//  CER_IKE_01
//
//  Created by guohq on 2019/3/12.
//  Copyright © 2019年 saicmotor. All rights reserved.
//

#import "MGRefreshView.h"


@implementation MGRefreshView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat widht  = frame.size.width;
        CGFloat height = frame.size.height;

        _laebl = [[UILabel alloc]initWithFrame:CGRectMake(0, height / 2 - 10, widht, 20)];
        _laebl.textColor = [UIColor redColor];
        _laebl.font = [UIFont systemFontOfSize:16];
        [self addSubview:_laebl];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制路径: 圆形(中心坐标200、200、半径100、起点弧度0、终点弧度2PI、画的方向0逆1正) 第五个参数 是startAngle开始的角度
    CGContextAddArc(ctx, self.bounds.size.width / 2, self.bounds.size.width / 2, 20, 0.0, _currentAngle, 0);
    /*给当前View一个边框*/
    // CGContextAddRect(ctx, self.bounds);
    //修改图形状态参数
    //CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 2.0);//笔颜色
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 2.0);//笔颜色
    CGContextSetLineWidth(ctx, 3);//线条宽度
    //渲染上下文
    CGContextStrokePath(ctx);
    
//    //方法2
//        /*通过CGPathRef 来绘制圆*/
//        //获取上下文
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        //创建可变路径
//        CGMutablePathRef path = CGPathCreateMutable();
//        //添加圆形到路径中(所在路径、不进行变换操作、中心坐标200、200、起点弧度0、终点弧度2PI、画的方向0逆1正)
//        CGPathAddArc(path, NULL, self.bounds.size.width / 2, self.bounds.size.width / 2, 20, 0.0, _currentAngle, 0);
//        //将路径添加到上下文
//        CGContextAddPath(ctx, path);
//        //修改图形状态参数
//        CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 2.0);//笔颜色
//        CGContextSetLineWidth(ctx, 3);//线条宽度
//        //渲染上下文
//        CGContextStrokePath(ctx);
    
}

- (void)setCurrentAngle:(CGFloat)currentAngle{
    NSLog(@"%f",currentAngle);
    if (currentAngle < 0) {
        return;
    }
    _laebl.text = [NSString stringWithFormat:@"%.0f",currentAngle / (M_PI * 2) * 100];
    _currentAngle = currentAngle;
    [self setNeedsDisplay];
}

@end
