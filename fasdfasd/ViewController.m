//
//  ViewController.m
//  fasdfasd
//
//  Created by guohq on 2019/1/3.
//  Copyright © 2019年 guohq. All rights reserved.
//
#define CCCHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ViewController.h"
#import "RedView.h"
#import "blue.h"
#import "UIColor+Gradient.h"
#import "ToastAlertView.h"
#import "MGRoundView.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    blue *view;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageWidth;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong)    MGRoundView           *roundView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ViewController

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    
//    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
//    if (err) {
//        err = nil;
//        result = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&err];
//        // use JSONKit
//
//    }
    
    
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *result = @"{'content':'Time to maintain your vehicle LDV SK81 SK8***********902. Please  make an appointment for better travel.','description':'2400'}";
    
    
    NSDictionary *dic = [self dictionaryWithJsonString:result];
    NSLog(@"%@",dic);
    
    
    _roundView = [[MGRoundView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 54 / 2 - 40, 80, 80)];
    _roundView.currentAngle = 0.0;
    [self.scrollView addSubview:_roundView];
    
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
  
    
//    RedView *redView = [[NSBundle mainBundle]loadNibNamed:@"RedView" owner:nil options:nil].lastObject;
//    redView.frame = CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height);
//    [_bgView addSubview:redView];
//
//
    view = [[NSBundle mainBundle]loadNibNamed:@"blue" owner:nil options:nil].lastObject;
    view.frame = CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height - 100);
    view.backgroundColor = [UIColor blueColor];
//    [_bgView addSubview:view];
//
//    NSLog(@"%@",_imageWidth);
//    NSLog(@"%@",view);
//    NSLog(@"%@",redView);
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view.backgroundColor = [UIColor colorGradientChangeWithSize:view.layer.bounds.size direction:ZQGradientChangeDirectionLevel startColor:[UIColor blueColor] endColor:[UIColor redColor]];
//    [self.view addSubview:redView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)CCCHex(0XFF39DFFF).CGColor, (__bridge id)CCCHex(0X706EFC).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.6, 0);
    gradientLayer.frame = view.layer.bounds;
    if (![view.layer.sublayers.firstObject isKindOfClass:[CAGradientLayer class]]) {
        [view.layer insertSublayer:gradientLayer atIndex:0];
    }else{
        NSMutableArray *layers = [NSMutableArray arrayWithArray:view.layer.sublayers];
        [layers removeObjectAtIndex:0];
        view.layer.sublayers = layers;
        [view.layer insertSublayer:gradientLayer atIndex:0];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_bgView addGestureRecognizer:tap];

}

CGFloat overOffsety = 0.0;
CGFloat over = 0.02;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.contentOffset.y;
    
    
    if (offsetY > -20) return;
    
    
    
    if (overOffsety > offsetY) {
        over = over + 0.04;
    }else{
        over = over - 0.04;
    }
    
    _roundView.currentAngle = over ;
    overOffsety = offsetY;
}


- (void)tapAction{
    NSLog(@"1231");
}

- (IBAction)sender:(UIButton *)sender {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        view.backgroundColor = [UIColor whiteColor];
    }else{
        view.backgroundColor = [UIColor colorGradientChangeWithSize:CGSizeMake(width / 1.3 , 100) direction:ZQGradientChangeDirectionLevel startColor:[UIColor blueColor] endColor:[UIColor redColor]];

    }
    
    
    ToastAlertView *toastAlertView = [ToastAlertView InstanceToastView];
//    [toastAlertView showToastType:TOASTALERT_TIPSELETE content:@"发送到发送到发送到发送到发送到发送到发送23423234发多少发生的发生" leftAction:@"Service Completed" rightAction:@"Close"];
    [toastAlertView showToastType:TOASTALERT_PINCODE dataDic:@{@"title":@"Enter PIN Code"}];
    __weak ToastAlertView *weakView = toastAlertView;
//    [toastAlertView setCenterYPoint:0.8];

    [toastAlertView showToastView:nil action:^(BOOL result) {
        if (result) {
           
        }else{
            [weakView closeToase];
        }
    }];
}


@end
