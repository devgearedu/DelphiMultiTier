
#import <UIKit/UIKit.h>

#import "menu.h"
#import "AddTweet.h"
@class TCompanyTweet;
@class login;
@class Users;
@interface FollowingTweets : UITableViewController <menu,AddMyTweet>
{
	NSArray *list;
    IBOutlet login *loginView;
	IBOutlet UISearchBar *newTweet;

}

@property (nonatomic,retain) NSArray *list;
@property (nonatomic,retain) login *loginView;
@property (nonatomic,retain) UISearchBar *newTweet;

-(void)reloadTableListOfTweet:(NSArray *)params;


@end
