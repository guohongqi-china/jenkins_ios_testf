//
//  ToastAlertView.h
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//




#import "BaseToastView.h"


@interface ToastAlertView : BaseToastView


// 延迟 2秒 消失
- (void)delayDisappear:(void (^)(void))disappear;

// 调整视图Y轴位置 (消失后自动重置)
- (void)setCenterYPoint:(CGFloat)ratio;


@end
