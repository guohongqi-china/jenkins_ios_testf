//
//  ToastTipText.m
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//

#import "ToastTipText.h"

@interface ToastTipText()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation ToastTipText

+ (id)InstanceToastView{
    
    ToastTipText *view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ToastTipText class]) owner:nil options:nil].lastObject;
    return view;
    
}

#pragma mark  ---------------------  接口事件   ----------------------------------------------


- (void)showToastType:(TOASTALERTTYPE)type  dataDic:(NSDictionary <NSString *,NSString *>*)dic{
             
    
    _titleLab.text = dic[@"title"];
    
    if ([dic.allKeys containsObject:@"content"]) {
        _contentLab.text = dic[@"content"];
    }
    
    if ([dic.allKeys containsObject:@"time"]) {
        _timeLabel.text = dic[@"time"];
    }    
    
    _timeLabel.hidden = ![dic.allKeys containsObject:@"time"];
}


@end
