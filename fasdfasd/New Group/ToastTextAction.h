//
//  ToastTextAction.h
//  CER_IKE_01
//
//  Created by guohq on 2019/1/21.
//  Copyright © 2019年 ike. All rights reserved.
//

#import "BaseToastView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ToastTextActionDelegate <NSObject>

- (void)toastAction:(BOOL)action;

@end

@interface ToastTextAction : BaseToastView

@property (nonatomic, assign) id<ToastTextActionDelegate>           delegate;




@end

NS_ASSUME_NONNULL_END
