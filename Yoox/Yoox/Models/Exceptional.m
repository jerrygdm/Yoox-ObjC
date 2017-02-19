//
//  Exceptional.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "Exceptional.h"

@implementation Exceptional

- (id)initWithValue:(id)value
{
    if(self = [super init])
    {
        self.value = value;
        self.valid = YES;
    }
    
    return self;
}

- (id)initWithError:(NSError *)error
{
    if(self = [super init])
    {
        self.error = error;
        self.valid = NO;
    }
    
    return self;
}

@end
