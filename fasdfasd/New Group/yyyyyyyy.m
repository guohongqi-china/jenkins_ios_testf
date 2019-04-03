
//
//  yyyyyyyy.m
//  fasdfasd
//
//  Created by guohq on 2019/1/24.
//  Copyright © 2019年 guohq. All rights reserved.
//

#import "yyyyyyyy.h"

@implementation yyyyyyyy


+ (id)InstanceToastView{


 yyyyyyyy *view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([yyyyyyyy class]) owner:nil options:nil].lastObject;
return view;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
