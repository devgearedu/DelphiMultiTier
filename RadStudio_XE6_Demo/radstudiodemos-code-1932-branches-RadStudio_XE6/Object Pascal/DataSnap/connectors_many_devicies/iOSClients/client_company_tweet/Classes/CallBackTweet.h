//*******************************************************
//
//               Delphi DataSnap Framework
//
// Copyright(c) 1995-2011 Embarcadero Technologies, Inc.
//
//*******************************************************


#import <Foundation/Foundation.h>
#import "DSCallbackChannelManager.h"
@class Users;
@class FollowingTweets;





@interface CallBackTweetUser : DBXCallback
{
	Users * tweetusers;	
	FollowingTweets *followingTweets;
	
	
	
}
@property (retain,nonatomic)Users * tweetusers;	
@property (retain,nonatomic)FollowingTweets * followingTweets;	


@end
@interface CallBackTweetCmd : DBXCallback
{
		Users * tweetCmd;	
	
}
@property (retain,nonatomic)Users * tweetCmd;	


@end

@interface CallBackTweetManager : NSObject {
	DSCallbackChannelManager *mng;
	DBXCallback * callback;

}
-(id)initWithChannel:(NSString *) channellname andcallBack:(DBXCallback *)acallback;
-(void)registerUser: (NSString *) username;
-(void)unregisterUser: (NSString *) username;

@end
