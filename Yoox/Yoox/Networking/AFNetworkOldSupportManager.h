@import AFNetworking;
@protocol ContentProviderProtocol;

@interface AFNetworkOldSupportManager : AFHTTPRequestOperationManager <ContentProviderProtocol>

+ (id)sharedManager;
@property (nonatomic, readwrite) NSDictionary *headerParameters;

@end
