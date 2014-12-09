//
//  buildingAmenities.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/8/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buildingAmenities : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIView              *uiv_imgsContainer;
    NSMutableArray      *arr_catogoryImgs;
    
    NSArray             *arr_rawData;
    NSDictionary        *dict_collectionData;
    NSMutableArray      *arr_thumbs;
    NSMutableArray      *arr_images;
    
    UIView              *uiv_titleContainer;
    UIView              *uiv_backBtnContainer;
    
    UICollectionView    *uic_gallery;
}
@end
