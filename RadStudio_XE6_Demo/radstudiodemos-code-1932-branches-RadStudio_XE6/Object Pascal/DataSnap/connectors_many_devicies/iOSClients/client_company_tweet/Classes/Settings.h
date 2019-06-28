

#import <UIKit/UIKit.h>
@class Users;


@protocol SettingsProtocol <NSObject>
-(void)didDismissModalViewSettings; 
-(void) set:(NSString *)host andSet:(NSString *)port;
@end

@interface Settings : UIViewController {
  	id<SettingsProtocol> delegateSettings;
	IBOutlet UITextField *hostText;
	IBOutlet UITextField *portText;
	IBOutlet UIButton *save;

}


@property(nonatomic,assign) id<SettingsProtocol> delegateSettings;
@property(nonatomic,retain)  UITextField *hostText;
@property(nonatomic,retain)  UITextField *portText;
@property(nonatomic,retain)  UIButton *save;


-(IBAction)Save;


@end
