//
//  NetworkServiceProtocol.h
//  Skillo
//
//  Created by Gianmaria Dal Maistro on 11/01/16.
//  Copyright © 2016 it.ennova.myhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

@protocol NetworkServiceProtocol <NSObject>

- (void)getProductListPage:(NSString *)page withCompletion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock;

@end
