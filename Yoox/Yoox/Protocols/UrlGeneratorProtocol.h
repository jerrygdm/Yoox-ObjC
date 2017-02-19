//
//  UrlGeneratorProtocol.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ImageSizeType) {
    ImageSizeTypeThumb,
    ImageSizeTypeHires
};

@protocol UrlGeneratorProtocol

- (NSString *)generateUrlFromString:(NSString *)code type:(ImageSizeType)type;
- (NSString *)generateUrlFromString:(NSString *)code;

@end
