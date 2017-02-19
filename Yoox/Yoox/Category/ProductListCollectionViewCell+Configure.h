//
//  ProductListCollectionViewCell+Configure.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ProductListCollectionViewCell.h"
@class Product;

@interface ProductListCollectionViewCell (Configure)

- (void)configureCell:(Product *)item;

@end
