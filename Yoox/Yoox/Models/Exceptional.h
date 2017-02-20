//
//  Exceptional.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exceptional : NSObject

@property (strong, nonatomic) id value;
@property (strong, nonatomic) NSError *error;
@property (assign, nonatomic, getter = isValid) BOOL valid;

- (id)initWithValue:(id)value;

- (id)initWithError:(NSError *)error;

@end
