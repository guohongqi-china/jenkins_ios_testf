//
//  ToastInputV.m
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//
#define dotSpace 40


#import "ToastInputV.h"


@interface ToastInputV()<UITextFieldDelegate,CAAnimationDelegate>
{
    BOOL isRemove;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *responseTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dotLeading;
@property (weak, nonatomic) IBOutlet UIView *dotView;


@end

@implementation ToastInputV



+ (id)InstanceToastView{
    
    ToastInputV *view = [[NSBundle mainBundle]loadNibNamed:@"View" owner:nil options:nil].lastObject;
    return view;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}



#pragma mark  ---------------------  接口事件   ----------------------------------------------

- (void)showToastType:(TOASTALERTTYPE)type dataDic:(NSDictionary <NSString *,NSString *>*)dic{

    
    if (type == TOASTALERT_PINCODE) {
        
        [_responseTextfield becomeFirstResponder];
        isRemove = NO;
        [self setDotFlicker];
        
        self.titleLab.text = dic[@"title"];
        
        if ([dic.allKeys containsObject:@"content"]) {
            self.subtitleLab.text = dic[@"content"];
        }
        
        self.subtitleLab.hidden = ![dic.allKeys containsObject:@"content"];
        
    }else{
        
        [self shakeAnmation];
    }
    
  
    
}


- (void)clearContent{
    [self clearText:_responseTextfield];
    isRemove = YES;
}

#pragma mark  ---------------------  代理   ----------------------------------------------

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        return  YES;
    }
    
    UILabel *not = [self viewWithTag:1000 + range.location];
    not.text = @"＊";
    _dotView.hidden = NO;
    
    if(string.length != 0){
        if(textField.text.length + string.length == 6){
            isRemove = YES;
            _dotView.hidden = YES;
        }
    }
    
    if (string.length == 0) {
        not.text = @"";
        _dotLeading.constant = 3 + dotSpace * (range.location);
    }else{
        _dotLeading.constant = 3 + dotSpace * (range.location + 1);
        
    }

    
    if (range.location == 5) {
        [textField endEditing:YES];
        id view = (id)(self.superview.superview);
        [view viewEnableWithType:1002];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            NSString *inputCode = [textField.text stringByAppendingString:string];
            if (self.delegate && [self.delegate respondsToSelector:@selector(endEditorWidth:)]) {
                [self.delegate endEditorWidth:inputCode];
            }
            [self clearText:textField];
            
        });
        
    }
    
    return YES;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_responseTextfield becomeFirstResponder];
    if (self.dotView.hidden) {
        self.dotView.hidden = NO;
        
    }
    isRemove = NO;
    [self setDotFlicker];
    
}


#pragma mark  ---------------------  私有事件   ----------------------------------------------

/**
 * 抖动效果
 */
- (void)shakeAnmation{
    

    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        shake.fromValue = [NSNumber numberWithFloat:-13];
        shake.toValue = [NSNumber numberWithFloat:13];
        shake.duration = 0.03;//执行时间
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 6;//次数
        shake.delegate = self;
        [_inputView.layer addAnimation:shake forKey:@"shakeAnimation"];
    });
}


/**
 * 光标
 */
-(void)setDotFlicker{
    
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.6 /*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (!isRemove) {
            _dotView.hidden = !_dotView.hidden;
            [self setDotFlicker];
        }
    });
    
    
}


- (void)clearText:(UITextField *)textField{
    
    textField.text = @"";
    _dotLeading.constant = 3;
    
    for (NSInteger i = 0; i < 6; i++) {
        UILabel *lab = [self viewWithTag:1000 + i];
        lab.text = @"";
    }
}


@end
