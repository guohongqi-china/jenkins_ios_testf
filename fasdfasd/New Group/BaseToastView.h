//
//  BaseToastView.h
//  继承
//
//  Created by guohq on 2018/9/10.
//  Copyright © 2018年 guohq. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TOASTALERTTYPE) {
    TOASTALERT_PINCODE = 1000,    // 输入
    TOASTALERT_PINSHAKE,          // 抖动
    
    
    TOASTALERT_ANIMATION,         // GIF
    TOASTALERT_PROGRESS,          // loading
    TOASTALERT_TIP,               // 图文提示
    
    
    TOASTALERT_TIPTEXT,           // 文字提示
    TOASTALERT_TIPSELETE          // 文本提示选择
};


@interface BaseToastView : UIView


@property (copy, nonatomic)   void (^callBack)(id data);
@property (copy, nonatomic)   void (^actionBak)(BOOL result);


+ (id)InstanceToastView;   // 初始化
- (void)closeToase;  // 移除

/**
 显示弹窗
 
 @param callBlock  数据回调 (pin码输入、视图移除)
 */
- (void)showToastView:(void (^)(id data))callBlock;

/**
 显示弹窗
 
 @param callBlock  数据回调 (pin码输入、视图移除)
 @param action     选择事件 (确定按钮类操作)

 */
- (void)showToastView:(void (^)(id data))callBlock  action:(void (^)(BOOL result))action;


/**
 弹窗类型
 
 @param dic  传入数据 key值固定为  title、content、time @{@"title":@"value",@"content":@"content",@"time":@"value"}
 @param type 提示类型 枚举值
 */
- (void)showToastType:(TOASTALERTTYPE)type  dataDic:(NSDictionary <NSString *,NSString *>*)dic;


/**
 图文提示
 
 @param dic        传入数据
 @param type       提示类型 枚举值
 @param toastImage 展示图片
 */

- (void)showToastType:(TOASTALERTTYPE)type toastImage:(UIImage *)toastImage dataDic:(NSDictionary <NSString *,NSString *>*)dic;
/**
 交互提示
 
 @param content      内容
 @param type         提示类型 枚举值
 @param rightAction  按钮标题
 @param leftAction   按钮标题
 */

- (void)showToastType:(TOASTALERTTYPE)type content:(NSString *)content leftAction:(NSString *)leftAction rightAction:(NSString *)rightAction;


/**
 根据弹窗类型控制交互
 
 @param type       弹窗类型
 */
- (void)viewEnableWithType:(TOASTALERTTYPE)type;


@end
