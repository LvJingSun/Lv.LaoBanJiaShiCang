//
//  CardRLTableViewCell.m
//  BusinessCenter
//
//  Created by 冯海强 on 15-5-14.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import "CardRLTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation CardRLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setImageView:(NSString *)imagePath{
    [self.CardImage.layer setMasksToBounds:YES];
    [self.CardImage.layer setCornerRadius:32.0];

    [self.CardImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       self.CardImage.image = image;
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       self.CardImage.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];

                                   }];
    
}

@end
