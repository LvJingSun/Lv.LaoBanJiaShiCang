//
//  CardRLTableViewCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 15-5-14.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardRLTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *CardImage;

@property (nonatomic, weak) IBOutlet UILabel *Businessname;

- (void)setImageView:(NSString *)imagePath;

@end
