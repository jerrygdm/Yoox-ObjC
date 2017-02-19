#import "AFNetworkOldSupportManager.h"
#import "EXTScope.h"
#import "Blocks.h"
#import "ContentProviderProtocol.h"

@interface AFNetworkOldSupportManager ()

@property (nonatomic, copy) NSString * baseUrlString;

@end

@implementation AFNetworkOldSupportManager

+ (id)sharedManager
{
    static AFNetworkOldSupportManager *sharedManager = nil;
    
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    AFHTTPRequestOperation *requestOperation = [manager GET:location parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                {
                                                    if (completionBlock)
                                                        completionBlock(responseObject, nil);
                                                    else
                                                        DLog(@"C'è stato un problema nell'ottenere i dati.");
                                                }
                                                    failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                {
                                                    DLog(@"Error: %@", error);
                                                    
                                                    id response = operation.responseObject;
                                                    
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
        [requestOperation setDownloadProgressBlock:progressBlock];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self postToLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [manager POST:location parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionBlock)
             completionBlock(responseObject, nil);
         else
             DLog(@"C'è stato un problema nella post.");
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"Error: %@", error);
         
         id response = operation.responseObject;
         
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

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self putToLocation:location parameters:parameters httpHeaderParameters:nil responseSerializer:self.responseSerializer completion:completionBlock progressBlock:nil];
}

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock progressBlock:(UploadProgressBlock)progressBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = serializer;
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [manager PUT:location parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionBlock)
             completionBlock(responseObject, nil);
         else
             DLog(@"C'è stato un problema nella PUT.");
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"Error: %@", error);
         
         id response = operation.responseObject;
         
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

- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters completion:(CompletionBlock)completionBlock
{
    [self deleteToLocation:location parameters:parameters httpHeaderParameters:self.headerParameters responseSerializer:self.responseSerializer completion:completionBlock];
}

- (void)deleteToLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters responseSerializer:(id <AFURLResponseSerialization>)serializer completion:(CompletionBlock)completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [manager DELETE:location parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionBlock)
             completionBlock(responseObject, nil);
         else
             DLog(@"C'è stato un problema nella PUT.");
     }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"Error: %@", error);
         
         id response = operation.responseObject;
         
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
    [self uploadData:data paramName:paramName toLocation:location parameters:parameters httpHeaderParameters:self.headerParameters completion:completionBlock];
}

- (void)uploadData:(NSData *)data paramName:(NSString *)paramName toLocation:(NSString *)location parameters:(NSDictionary *)parameters httpHeaderParameters:(NSDictionary *)headerParameters completion:(CompletionBlock)completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = self.responseSerializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [headerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    AFHTTPRequestOperation *op = [manager POST:location parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:data name:paramName fileName:parameters[@"name"] mimeType:parameters[@"mimeType"]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
}

@end
