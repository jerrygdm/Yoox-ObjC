//
//  AFNetworkManager.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 14/09/15.
//  Copyright (c) 2015 it.ennova.myhd. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AFNetworking;

@protocol ContentProviderProtocol;

@interface AFNetworkManager : AFHTTPSessionManager <ContentProviderProtocol>

+ (id)sharedManager;
@property (nonatomic, readwrite) NSDictionary *headerParameters;

@end
