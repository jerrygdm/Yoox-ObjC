//
//  Product.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "Product.h"

@interface Product ()

@property (nonatomic, strong) id <UrlGeneratorProtocol> urlGenerator;

@end

@implementation Product

- (id)initWithUrlGenerator:(id <UrlGeneratorProtocol>)urlGenerator
{
    if (self = [super init])
    {
        self.urlGenerator = urlGenerator;
    }
    return self;
}

- (NSString *)imageUrlString
{
    if (!_code10)
        return @"";

    return [self.urlGenerator generateUrlFromString:_code10];
}

- (NSString *)imageHiresUrlString
{
    if (!_code10)
        return @"";
    
    return [self.urlGenerator generateUrlFromString:_code10 type:ImageSizeTypeHires];
}

@end
