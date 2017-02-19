#import "AFNetworkManager.h"
#import "EXTScope.h"
#import "Blocks.h"
#import "ContentProviderProtocol.h"

@interface AFNetworkManager ()
@property (nonatomic, copy) NSString * baseUrlString;

@end

@implementation AFNetworkManager

+ (id)sharedManager
{
    static AFNetworkManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString * const BaseURLString = @"http://www.google.com";
        sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    return sharedManager;
}

#pragma mark - Initializer Methods
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self)
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html"]];
    }
    
    return self;
}

- (void)getContentWithLocation:(NSString *)location completion:(CompletionBlock)completionBlock
{
    [self getContentWithLocation:location parameters:nil httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self getContentWithLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters responseSerializer:(id <AFURLResponseSerialization>) serializer completion:(CompletionBlock)completionBlock
{
    [self getContentWithLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:serializer completion:completionBlock progressBlock:nil];
}

- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(DownloadProgressBlock)progressBlock;
{
    [self getContentWithLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:serializer completion:completionBlock progressBlock:progressBlock];
}

- (void)getContentWithLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(DownloadProgressBlock)progressBlock
{
    //    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self GET:location parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completionBlock)
            completionBlock(responseObject, nil);
        else
            DLog(@"C'è stato un problema nell'ottenere i dati.");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"Error: %@", error);
        
        id response = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response valueForKey:@"status"] boolValue] == NO)
            {
                NSString *message = response[@"message"];
                error = [NSError errorWithDomain:location code:[[response valueForKey:@"error_code"] intValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
    
    if (progressBlock)
        [self setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self postToLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters completion:(CompletionBlock)completionBlock
{
    [self postToLocation:location parameters:parameters httpHeaderParameters:headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock
{
    self.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self POST:location parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completionBlock)
            completionBlock(responseObject, nil);
        else
            DLog(@"C'è stato un problema nella post.");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"Error: %@", error);
        
        id response = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response valueForKey:@"status"] boolValue] == NO)
            {
                NSString *message = response[@"message"];
                error = [NSError errorWithDomain:location code:[[response valueForKey:@"error_code"] intValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
    
    if (progressBlock)
        [self setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }];
}

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self putToLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock
{
    self.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self PUT:location parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completionBlock)
            completionBlock(responseObject, nil);
        else
            DLog(@"C'è stato un problema nella PUT.");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"Error: %@", error);
        
        id response = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response valueForKey:@"status"] boolValue] == NO)
            {
                NSString *message = response[@"message"];
                error = [NSError errorWithDomain:location code:[[response valueForKey:@"error_code"] intValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
    
    if (progressBlock)
        [self setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }];
}

- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self deleteToLocation:location parameters:parameters httpHeaderParameters:nil responseSerializer:self.responseSerializer completion:completionBlock];
}

- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock
{
    self.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self DELETE:location parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completionBlock)
            completionBlock(responseObject, nil);
        else
            DLog(@"C'è stato un problema nella PUT.");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"Error: %@", error);
        
        id response = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response valueForKey:@"status"] boolValue] == NO)
            {
                NSString *message = response[@"message"];
                error = [NSError errorWithDomain:location code:[[response valueForKey:@"error_code"] intValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
}


- (void)uploadData:(NSData *)data paramName:(NSString *)paramName toLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self uploadData:data paramName:paramName toLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock];
}

- (void)uploadData:(NSData *)data paramName:(NSString *)paramName toLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock
{
    self.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self POST:location parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:paramName fileName:paramName mimeType:parameters[@"mimeType"]];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (completionBlock)
            completionBlock(responseObject, nil);
        else
            DLog(@"C'è stato un problema nella POST.");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"Error: %@", error);
        
        id response = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response valueForKey:@"status"] boolValue] == NO)
            {
                NSString *message = response[@"message"];
                error = [NSError errorWithDomain:location code:[[response valueForKey:@"error_code"] intValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
}

@end
