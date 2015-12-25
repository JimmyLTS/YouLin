//
//  MainTableView.m
//  YouLin
//
//  Created by Jimmy on 15/12/23.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "MainTableView.h"

@implementation MainTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 40;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor purpleColor];
    }else {
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    return cell;
}

@end
