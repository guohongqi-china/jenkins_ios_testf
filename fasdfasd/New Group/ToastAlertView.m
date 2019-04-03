//
//  ToastAlertView.m
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//

#import "ToastAlertView.h"
#import "ToastInputV.h"
#import "ToastTipText.h"
#import "ToastAnmation.h"
#import "ToastTextAction.h"
#import "yyyyyyyy.h"

@interface ToastAlertView()<ToastInputVDelegate,ToastTextActionDelegate>
{
    NSLayoutConstraint *referConstraint;
    CGFloat toastWidth;
    CGFloat toastHeigt;

}
@property (weak, nonatomic) IBOutlet UIView *toastV;
@property (strong, nonatomic) ToastInputV   *toastInput;
@property (strong, nonatomic) ToastTipText  *toastTipText;
@property (strong, nonatomic) ToastTextAction *toastTipSelete;
@property (strong, nonatomic) ToastAnmation *toastAnmation;
@property (nonatomic, strong) yyyyyyyy      *yyView;


@property (strong, nonatomic) UIView        *referV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;
@property (weak, nonatomic) IBOutlet UIImageView *bkImageView;


@end



@implementation ToastAlertView


+ (id)InstanceToastView{
    
    ToastAlertView *view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ToastAlertView class]) owner:nil options:nil].lastObject;
    view.frame = [UIScreen mainScreen].bounds;
    return view;
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
    toastWidth = [UIScreen mainScreen].bounds.size.width * 1 / 1.3;
    toastHeigt = toastWidth * 9.0 / 15;

}


#pragma mark  ---------------------  接口事件   ----------------------------------------------

- (void)setCenterYPoint:(CGFloat)ratio{
    [self removeConstraint:self.centerY];//在父试图上将button的宽度约束删除
    [self removeConstraint:referConstraint];
    NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                       constraintWithItem:self.toastV //子试图
                                       attribute:NSLayoutAttributeCenterY //子试图的约束属性
                                       relatedBy:NSLayoutRelationEqual //属性间的关系
                                       toItem:self//相对于父试图
                                       attribute:NSLayoutAttributeCenterY//父试图的约束属性
                                       multiplier:ratio
                                       constant:0.0];// 固定距离
    
    referConstraint = myConstraint;
    [self addConstraint: myConstraint];//为button重新添加一个约束

}


- (void)delayDisappear:(void (^)(void))disappear{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        disappear();
    });

}


- (void)showToastType:(TOASTALERTTYPE)type toastImage:(UIImage *)toastImage dataDic:(NSDictionary <NSString *,NSString *>*)dic{
    [super showToastType:type toastImage:toastImage dataDic:dic];
    
    if (type == TOASTALERT_PINCODE || type == TOASTALERT_PINSHAKE) {
        [self loadView:self.toastInput];
        [self.toastInput showToastType:type dataDic:dic];
        
    }else if (type == TOASTALERT_TIPTEXT){
        [self loadView:self.toastTipText];
        [self.toastTipText showToastType:type dataDic:dic];
        
    }else if (type == TOASTALERT_ANIMATION || type == TOASTALERT_PROGRESS || type == TOASTALERT_TIP){
        [self loadView:self.toastAnmation];
        [self.toastAnmation showToastType:type toastImage:toastImage dataDic:dic];
        
    }

}

- (void)showToastType:(TOASTALERTTYPE)type content:(NSString *)content leftAction:(NSString *)leftAction rightAction:(NSString *)rightAction{
    [super showToastType:type content:content leftAction:leftAction rightAction:rightAction];
    if (type == TOASTALERT_TIPSELETE) {
        [self loadView:self.yyView];
//        [self.toastTipSelete showToastType:type content:content leftAction:leftAction rightAction:rightAction];
    }
}


- (void)showToastType:(TOASTALERTTYPE)type  dataDic:(NSDictionary <NSString *,NSString *>*)dic{
    [super showToastType:type dataDic:dic];

    if (type == TOASTALERT_PINCODE || type == TOASTALERT_PINSHAKE) {
//        [self loadView:self.yyView];

        [self loadView:self.toastInput];
        [self.toastInput showToastType:type dataDic:dic];

        
    }else if (type == TOASTALERT_TIPTEXT){
        
        [self loadView:self.toastTipText];
        [self.toastTipText showToastType:type dataDic:dic];


    }else if (type == TOASTALERT_ANIMATION || type == TOASTALERT_PROGRESS || type == TOASTALERT_TIP){
        
        [self loadView:self.toastAnmation];
        [self.toastAnmation showToastType:type toastImage:nil dataDic:dic];

    }
    
}

#pragma mark  ---------------------  代理   ----------------------------------------------
#pragma mark --  ToastInputVDelegate

- (void)endEditorWidth:(NSString *)text{
    if (self.callBack) {
        self.callBack(text);
    }
}

#pragma mark --  ToastTextActionDelegate

- (void)toastAction:(BOOL)action{
    if (self.actionBak) {
        self.actionBak(action);
    }
}


#pragma mark  ---------------------  私有事件   ----------------------------------------------

- (void)loadView:(UIView *)view{
    
    if (![self.toastV.subviews containsObject:view]) {
        [self.toastV addSubview:view];
    }
    

    if (view.hidden) {
        view.hidden = NO;
    }
    
    if (self.referV != view && self.referV) {
        self.referV.hidden = YES;
    }
    
    self.referV = view;

}


- (void)removeFromSuperview{
    [super removeFromSuperview];

    if (_toastInput) {
        [self.toastInput clearContent];
    }
    [self setCenterYPoint:1];
}

- (void)showToastView:(void (^)(id data))callBlock{
    [super showToastView:callBlock];
//    [_bkImageView setImage:[UIImage imageNamed:@"Block-PIN-Code"]];
    [_bkImageView setImage:[UIImage imageNamed:@"BG_img50"]];

//    [_bkImageView setImage:[MGSizeColor setImageName:@"Block-PIN-Code"]];
    for (int i = 0; i < 6; i++) {
        UIImageView *view = [self viewWithTag:10000 + i];
        [view setImage:[UIImage imageNamed:@"6-Block-Shape50"]];
    }
}

- (void)showToastView:(void (^)(id))callBlock action:(void (^)(BOOL))action{
    [super showToastView:callBlock action:action];
//    [_bkImageView setImage:[MGSizeColor setImageName:@"BG_img"]];
    [_bkImageView setImage:[UIImage imageNamed:@"BG_img50"]];

}



#pragma mark  ---------------------  getter setter   ----------------------------------------------


- (ToastInputV *)toastInput{
    if (!_toastInput) {
        _toastInput = [ToastInputV InstanceToastView];
        _toastInput.frame = _toastV.bounds;
        _toastInput.delegate = self;
    }
    return _toastInput;
}


- (ToastTipText *)toastTipText{
    if (!_toastTipText) {
        _toastTipText = [ToastTipText InstanceToastView];
        _toastTipText.frame = _toastV.bounds;
    }
    return _toastTipText;
}


- (ToastAnmation *)toastAnmation{
    if (!_toastAnmation) {
        _toastAnmation = [ToastAnmation InstanceToastView];
        _toastAnmation.frame = CGRectMake(0, 0, toastWidth, toastHeigt);
    }
    return _toastAnmation;
}

- (ToastTextAction *)toastTipSelete{
    if (!_toastTipSelete) {
        _toastTipSelete = [ToastTextAction InstanceToastView];
        _toastTipSelete.frame = CGRectMake(0, 0, _toastV.frame.size.width, _toastV.frame.size.height);
        _toastTipSelete.delegate = self;
    }
    return _toastTipSelete;
}

- (yyyyyyyy *)yyView{
    if (!_yyView) {
        _yyView = [yyyyyyyy InstanceToastView];
        _yyView.frame = CGRectMake(0, 0, _toastV.frame.size.width, _toastV.frame.size.height);
    }
    return _yyView;
}


@end
