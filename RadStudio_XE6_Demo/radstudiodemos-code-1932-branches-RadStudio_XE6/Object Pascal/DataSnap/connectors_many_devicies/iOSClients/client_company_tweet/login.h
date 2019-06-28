//*******************************************************
//
//               Delphi DataSnap Framework
//
// Copyright(c) 1995-2011 Embarcadero Technologies, Inc.
//
//*******************************************************


#import <UIKit/UIKit.h>
#import "Settings.h"

@class TCompanyTweet;

@class FollowerUsers;


@interface login : UIViewController <SettingsProtocol>
{
	IBOutlet UITextField *textFields;
	IBOutlet FollowerUsers *followerUsers;
	login *loginView;

}

@property(nonatomic,retain) UITextField *textFields;
@property(nonatomic,retain) FollowerUsers *followerUsers;

@property(nonatomic,retain) login *loginView;


-(IBAction)dissmissKeyboard: (id)sender;
-(IBAction)backgroundTouched: (id)sender;
-(void)login: (id)sender;
-(void)setConnection :(NSString *)host andSet:(int)port;
-(void)setTitlteOfNavigationBar:(NSString * )value;






@end
