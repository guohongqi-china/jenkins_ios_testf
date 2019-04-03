//
//  ToastInputV.h
//  CER_IKE_01
//
//  Created by guohq on 2018/9/12.
//  Copyright © 2018年 ike. All rights reserved.
//

#import "BaseToastView.h"

@protocol ToastInputVDelegate <NSObject>

- (void)endEditorWidth:(NSString *)text;

@end

@interface ToastInputV : BaseToastView


@property (weak, nonatomic) id<ToastInputVDelegate> delegate;

- (void)clearContent; // 清除内容


@end
