#import <Foundation/Foundation.h>
#import "RetrievableProtocol.h"
#import "ContentProviderProtocol.h"
#import "ParserProtocol.h"

@interface DataRetriever : NSObject <RetrievableProtocol>

- (id)initWithContentProvider:(id <ContentProviderProtocol>)provider
                       parser:(id <ParserProtocol>)parser;

@end
