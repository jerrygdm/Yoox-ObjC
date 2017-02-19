#import <UIKit/UIKit.h>

#import "ContentProviderSelector.h"
#import "ContentProviderProtocol.h"

#import "AFNetworkManager.h"
#import "AFNetworkOldSupportManager.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ContentProviderSelector ()

@property (nonatomic, strong) id <ContentProviderProtocol> contentProvider;

@end

@implementation ContentProviderSelector

- (id <ContentProviderProtocol>)getContentProvider
{
    if (!self.contentProvider)
    {
        if SYSTEM_VERSION_LESS_THAN(@"7.0")
        {
            AFNetworkOldSupportManager* manager = [AFNetworkOldSupportManager manager];
            manager.securityPolicy.allowInvalidCertificates = YES;
            manager.securityPolicy.validatesDomainName = NO;
            self.contentProvider = manager;
        }
        else
        {
            AFNetworkManager* manager = [AFNetworkManager manager];
            manager.securityPolicy.allowInvalidCertificates = YES;
            manager.securityPolicy.validatesDomainName = NO;
            self.contentProvider = manager;
        }
    }

    return self.contentProvider;
}

@end
