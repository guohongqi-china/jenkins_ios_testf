//
//  BaseToastView.m
//  继承
//
//  Created by guohq on 2018/9/10.
//  Copyright © 2018年 guohq. All rights reserved.
//

#import "BaseToastView.h"

@interface BaseToastView ()   



@end


@implementation BaseToastView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 添加手势
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeToase)];
    [self addGestureRecognizer:tapGesturRecognizer];
    
}

#pragma mark  ---------------------  接口事件   ----------------------------------------------


- (void)closeToase{
    [self removeFromSuperview];
    if (self.callBack) {
        self.callBack(nil);
    }

}


- (void)showToastView:(void (^)(id data))callBlock{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.callBack = callBlock;
    
}

- (void)showToastView:(void (^)(id data))callBlock  action:(void (^)(BOOL result))action{
    [self showToastView:callBlock];
    self.actionBak = action;
}


- (void)showToastType:(TOASTALERTTYPE)type toastImage:(UIImage *)toastImage dataDic:(NSDictionary <NSString *,NSString *>*)dic{
    [self viewEnableWithType:type];
}

- (void)showToastType:(TOASTALERTTYPE)type  dataDic:(NSDictionary <NSString *,NSString *>*)dic{
    [self viewEnableWithType:type];
}

- (void)showToastType:(TOASTALERTTYPE)type content:(NSString *)content leftAction:(NSString *)leftAction rightAction:(NSString *)rightAction{
    [self viewEnableWithType:type];
}


- (void)viewEnableWithType:(TOASTALERTTYPE)type{
    if (type == TOASTALERT_PINCODE || type == TOASTALERT_PINSHAKE || type == TOASTALERT_TIPSELETE) {
        self.userInteractionEnabled = YES;
    }else{
        self.userInteractionEnabled = NO;
        
    }
}

#pragma mark  ---------------------  私有事件   ----------------------------------------------



@end
