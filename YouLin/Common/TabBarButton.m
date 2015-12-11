//
//  TabBarButton.m
//  时光网
//
//  Created by imac on 15/10/31.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

//- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imgName  title:(NSString *)title
//{
//    self = [super initWithFrame:frame];
//    if (self != nil) {
//        
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2 - 10, 5, 20, 20)];
//        imageView.image = [UIImage imageNamed:imgName];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self addSubview:imageView];
//        
//        CGFloat maxY = CGRectGetMaxY(imageView.frame);
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, maxY, frame.size.width, frame.size.height-maxY)];
//        [label setHighlighted:NO];
//        label.text = title;
//        label.textColor = [UIColor grayColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:11];
//        [self addSubview:label];
//    }
//    return self;
//}




- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalImageName  normalTitle:(NSString *)normalTitle selectImageName:(NSString *)selectImageName
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        _selectImage = [UIImage imageNamed:selectImageName];
        _normalImage = [UIImage imageNamed:normalImageName];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2 - 10, 5, 20, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        CGFloat maxY = CGRectGetMaxY(imageView.frame);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, maxY, frame.size.width, frame.size.height-maxY)];
        [label setHighlighted:NO];
        label.text = normalTitle;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [self addSubview:label];
        
        [self setNormalState];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
        UIImageView *imageView = (UIImageView *)self.subviews[0];
        imageView.image = _selectImage;
        
        UILabel *label = (UILabel *)self.subviews[1];
        label.textColor = kAddTopicColor;
    
}

- (void)setNormalState {
    
    UIImageView *imageView = (UIImageView *)self.subviews[0];
    imageView.image = _normalImage;
    
    UILabel *label = (UILabel *)self.subviews[1];
    label.textColor = kGrayColor;
}


@end
