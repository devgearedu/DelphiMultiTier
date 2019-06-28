
#import <UIKit/UIKit.h>
#import "login.h"
@class TCompanyTweet;
@interface IOS2AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    IBOutlet login *loginView;
	
    UINavigationController *navigationController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,retain) login *loginView;

@end

