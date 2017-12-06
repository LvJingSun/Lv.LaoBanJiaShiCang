//
//  SRdetailsViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "SRdetailsViewController.h"

@interface SRdetailsViewController ()
@property(nonatomic,weak)IBOutlet UITextView*SRdetails_contenttextview;//销售详情内容
@property(nonatomic,weak)IBOutlet UILabel*SRdetails_numlabel;//数量
@property(nonatomic,weak)IBOutlet UILabel*SRdetails_pricelabel;//单价
@property(nonatomic,weak)IBOutlet UILabel*SRdetails_allmoneylabel;//总价
@property(nonatomic,weak)IBOutlet UILabel*SRdetails_memberlabel;//会员
@property(nonatomic,weak)IBOutlet UILabel*SRdetails_timelabel;//时间


@end

@implementation SRdetailsViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title=@"近期销售详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.SRdetails_contenttextview.editable=NO;
//    self.SRdetails_contenttextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    self.SRdetails_contenttextview.text=self.saledetail.SvcName;
    self.SRdetails_numlabel.text=self.saledetail.Amount;
    self.SRdetails_pricelabel.text=[NSString stringWithFormat:@"￥%@",self.saledetail.UnitPrice];
    self.SRdetails_allmoneylabel.text=[NSString stringWithFormat:@"￥%@",self.saledetail.TotalAmount];
    self.SRdetails_memberlabel.text=self.saledetail.NickName;
    self.SRdetails_timelabel.text=self.saledetail.OrdCode;


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
