
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------


#import "DSProxyExt.h"


@implementation TCompanyTweet(CompanyTweetSingleton) 

static TCompanyTweet *instanceProxy = NULL;
static DSRESTConnection *instanceConnetion = NULL;

+(id) getProxyinstance{
	if (!instanceProxy) {
		instanceProxy = [[TCompanyTweet alloc]initWithConnection:[TCompanyTweet getConnectioninstance]];
	}
	return instanceProxy;
}

+(void) releaseProxyinstance{
	if (instanceProxy) {
		[instanceProxy release];
		instanceProxy = nil;
		
	}
}

+(DSRESTConnection*) getConnectioninstance{
	if (!instanceConnetion) {
		instanceConnetion =[[DSRESTConnection alloc]init];
	}
	return instanceConnetion;
}

+(void) releaseConnectioninstance{
	if (instanceConnetion) 
	{
		[instanceConnetion release];
		instanceConnetion = nil;
		
		
	}
}
@end	