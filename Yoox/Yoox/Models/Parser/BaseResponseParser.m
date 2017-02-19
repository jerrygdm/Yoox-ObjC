//
//  BaseResponseParser.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "BaseResponseParser.h"
#import "Exceptional.h"

@interface BaseResponseParser ()

@end

@implementation BaseResponseParser

- (id)parseData:(id)data
{
    if (![data isKindOfClass:[NSDictionary class]])
        return nil;
    
    if ([[data valueForKey:@"ErrorCode"] integerValue] == 0)
        return [[Exceptional alloc] initWithValue:data];
    
    NSError *err = [NSError errorWithDomain:@"some_domain"
                                       code:[data[@"ErrorCode"] integerValue]
                                   userInfo:@{NSLocalizedDescriptionKey: data[@"ErrorCode"]
                                              }];
    
    return [[Exceptional alloc] initWithError:err];
}

@end
