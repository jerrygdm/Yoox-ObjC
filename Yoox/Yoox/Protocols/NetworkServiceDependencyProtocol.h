//
//  NetworkServiceDependencyProtocol.h
//  Skillo
//
//  Created by Gianmaria Dal Maistro on 12/01/16.
//  Copyright © 2016 it.ennova.myhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkServiceProtocol;

@protocol NetworkServiceDependencyProtocol <NSObject>

@property (nonatomic, readonly) id <NetworkServiceProtocol> networkService;

@end
