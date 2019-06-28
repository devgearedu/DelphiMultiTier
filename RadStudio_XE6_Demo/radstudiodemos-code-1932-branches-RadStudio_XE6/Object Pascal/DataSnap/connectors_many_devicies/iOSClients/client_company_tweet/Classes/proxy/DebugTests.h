
#import <Foundation/Foundation.h>
#import "DSCallbackChannelManager.h"
#import <UIKit/UIKit.h>



@interface DebugTests : NSObject {

}
+(bool) similarDouble:(double) value1 withOther: (double) value2;
+(bool) similarFloat:(float) value1 withOther: (float) value2;
+(NSDictionary *) CreateJSONObject;
+(void) ExecuteTests;
@end


@interface MyCallBack: DBXCallback{
	UITextView* textView;
}
@property (retain,nonatomic) UITextView* textView;

@end