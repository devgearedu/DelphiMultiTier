#import <Foundation/Foundation.h>
#import "DBXValue.h"
/**
 * 
 * @brief Wraps the AnsiChars type and allows it to be null
 *
 */
@interface TDBXAnsiCharsValue : DBXValue {
	@protected bool ValueNull;
	@private NSString *DBXStringValue;
}





@end
