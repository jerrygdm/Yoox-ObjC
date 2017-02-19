//
//  ImageUrlGenerator.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlGeneratorProtocol.h"

@interface ImageUrlGenerator : NSObject <UrlGeneratorProtocol>

- (id)initWithBaseUrl:(NSString *)baseUrlString;

@end
