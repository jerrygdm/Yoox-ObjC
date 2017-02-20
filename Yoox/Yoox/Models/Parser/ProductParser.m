//
//  ProductParser.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ProductParser.h"
#import "Exceptional.h"
#import "Product.h"

#import "ImageUrlGenerator.h"

#define kBaseImageUrlString @"http://cdn.yoox.biz/"

@interface ProductParser ()

@end

@implementation ProductParser

- (id)parseData:(id)data
{
    Exceptional *exceptional = [super parseData:data];
    
    if (![exceptional.value isKindOfClass:[NSDictionary class]])
        return [[Exceptional alloc] initWithError:[NSError errorWithDomain:@"Service" code:100 userInfo:nil]];
    
    if (!data || ![data isKindOfClass:[NSDictionary class]])
        return nil;
    
    id items = data[@"Items"];
    if (!items)
        return nil;
    
    if ([items isKindOfClass:[NSArray class]])
    {
        ImageUrlGenerator *imageGenerator = [[ImageUrlGenerator alloc] initWithBaseUrl:kBaseImageUrlString];
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for (NSDictionary *dict in items)
        {
            Product *product = [[Product alloc] initWithUrlGenerator:imageGenerator];

            product.title = (dict[@"Brand"] && ![dict[@"Brand"] isEqual:[NSNull null]]) ? dict[@"Brand"] : @"";
            product.priceString = (dict[@"FormattedFullPrice"] && ![dict[@"FormattedFullPrice"] isEqual:[NSNull null]]) ? dict[@"FormattedFullPrice"] : @"";

            product.code10 = (dict[@"Cod10"] && ![dict[@"Cod10"] isEqual:[NSNull null]]) ? dict[@"Cod10"] : @"";
            
            //DLog(product.imageUrlString);
            [resultArray addObject:product];
        }
        
        return [[Exceptional alloc] initWithValue:resultArray];
    }
    
    return nil;
}

@end
