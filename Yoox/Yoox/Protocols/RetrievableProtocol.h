//
//  RetrievableProtocol.h
//  sosdigital
//
//  Created by Gianmaria Dal Maistro on 14/09/15.
//  Copyright (c) 2015 it.ennova.myhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

@protocol ParserProtocol;

@protocol RetrievableProtocol <NSObject>

- (void)retrieveWithLocation:(NSString *)location success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)deleteWithUrl:(NSString *)urlString parameter:(NSDictionary *)parameters usingParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)uploadToUrl:(NSString *)urlString data:(NSData *)data paramName:(NSString *)paramName parameter:(NSDictionary *)parameters usingParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@optional
- (void)retrieveWithLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)retrieveWithLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)retrieveWithLocation:(NSString *)location usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
