//
//  ChooseTopicButton.m
//  YouLin
//
//  Created by Jimmy on 15/12/20.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "ChooseTopicButton.h"
#import "UIViewExt.h"

#define kButtonWidth self.frame.size.width
#define kButtonHeight self.frame.size.height
@implementation ChooseTopicButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatLabel:title];
    }
    return self;
    
}

- (void)creatLabel:(NSString *)title {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _label = [[UILabel alloc]initWithFrame:self.bounds];
    _label.text = title;
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:15 weight:-50];
    [_label sizeToFit];
    self.width = _label.width + 40;
    _label.frame = CGRectMake((kButtonWidth - _label.width)/2 , (kButtonHeight - _label.height)/2, _label.width, _label.height);
    [self addSubview:_label];
    
}

- (void)setHighlighted:(BOOL)highlighted {

    _label.textColor = kAddTopicColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        _label.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    
}

- (void)setNormalState {
    _label.textColor = [UIColor blackColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        _label.transform = CGAffineTransformIdentity;
    }];
    
}

@end
