//
//  Blocks.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#ifndef Blocks_h
#define Blocks_h

typedef void (^CompletionBlock)(id data, NSError *error);

typedef void (^DownloadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);
typedef void (^UploadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

typedef void (^SuccessBlock)(id data);
typedef void (^FailureBlock)(NSError *error);

typedef NSDictionary * (^ParameterGeneratorBlock)(id data);

#endif /* Blocks_h */
