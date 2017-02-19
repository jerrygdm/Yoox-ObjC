//
//  Product.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlGeneratorProtocol.h"

@interface Product : NSObject

- (id)initWithUrlGenerator:(id <UrlGeneratorProtocol>)urlGenerator;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *priceString;
@property (nonatomic, strong) NSString *imageUrlString;
@property (nonatomic, strong) NSString *imageHiresUrlString;

@property (nonatomic, strong) NSString *code10;

@end
