#import <Foundation/Foundation.h>

@interface Server : NSObject

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, copy) NSString *productList;

+ (id)sharedInstance;

@end
