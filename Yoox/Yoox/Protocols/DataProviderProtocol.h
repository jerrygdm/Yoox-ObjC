//
//  DataProviderProtocol.h
//  totembr
//
//  Created by Gianmaria Dal Maistro on 20/01/16.
//  Copyright © 2016 it.ennova. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProviderProtocol <NSObject>

- (id)getResourceWithURI:(NSString *)uri;

@optional
- (NSArray *)getResourcesList;
- (void)restoreCompletion;

@end
