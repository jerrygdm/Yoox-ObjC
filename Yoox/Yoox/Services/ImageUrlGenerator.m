//
//  ImageUrlGenerator.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ImageUrlGenerator.h"

@interface ImageUrlGenerator ()

@property (nonatomic, strong) NSString *baseUrlString;

@end

@implementation ImageUrlGenerator

- (id)initWithBaseUrl:(NSString *)baseUrlString
{
    if (self = [super init])
    {
        self.baseUrlString = baseUrlString;
    }
    return self;
}

- (NSString *)generateUrlFromString:(NSString *)code type:(ImageSizeType)type
{
        return @"";    
}

- (NSString *)generateUrlFromString:(NSString *)code
{
    return [self generateUrlFromString:code type:ImageSizeTypeThumb];
}

@end
