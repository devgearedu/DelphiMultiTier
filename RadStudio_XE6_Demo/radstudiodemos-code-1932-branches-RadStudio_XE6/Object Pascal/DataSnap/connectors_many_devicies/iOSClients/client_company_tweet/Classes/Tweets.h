

#import <UIKit/UIKit.h>
@class FollowerUsers;

@interface Tweets : UIViewController {
	IBOutlet FollowerUsers *foll;

}
@property(nonatomic,retain) FollowerUsers *foll;
-(IBAction)test;

@end
