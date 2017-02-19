#import "DataRetriever.h"

@interface DataRetriever ()

@property (nonatomic, strong) id <ContentProviderProtocol> provider;
@property (nonatomic, strong) id <ParserProtocol> parser;

@end

@implementation DataRetriever

- (id)initWithContentProvider:(id <ContentProviderProtocol>)provider parser:(id <ParserProtocol>)parser
{
    if(self = [super init])
    {
        self.provider = provider;
        self.parser = parser;
    }
    
    return self;
}

- (void)retrieveWithLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self.provider getContentWithLocation:location parameters:parameters completion:^(id data, NSError *error) {
        if (data)
        {
            if (!parser)
                return;
            
            id parsedObject = [parser parseData:data];
            if (successBlock)
                successBlock(parsedObject);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
    }];
}

- (void)retrieveWithLocation:(NSString *)location usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self retrieveWithLocation:location parameters:nil usignParser:parser success:successBlock failure:failureBlock];
}

- (void)retrieveWithLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self retrieveWithLocation:location parameters:parameters usignParser:nil success:successBlock failure:failureBlock];
}

- (void)retrieveWithLocation:(NSString *)location success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self retrieveWithLocation:location usignParser:self.parser success:successBlock failure:failureBlock];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self.provider postToLocation:location parameters:parameters completion:^(id data, NSError *error) {
        if (data)
        {
            if (!parser)
                return;
            
            id parsedObject = [parser parseData:data];
            if (successBlock)
                successBlock(parsedObject);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
    }];
}

- (void)postToLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self postToLocation:location parameters:parameters usignParser:self.parser success:^(id data) {
        successBlock(data);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters usignParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self.provider putToLocation:location parameters:parameters completion:^(id data, NSError *error) {
        if (data)
        {
            if (!parser)
                return;
            
            id parsedObject = [parser parseData:data];
            if (successBlock)
                successBlock(parsedObject);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
    }];
}

- (void)putToLocation:(NSString *)location parameters:(NSDictionary *)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self putToLocation:location parameters:parameters usignParser:self.parser success:^(id data) {
        successBlock(data);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (void)deleteWithUrl:(NSString *)urlString parameter:(NSDictionary *)parameters usingParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self.provider deleteToLocation:urlString parameters:parameters completion:^(id data, NSError *error) {
        if (data)
        {
            if (!parser)
                return;
            
            id parsedObject = [parser parseData:data];
            if (successBlock)
                successBlock(parsedObject);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
    }];
}

- (void)uploadToUrl:(NSString *)urlString data:(NSData *)data paramName:(NSString *)paramName parameter:(NSDictionary *)parameters usingParser:(id <ParserProtocol>)parser success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self.provider uploadData:data paramName:paramName toLocation:urlString parameters:parameters completion:^(id data, NSError *error) {
        if (data)
        {
            if (!parser)
                return;
            
            id parsedObject = [parser parseData:data];
            if (successBlock)
                successBlock(parsedObject);
        }
        else
        {
            if (failureBlock)
                failureBlock(error);
        }
    }];
}

@end
