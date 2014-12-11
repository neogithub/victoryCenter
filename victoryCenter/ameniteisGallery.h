//
//  ameniteisGallery.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/11/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ameniteisGallery : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray             *arr_rawData;
    UICollectionView    *uic_gallery;
}
@end
