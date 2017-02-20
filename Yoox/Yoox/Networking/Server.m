#import "Server.h"

@implementation Server

+ (id)sharedInstance
{
	static Server *server = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^
	{
		server = [[self alloc] init];
	});
	return server;
}

- (id)init
{
	if (self = [super init])
	{
        self.baseUrl = @"http://api.yoox.biz/YooxCore.API/1.0/YOOX_US/SearchResults?dept=women&Gender=D&noItems=0&noRef=0&";

        self.productList = [NSString stringWithFormat:@"%@page=", self.baseUrl];
    }
	
	return self;
}

@end
