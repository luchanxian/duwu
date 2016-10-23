//
//  CollectionViewController.h
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
@property (nonatomic) int sortNum ;
@property (nonatomic) int count;
-(void)loadData;
-(void)loadMore;
@end
