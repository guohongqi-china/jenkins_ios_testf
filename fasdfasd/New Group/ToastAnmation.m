//
//  ToastAnmation.m
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//

#import "ToastAnmation.h"

@interface ToastAnmation ()
{
    BOOL isRotate;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIImageView *animationV;

@end

@implementation ToastAnmation


+ (id)InstanceToastView{
    
    ToastAnmation *view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ToastAnmation class]) owner:nil options:nil].lastObject;
    return view;
    
}

#pragma mark  ---------------------  接口事件   ----------------------------------------------


- (void)showToastType:(TOASTALERTTYPE)type toastImage:(UIImage *)toastImage dataDic:(NSDictionary <NSString *,NSString *>*)dic{


    // 旋转中...
    if (isRotate) {
        [self pauseLayer];
    }
    
    _animationV.image = toastImage;
    _titleLab.text = dic[@"title"];

    
    if ( type == TOASTALERT_PROGRESS) {
        
        [self progressAnimation];
        
    }


}


#pragma mark  ---------------------  私有事件   ----------------------------------------------

// 旋转
- (void)progressAnimation{
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat:M_PI *4];
    animation.duration  = 3;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_animationV.layer addAnimation:animation forKey:@"anmation"];
    
    isRotate = YES;
}



// 移除
- (void)pauseLayer{
    [_animationV.layer removeAnimationForKey:@"anmation"];
    isRotate = NO;
}

@end
