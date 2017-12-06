//
//  DingdandetailViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-4-9.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "DingdandetailViewController.h"

@interface DingdandetailViewController ()

@end

@implementation DingdandetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"订单详情"];

    
    self.NickNamelabel.text = self.Dingdandetail.NickName;
    self.UseDescriptlabel.text = self.Dingdandetail.UseDescript;
    self.UnitPricelabel.text = [NSString stringWithFormat:@"￥%@",self.Dingdandetail.UnitPrice];
    self.TotalAmountlabel.text = [NSString stringWithFormat:@"￥%@",self.Dingdandetail.TotalAmount];
    self.OrdersCodelabel.text = self.Dingdandetail.OrdersCode;
    self.Amountlabel.text = self.Dingdandetail.Amount;
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
