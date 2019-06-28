

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@class CallBackTweetCmd;
@class CallBackTweetUser;
@class CallBackTweetManager;
@class FollowingTweets;
@class TCompanyTweet;
@class TJSONObject;
@class login;


@interface Users : NSObject {
	NSArray *userList;
	NSMutableArray * tweetsList;
	CallBackTweetManager *   mnguser;
	CallBackTweetUser *   cbuser;
	CallBackTweetManager *   mngcmd;	
	CallBackTweetCmd * cbcmd;
	NSString * username;
	FollowingTweets *followingTweets;
	CFURLRef        soundTweetFileURLRef;
    SystemSoundID   soundTweetFileObject;
	
	CFURLRef        soundCmdFileURLRef;
    SystemSoundID   soundCmdFileObject;
	bool isLogged;
	NSString *hostValue;
	int portValue;
	login *loginView;
	 UINavigationController *navigationController;
	NSLock * msgLock;

}

@property (nonatomic,retain) NSString *hostValue;
@property(nonatomic) int portValue;
@property (nonatomic) bool isLogged;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

-(void) refreshListUsers;
-(void) followUser:(NSString *) name withValue:(BOOL) value;
-(void) setUsersToFollow;
-(void) logOut;
-(void) updateTweets:(TJSONObject *)params;
-(NSArray *) getListUsers;
-(NSArray *) getListTweets;
-(BOOL)loginUser:(NSString *) name withMessage:(out NSString **) returnmessage;
-(void)setFollowingTweets:(FollowingTweets *)pointer;
-(void)setLoginView:(login *)pointer;
-(NSString *)getUserName;
+(void) showErrorAlert:(NSException *) ex;

/*-(void)setHostValue:(NSString *)value;
-(NSString *)getHostValue;

-(void)setPortValue:(int) value;
-(int)getPortValue;
*/
@end




@interface Users (UsersCreation) 
+(id) getinstance;
+(void) releaseinstance;
@end


	
