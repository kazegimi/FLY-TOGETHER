//
//  LogTableViewCell.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/15.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "LogTableViewCell.h"

@implementation LogTableViewCell
{
    UIView *leftView;
    UIView *rightView;
}

@synthesize imageView, titleLabel, nameLabel, mottoLabel, paTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, 256.0f);
    
    float padding = 6.0f;
    
    leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, padding, self.frame.size.width / 2.0f, self.frame.size.height - padding * 2);
    leftView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    //leftView.backgroundColor = [UIColor blueColor];
    [self addSubview:leftView];
    
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 128, 128);
    imageView.center = leftView.center;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [leftView addSubview:imageView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y - 22, imageView.frame.size.width, 22);
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:titleLabel];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + imageView.frame.size.height, imageView.frame.size.width, 22);
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:nameLabel];
    
    mottoLabel = [[UILabel alloc] init];
    mottoLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height, nameLabel.frame.size.width, 22);
    mottoLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    mottoLabel.font = [UIFont systemFontOfSize:10.0f];
    mottoLabel.numberOfLines = 2;
    mottoLabel.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:mottoLabel];
    
    rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(self.frame.size.width / 2.0f, padding, self.frame.size.width / 2.0f, self.frame.size.height - padding * 2);
    rightView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    //rightView.backgroundColor = [UIColor blueColor];
    [self addSubview:rightView];
    
    paTextView = [[UITextView alloc] init];
    paTextView.frame = CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height);
    paTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    paTextView.editable = NO;
    paTextView.font = [UIFont systemFontOfSize:16.0f];
    paTextView.textContainerInset = UIEdgeInsetsZero;
    paTextView.textContainer.lineFragmentPadding = 0;
    //paTextView.backgroundColor = [UIColor redColor];
    [rightView addSubview:paTextView];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
