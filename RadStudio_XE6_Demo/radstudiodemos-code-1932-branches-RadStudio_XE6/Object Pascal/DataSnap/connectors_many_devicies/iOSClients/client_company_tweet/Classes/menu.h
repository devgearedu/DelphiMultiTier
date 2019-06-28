
#import <UIKit/UIKit.h>
@class TCompanyTweet;
@class login;
@class FollowerUsers;

@protocol menu <NSObject>

-(void)didDismissModalViewMenu; 
@end


@interface menu : UIViewController {
	IBOutlet UIButton *listUsers;
	id<menu> delegateMenu;
	IBOutlet login *loginView;
	IBOutlet FollowerUsers *followerUsersView;

}

@property (nonatomic,assign) id<menu> delegateMenu;
@property (nonatomic,retain) UIButton *listUsers;
@property (nonatomic,retain) login *loginView;
@property (nonatomic,retain) FollowerUsers *followerUsersView;
-(IBAction)logOut;
-(IBAction)goToFollowUsers;
@end
