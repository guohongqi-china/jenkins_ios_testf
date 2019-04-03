//
//  UIColor+Gradient.m
//  CER_IKE_01
//
//  Created by guohq on 2019/1/11.
//  Copyright © 2019年 ike. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

+ (instancetype)colorGradientChangeWithSize:(CGSize)size
                                  direction:(ZQGradientChangeDirection)direction
                                 startColor:(UIColor *)startColor
                                   endColor:(UIColor *)endColor{
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startColor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    
    if (direction == ZQGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;

    switch (direction) {
        case ZQGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case ZQGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);

            break;
        case ZQGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);

            break;
        case ZQGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);

            break;
            
        default:
            break;
    }
    
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
    

}




@end
