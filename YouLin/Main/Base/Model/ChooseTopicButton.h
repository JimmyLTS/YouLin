//
//  ChooseTopicButton.h
//  YouLin
//
//  Created by Jimmy on 15/12/20.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTopicButton : UIButton

@property (nonatomic, strong)UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

- (void)setNormalState;

@end
