//
//  ProductListCollectionViewCell+Configure.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ProductListCollectionViewCell+Configure.h"
#import "Product.h"
@import SDWebImage;

@implementation ProductListCollectionViewCell (Configure)

- (void)configureCell:(Product *)item
{
    self.titleLabel.text = item.title;
    self.priceLabel.text = item.priceString;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrlString]
                 placeholderImage:[UIImage imageNamed:@"image-placeholder.png"]
                          options:SDWebImageRefreshCached];
}

@end
