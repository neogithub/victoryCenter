//
//  CVCell.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galleryCVCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *cellThumb;
@property (weak, nonatomic) IBOutlet UIImageView *cellFrame;

@end
