#import <Foundation/Foundation.h>
@protocol ContentProviderProtocol;

@interface ContentProviderSelector : NSObject

- (id <ContentProviderProtocol>)getContentProvider;

@end
