//
//  GuanCollectionViewCell.h
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *lanel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic,copy) NSString *uid;
@end
