//
//  ToastTextAction.m
//  CER_IKE_01
//
//  Created by guohq on 2019/1/21.
//  Copyright © 2019年 ike. All rights reserved.
//

#import "ToastTextAction.h"

@interface ToastTextAction ()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *hLine;
@property (weak, nonatomic) IBOutlet UIView *vLine;


@end

@implementation ToastTextAction


+ (id)InstanceToastView{
    
    ToastTextAction *view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ToastTextAction class]) owner:nil options:nil].firstObject;
//    view.hLine.backgroundColor = [MGSkinManager setNormalColor:RGB(89, 121, 186) otherColor:RGB(90, 90, 90)];
//    view.vLine.backgroundColor = [MGSkinManager setNormalColor:RGB(89, 121, 186) otherColor:RGB(90, 90, 90)];
    return view;
    
}


- (void)showToastType:(TOASTALERTTYPE)type content:(NSString *)content leftAction:(NSString *)leftAction rightAction:(NSString *)rightAction{
    
    [_leftBtn setTitle:leftAction forState:(UIControlStateNormal)];
    [_rightBtn setTitle:rightAction forState:(UIControlStateNormal)];
    _contentLab.text = content;
    
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toastAction:)]) {
        [self.delegate toastAction:YES];
    }
}

- (IBAction)dismissAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(toastAction:)]) {
        [self.delegate toastAction:NO];
    }
}

@end
