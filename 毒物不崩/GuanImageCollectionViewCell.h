//
//  GuanImageCollectionViewCell.h
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanObj.h"
@interface GuanImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) GuanObj *obj;

@end
