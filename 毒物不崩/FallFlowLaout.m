//
//  FallFlowLaout.m
//  毒物
//
//  Created by 一羞 on 16/9/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FallFlowLaout.h"
@interface FallFlowLaout ()
@property (nonatomic) NSMutableArray *datas;
@end
@implementation FallFlowLaout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}
- (void)prepareLayout{
    [super prepareLayout];
    [self.datas removeAllObjects];
   // self.itemSize = CGSizeMake(SW, 300);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    for (int i = 0; i < self.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.datas addObject:att];
    
    }
    
}
-(CGSize)collectionViewContentSize
{
    int count = (int)([self layoutAttributesForElementsInRect:[UIScreen mainScreen].bounds].count);
   // NSLog(@"%d",count);
    CGFloat height = SW*213.0/321+48 + (10+(SW-30)/2+48)*(count -1)/2;
    return  CGSizeMake(SW, height);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.datas;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
         UICollectionViewLayoutAttributes *att = [super layoutAttributesForItemAtIndexPath:indexPath];
        long section = (indexPath.row-1)/2;
        long row = (indexPath.row-1)%2;
    if (indexPath.row == 0) {
        att.frame = CGRectMake(0, 0, SW, SW*213.0/321+48);
    }
    else{
        att.frame = CGRectMake(10+((SW-30)/2+10)*row, SW*213.0/321+10+48+(10+(SW-30)/2+48)*section, (SW-30)/2, (SW-30)/2+48);
    }
    return att;
    }

- (NSMutableArray *)datas {
	if(_datas == nil) {
		_datas = [[NSMutableArray alloc] init];
	}
	return _datas;
}

@end
