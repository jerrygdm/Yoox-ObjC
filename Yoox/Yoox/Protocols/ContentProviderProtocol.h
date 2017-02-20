//
//  ContentProviderProtocol.h
//  sosdigital
//
//  Created by Gianmaria Dal Maistro on 14/09/15.
//  Copyright (c) 2015 it.ennova.myhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"
@protocol AFURLResponseSerialization;

@protocol ContentProviderProtocol <NSObject>

@property (nonatomic, readwrite) NSDictionary *headerParameters;

- (void)getContentWithLocation:(NSString *)location completion:(CompletionBlock)completionBlock;
- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock;
- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock;
- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock;
- (void)uploadData:(NSData *)data paramName:(NSString *)paramName toLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock;

@optional
- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock;
- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(DownloadProgressBlock)progressBlock;
- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(DownloadProgressBlock)progressBlock;
- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock;
- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock;
- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock;

@end
