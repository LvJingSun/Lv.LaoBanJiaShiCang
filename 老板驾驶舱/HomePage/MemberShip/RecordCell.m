//
//  RecordCell.m
//  yfdeguyigqfiu
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import "RecordCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface RecordCell ()



@end

@implementation RecordCell

+ (instancetype)RecordCellWithTableView:(UITableView *)tableView {

    static NSString *cellID = @"cellID";
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UILabel *countLab = [[UILabel alloc] init];
        
        self.countLab = countLab;
        
        CGFloat countX = 20;
        
        CGFloat countY = 20;
        
        CGFloat countW = SCREEN_WIDTH * 0.5 - 20;
        
        CGFloat countH = 20;
        
        countLab.frame = CGRectMake(countX, countY, countW, countH);
        
        [self.contentView addSubview:countLab];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(countX, CGRectGetMaxY(countLab.frame) + 4, countW, 16)];
        
        self.nameLab = nameLab;
        
        nameLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:nameLab];
        
        UILabel *typeLab = [[UILabel alloc] init];
        
        typeLab.textAlignment = NSTextAlignmentRight;
        
        self.typeLab = typeLab;
        
        CGFloat typeX = SCREEN_WIDTH * 0.5;
        
        CGFloat typeY = 4;
        
        CGFloat typeW = SCREEN_WIDTH * 0.5 - 20;
        
        CGFloat typeH = 16;
        
        typeLab.frame = CGRectMake(typeX, typeY, typeW, typeH);
        
        [self.contentView addSubview:typeLab];
        
        
        
        UILabel *timeLab = [[UILabel alloc] init];
        
        timeLab.textAlignment = NSTextAlignmentRight;
        
        self.timeLab = timeLab;
        
        CGFloat timeX = SCREEN_WIDTH * 0.5;
        
        CGFloat timeY = CGRectGetMaxY(typeLab.frame) + 4;
        
        CGFloat timeW = SCREEN_WIDTH * 0.5 - 20;
        
        CGFloat timeH = typeH;
        
        timeLab.frame = CGRectMake(timeX, timeY, timeW, timeH);
        
        [self.contentView addSubview:timeLab];
        
        
        
        UILabel *addressLab = [[UILabel alloc] init];
        
        addressLab.textAlignment = NSTextAlignmentRight;
        
        self.addressLab = addressLab;
        
        CGFloat addressX = SCREEN_WIDTH * 0.5;
        
        CGFloat addressY = CGRectGetMaxY(timeLab.frame) + 4;
        
        CGFloat addressW = SCREEN_WIDTH * 0.5 - 20;
        
        CGFloat addressH = typeH;
        
        addressLab.frame = CGRectMake(addressX, addressY, addressW, addressH);
        
        [self.contentView addSubview:addressLab];
        
        self.height = CGRectGetMaxY(addressLab.frame) + 4;
        
    }
    
    return self;
    
}


@end
