//
//  MainCollectionView.h
//  YouLin
//
//  Created by Jimmy on 15/12/22.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YouLinViewController;



@interface MainCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    
}
@property (nonatomic, weak)YouLinViewController *youlinVc;


@end
