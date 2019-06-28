
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

#import "Users.h"
#import "TJSONArray.h"
#import "CallBackTweet.h"
#import "FollowingTweets.h"
#import "DSProxyExt.h"
#import "login.h"
#import "IOS2AppDelegate.h"



@implementation Users
@synthesize hostValue;
@synthesize portValue;
@synthesize isLogged,navigationController;

-(id) init {
	self = [super init];
	if (self) {
		msgLock = [[NSLock alloc] init];
		isLogged = false;
		userList = [[NSMutableDictionary alloc] initWithCapacity:0];	
		tweetsList = [[NSMutableArray alloc] initWithCapacity:0];
		cbuser = [[CallBackTweetUser alloc]init];
		cbcmd = [[CallBackTweetCmd alloc]init];
		cbuser.tweetusers= (Users *)self;
		cbcmd.tweetCmd = (Users *)self;
		followingTweets = nil;
	
		 
		 // Tweet sound
		 NSURL *tapSoundTweet   = [[NSBundle mainBundle] URLForResource: @"tweet"  withExtension: @"mp3"];
		 
		 // Store the URL as a CFURLRef instance
		 soundTweetFileURLRef = (CFURLRef) [tapSoundTweet retain];
		 
		 // Create a system sound object representing the sound file.
		 AudioServicesCreateSystemSoundID ( soundTweetFileURLRef, &soundTweetFileObject );
		 
		//----------------------------//
		//cmd sound
		NSURL *tapSoundCmd   = [[NSBundle mainBundle] URLForResource: @"cmd"  withExtension: @"mp3"];
		
		// Store the URL as a CFURLRef instance
		soundCmdFileURLRef = (CFURLRef) [tapSoundCmd retain];
		
		// Create a system sound object representing the sound file.
		AudioServicesCreateSystemSoundID ( soundCmdFileURLRef, &soundCmdFileObject );
		
		
	
		hostValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"HOST"];
		portValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"PORT"];
		
		//default settings about host and port
		if ([hostValue isEqualToString:@""]||!(hostValue)) {
			hostValue = @"datasnap.embarcadero.com";
		}
		if (portValue <= 0) {
			portValue = 8086;

		}
				

		
		
	}
	return self;
}
-(void) dealloc{
	[msgLock release];
    [followingTweets release];
	[loginView release];
	[tweetsList release];
	[username release];
	[userList release];
	[cbuser release];
	[cbcmd release];
	[hostValue release];
	[navigationController release];
	
	
	AudioServicesDisposeSystemSoundID ((long)soundTweetFileURLRef);
    CFRelease ((CFTypeRef) soundTweetFileObject);
	AudioServicesDisposeSystemSoundID ((long)soundCmdFileURLRef);
    CFRelease ((CFTypeRef)soundCmdFileObject);
	
	[super dealloc];
}






-(void)setFollowingTweets:(FollowingTweets *)pointer{
	followingTweets = pointer;
}

-(void)setLoginView:(login *)pointer{
	loginView = pointer;
}

-(NSString *)getUserName{
	return username;
}

-(void) followUser:(NSString *) name withValue:(BOOL) value{
	NSString * newusername;

	 for (NSMutableDictionary * user in userList) {
		newusername =	[user objectForKey:@"username"];
		if ([newusername isEqualToString:name] ) {
			[user setObject:[NSNumber numberWithBool:value]  forKey:@"followed"]; 
			break;
		}
  	}
	NSLog(@"%@",[userList description]);
}

-(void)refreshListUsers{
	TJSONArray *newUserarray = [[[TCompanyTweet getProxyinstance] UsersList]retain];
	@try {
		NSLog(@" refresh list :  %@",[[newUserarray asJSONArray] description]);
		[userList release];
		 userList = (NSArray *)[newUserarray asJSONArray];
		[userList retain];
	}
	@finally {
		[newUserarray release];
	}
}

-(NSArray *) getListUsers {
  return userList;
}


-(void)setUsersToFollow{
	BOOL value;
	NSMutableArray *listUserToFollow = [[NSMutableArray arrayWithCapacity:0]retain];
	for (NSMutableDictionary * user in userList) {
		value =	[[user objectForKey:@"followed"] boolValue];
		if (value) 
			  [listUserToFollow addObject:[user objectForKey:@"username"]]; 
  	}
	TJSONArray *list = [[TJSONArray alloc] initWithJSONArray: listUserToFollow];
	NSLog(@"%@ ",[list asJSONString]);
	@try {

		[[TCompanyTweet getProxyinstance] SetUsersToFollow:list];
	}@finally {
		[list release];
		[listUserToFollow release];
	}
		
	
}

-(NSArray *) getListTweets{
	return tweetsList;
}

// Update the list of messages whene a tweet come
-(void)updateTweets:(TJSONObject *)params{
	
	
	NSLog(@" tweet json : %@",[params toString]);
    [tweetsList addObject:[params asJSONObject]];
	NSLog(@"tweet arrived %@", [tweetsList description]);
    objc_msgSend(followingTweets, @selector(reloadTableListOfTweet:),tweetsList);
}



-(void) connError:(NSException *) error{
	
	  
	[msgLock lock];
	@try {
		if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground){
			
			if([self.navigationController.topViewController respondsToSelector:@selector(returnToLogin)]) {
				objc_msgSend(self.navigationController.topViewController , @selector(returnToLogin),nil);}
			
			
			if( self.navigationController.topViewController == loginView ){		
				
				[Users showErrorAlert:error];
				
			}
		}
	}
	@finally {
		[msgLock unlock];
	}
	

	
	
}



// sound
-(void)vibrateSound:(TJSONObject *)params{
	NSLog(@" sound - vibrate : %@",[params toString]);
	NSString * value =	[params getStringForKey:@"cmd"];
	if ([value isEqualToString:@"vibrate"] || [value isEqualToString:@"ring"]) {
		AudioServicesPlaySystemSound(soundCmdFileObject);
		if ([value isEqualToString:@"vibrate"]){
			//on device we vibrate  
		   AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
		}
	}
	else {
		AudioServicesPlaySystemSound(soundTweetFileObject);
	}
	
}


-(BOOL)loginUser:(NSString *)name withMessage:(out NSString **) returnmessage 
{
	NSString * retmsg; 
	[username release];
	username = [name retain];
	[tweetsList removeAllObjects];
	BOOL ifLogin =  [[TCompanyTweet getProxyinstance] LoginUser:name withReturnMessage:&retmsg];
	*returnmessage = retmsg;
	
	mngcmd = [[CallBackTweetManager alloc] initWithChannel:@"cmd" andcallBack:cbcmd  ];	
	[mngcmd registerUser:@"cbcmd"];

	mnguser = [[CallBackTweetManager alloc] initWithChannel:@"ct" andcallBack:cbuser ];
	[mnguser registerUser:username];
	
	isLogged = ifLogin;	 
	return ifLogin;
}

-(void) logOut{
	
	[mngcmd unregisterUser: username];
	[mngcmd release];
	[mnguser unregisterUser:@"cbcmd"];
	[mnguser release];
	isLogged = false;
	[[TCompanyTweet getProxyinstance] Logout];
	[TCompanyTweet releaseProxyinstance]; 
	[TCompanyTweet releaseConnectioninstance];
}


+(void) showErrorAlert:(NSException *) ex{

	if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground){
	NSString * msg;
	msg = [ex reason];

	if ([ex userInfo])
	{ 
		if ([[ex userInfo] objectForKey:@"NSLocalizedDescription"]) {
			msg = [[ex userInfo] objectForKey:@"NSLocalizedDescription"];
		}
		
	}
	else {
		msg = [ex reason]; 
	}
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Connection faild" message:[NSString stringWithFormat:@"%@",msg] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]autorelease];
			[alert show];}
	
}
@end

@implementation Users (UsersCreation) 
 
static Users *instanceUsers = NULL;


+(id) getinstance{
	if (!instanceUsers) {
		instanceUsers = [[Users alloc]init];
	}
	return instanceUsers;
}

+(void) releaseinstance{
	if (instanceUsers) {
		[instanceUsers release];
		instanceUsers = nil;
	}
}
@end
