

#import <Foundation/Foundation.h>
#import  "DSProxy.h"



@interface TCompanyTweet(CompanyTweetSingleton) 
+(id) getProxyinstance;
+(void) releaseProxyinstance;
+(DSRESTConnection*) getConnectioninstance;
+(void) releaseConnectioninstance;

@end