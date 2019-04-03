//
//  UIColor+Gradient.h
//  CER_IKE_01
//
//  Created by guohq on 2019/1/11.
//  Copyright © 2019年 ike. All rights reserved.
//



    
   
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZQGradientChangeDirection) {
    
    ZQGradientChangeDirectionLevel,                               //水平方向渐变
    ZQGradientChangeDirectionVertical,                           //垂直方向渐变
    ZQGradientChangeDirectionUpwardDiagonalLine,    //主对角线方向渐变
    ZQGradientChangeDirectionDownDiagonalLine,       //副对角线方向渐变
    
};
NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Gradient)

+ (instancetype)colorGradientChangeWithSize:(CGSize)size
                                  direction:(ZQGradientChangeDirection)direction
                                 startColor:(UIColor *)startColor
                                   endColor:(UIColor *)endColor;




@end

NS_ASSUME_NONNULL_END
