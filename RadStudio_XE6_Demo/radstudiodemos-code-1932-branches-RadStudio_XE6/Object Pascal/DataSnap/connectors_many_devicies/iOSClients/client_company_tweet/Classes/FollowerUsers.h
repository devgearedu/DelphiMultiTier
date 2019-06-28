
#import <UIKit/UIKit.h>

@class FollowingTweets;
@class TCompanyTweet;
@class login;


@interface FollowerUsers : UITableViewController {
	NSArray *users;
	IBOutlet FollowingTweets *followingtweets;
	IBOutlet login *loginView;
	}
@property (nonatomic,retain) NSArray *users;
@property (nonatomic,retain) FollowingTweets *followingtweets;
@property (nonatomic,retain) login *loginView;

-(void)updateTweet;
-(void)next;
-(void)follow:(id)sender;
@end
