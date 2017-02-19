#import "NetworkServiceLayer.h"
#import "DataRetriever.h"
#import "Exceptional.h"

#import "BaseResponseParser.h"
#import "ProductParser.h"

#import "Server.h"

#import "ExtScope.h"

#import "ContentProviderSelector.h"


@interface NetworkServiceLayer ()

@property (nonatomic, strong) id <ContentProviderProtocol> contentProvider;

@end

@implementation NetworkServiceLayer

- (id)init
{
    if (self = [super init])
    {
        self.contentProvider = [[ContentProviderSelector new] getContentProvider];
    }
    return self;
}

- (void)getProductListPage:(NSString *)page withCompletion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    ProductParser *parser = [ProductParser new];
    NSString *urlString = [[[Server sharedInstance] productList] stringByAppendingString:page];
    [self getWithUrl:urlString usingParser:parser completion:completionBlock failure:failureBlock];
}

- (void)getWithUrl:(NSString *)urlString usingParser:(id <ParserProtocol>)parser completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    DataRetriever *retriever = [[DataRetriever alloc] initWithContentProvider:self.contentProvider parser:parser];
    [retriever retrieveWithLocation:urlString success:^(id data) {
        DLog(@"JSON: %@", data);
        
        Exceptional *exceptional = data;
        
        if (exceptional.valid)
        {
            if (completionBlock)
                completionBlock(exceptional.value);
        }
        else
        {
            if (failureBlock)
                failureBlock([NSError errorWithDomain:@"REGISTRATION_ERROR" code:-1 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"REGISTRATION_ERROR", @"Impossibile effettuare la registrazione")}]);
        }
    } failure:^(NSError *error) {
        DLog(@"Error: %@", error);
        
        if (failureBlock)
            failureBlock(error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

- (void)postToUrl:(NSString *)urlString withParameters:(NSDictionary *)parameters completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    BaseResponseParser *baseParser = [[BaseResponseParser alloc] init];
    [self postToUrl:urlString withParameters:parameters parser:baseParser completion:completionBlock failure:failureBlock];
}

- (void)postToUrl:(NSString *)urlString withParameters:(NSDictionary *)parameters parser:(id <ParserProtocol>)parser completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    DataRetriever *retriever = [[DataRetriever alloc] initWithContentProvider:self.contentProvider parser:parser];
    [retriever postToLocation:urlString parameters:parameters success:^(id data) {
        Exceptional *exceptional = data;
        
        if (exceptional.valid)
        {
            if (completionBlock)
                completionBlock(exceptional.value);
        }
        else
        {
            DLog(@"Error Parsing data! : %@", data);
        }
    } failure:^(NSError *error) {
        DLog(@"Error: %@", error);
        
        if (failureBlock)
            failureBlock(error);
    }];
}

- (void)putToUrl:(NSString *)urlString withParameters:(NSDictionary *)parameters completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    BaseResponseParser *parser = [[BaseResponseParser alloc] init];
    [self putToUrl:urlString withParameters:parameters parser:parser completion:completionBlock failure:failureBlock];
}

- (void)putToUrl:(NSString *)urlString withParameters:(NSDictionary *)parameters parser:(id <ParserProtocol>)parser completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    DataRetriever *retriever = [[DataRetriever alloc] initWithContentProvider:self.contentProvider parser:parser];
    [retriever putToLocation:urlString parameters:parameters success:^(id data) {
        Exceptional *exceptional = data;
        
        if (exceptional.valid)
        {
            if (completionBlock)
                completionBlock(exceptional.value);
        }
        else
        {
            DLog(@"Error Parsing data! : %@", data);
        }
    } failure:^(NSError *error) {
        DLog(@"Error: %@", error);
        
        if (failureBlock)
            failureBlock(error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

- (void)deleteWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters usingParser:(id <ParserProtocol>)parser completion:(SuccessBlock)completionBlock failure:(FailureBlock)failureBlock
{
    DataRetriever *retriever = [[DataRetriever alloc] initWithContentProvider:self.contentProvider parser:parser];    
    [retriever deleteWithUrl:urlString parameter:parameters usingParser:parser success:^(id data) {
        Exceptional *exceptional = data;
        if (exceptional.valid)
        {
            if (completionBlock)
                completionBlock(exceptional.value);
        }
        else
        {
            DLog(@"Error Parsing data! : %@", data);
        }
    } failure:^(NSError *error) {
        DLog(@"Error: %@", error);
        if (failureBlock)
            failureBlock(error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

@end
