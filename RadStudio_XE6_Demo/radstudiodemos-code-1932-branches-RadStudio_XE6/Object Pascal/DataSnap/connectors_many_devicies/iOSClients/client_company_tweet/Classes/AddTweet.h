

#import <UIKit/UIKit.h>



@protocol AddMyTweet <NSObject>

-(void)didDismissModalViewAddMyTweet;
-(void)myTweet:(NSString *)textMyTweet;

@end
@interface AddTweet : UIViewController {
	
	IBOutlet UIButton *buttonOk;
	IBOutlet UITextView *textTweet;
	id<AddMyTweet> delegateTweet;

}
@property (nonatomic,retain)UIButton *buttonOk;
@property (nonatomic,retain)UITextView *textTweet;
@property (nonatomic,assign) id<AddMyTweet> delegateTweet;
-(IBAction)insertTweet;


@end
