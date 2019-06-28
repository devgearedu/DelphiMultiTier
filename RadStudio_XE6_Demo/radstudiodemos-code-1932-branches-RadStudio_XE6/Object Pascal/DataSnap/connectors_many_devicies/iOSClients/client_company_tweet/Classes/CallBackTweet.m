
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
//*******************************************************
//
//               Delphi DataSnap Framework
//
// Copyright(c) 1995-2011 Embarcadero Technologies, Inc.
//
//*******************************************************


#import "CallBackTweet.h"
#import "Users.h"
#import "FollowingTweets.h"
#import "DSProxyExt.h"






@implementation CallBackTweetUser
 
@synthesize tweetusers,followingTweets;

-(void) updateCallBackTweets:(TJSONObject *)params{
	
	//to call an asincron method
	objc_msgSend(tweetusers, @selector(vibrateSound:),params);	
	objc_msgSend(tweetusers, @selector(updateTweets:),params);	
	
}
-(TJSONValue *) execute:(TJSONValue *) value andJSONTYPE:(int)jsonType{
	
	[self performSelectorOnMainThread:@selector(updateCallBackTweets:) withObject:value waitUntilDone:YES];
	
	
	return [ NSArray arrayWithObjects:@"{\"Hello\":\"World\"}",nil];

	return nil;
}

@end

@implementation CallBackTweetCmd
@synthesize tweetCmd;
-(void) sendSoundCallBack:(TJSONObject *)params{
	//to call an asincron method

	objc_msgSend(tweetCmd, @selector(vibrateSound:),params);	
}

-(TJSONValue *) execute:(TJSONValue *) value andJSONTYPE:(int)jsonType{
	
	[self performSelectorOnMainThread:@selector(sendSoundCallBack:) withObject:value waitUntilDone:YES];
	
	
	return [ NSArray arrayWithObjects:@"{\"Hello\":\"World\"}",nil];
	
	return nil;
}

@end

@implementation CallBackTweetManager


-(id)initWithChannel:(NSString *) channellname andcallBack:(DBXCallback *)acallback {
	self = [super init];
	if (self) {
		callback = [acallback retain];
	/*	conn = [[DSRESTConnection alloc]init];
		conn.Host = host;
		conn.protocol = @"http";
		conn.Port = [port;
	*/	
		NSString * managerid = [ NSString stringWithFormat:@"%i" ,arc4random()%100000];
		mng = [[DSCallbackChannelManager alloc]initWithConnection:[TCompanyTweet getConnectioninstance] 
													  withChannel:channellname 
													  withManagerID:managerid 
													  withDelegate:self	];

		
	}
	return self;
}



-(void)dealloc {

    [callback release];
	[mng release];
	[super dealloc];
}


-(void)registerUser: (NSString *) username{
	[mng registerCallback:username WithDBXCallBack:callback];
   
}
-(void)unregisterUser: (NSString *) username{
	[mng unregisterCallback:username]; 
	[mng closeClientChannel];
}
-(void) onCallbackError:(NSException* ) ex withManager:(DSCallbackChannelManager *) manager{ 
	if([[Users getinstance] respondsToSelector:@selector(connError:)]) {		
		objc_msgSend([Users getinstance]  , @selector(connError:),ex);}
	
		
	
}

@end
