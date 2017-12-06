//
//  DeleteView.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "DeleteView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation DeleteView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width * 0.05, 30, size.width * 0.9, 40)];
        
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        [deleteBtn setBackgroundColor:[UIColor colorWithRed:239/255. green:71/255. blue:57/255. alpha:1.]];
        
        deleteBtn.layer.cornerRadius = 5;
        
        [deleteBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteBtn = deleteBtn;
        
        [self addSubview:deleteBtn];
        
    }
    
    return self;
    
}

- (void)BtnClick {

//    if ([self.delegate respondsToSelector:@selector(DeleteBtnClick)]) {
//        
//        [self.delegate DeleteBtnClick];
//        
//    }
    
    NSLog(@"aaa");
    
}

@end
