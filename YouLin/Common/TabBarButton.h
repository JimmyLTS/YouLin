//
//  TabBarButton.h
//  时光网
//
//  Created by imac on 15/10/31.
//  Copyright © 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

@property (nonatomic, strong)UIImage *selectImage;
@property (nonatomic, strong)UIImage *normalImage;

- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalImageName  normalTitle:(NSString *)normalTitle selectImageName:(NSString *)selectImageName;

//- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imgName  title:(NSString *)title;

- (void)setNormalState;

@end
