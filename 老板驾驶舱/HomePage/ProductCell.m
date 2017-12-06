//
//  ProductCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "ProductCell.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation ProductCell

+ (instancetype)productCellWithTableView:(UITableView *)tableView {

    static NSString *cellID = @"cellID";
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = size.width * 0.05;
        
        CGFloat imageY = 5;
        
        CGFloat imageW = size.width * 0.2;
        
        CGFloat imageH = 70;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.picImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = size.width * 0.3;
        
        CGFloat nameY = 5;
        
        CGFloat nameW = size.width * 0.65;
        
        CGFloat nameH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = nameLab;
        
        [self addSubview:nameLab];
        
        CGFloat sellX = nameX;
        
        CGFloat sellY = CGRectGetMaxY(nameLab.frame) + 5;
        
        CGFloat sellW = nameW;
        
        CGFloat sellH = 13;
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(sellX, sellY, sellW, sellH)];
        
        self.countLab = countLab;
        
        countLab.font = [UIFont systemFontOfSize:12];
        
        countLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:countLab];
        
        CGFloat inX = nameX;
        
        CGFloat inY = CGRectGetMaxY(countLab.frame) + 4;
        
        CGFloat inW = (nameW - 5) * 0.5;
        
        CGFloat inH = 13;
        
        UILabel *inLab = [[UILabel alloc] initWithFrame:CGRectMake(inX, inY, inW, inH)];
        
        self.inPriceLab = inLab;
        
        inLab.font = [UIFont systemFontOfSize:12];
        
        inLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:inLab];
        
        CGFloat outX = CGRectGetMaxX(inLab.frame) + 5;
        
        CGFloat outY = inY;
        
        CGFloat outW = inW;
        
        CGFloat outH = inH;
        
        UILabel *outLab = [[UILabel alloc] initWithFrame:CGRectMake(outX, outY, outW, outH)];
        
        self.outPriceLab = outLab;
        
        outLab.font = [UIFont systemFontOfSize:12];
        
        outLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:outLab];
        
        CGFloat suppX = nameX;
        
        CGFloat suppY = CGRectGetMaxY(inLab.frame) + 4;
        
        CGFloat suppW = nameW;
        
        CGFloat suppH = 13;
        
        UILabel *suppLab = [[UILabel alloc] initWithFrame:CGRectMake(suppX, suppY, suppW, suppH)];
        
        self.supplierLab = suppLab;
        
        suppLab.font = [UIFont systemFontOfSize:12];
        
        suppLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:suppLab];
        
        self.height = 80;
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
